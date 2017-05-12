package kabam.rotmg.appengine.impl {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import kabam.rotmg.appengine.api.RetryLoader;

import org.osflash.signals.OnceSignal;

public class AppEngineRetryLoader implements RetryLoader {

    private const _complete:OnceSignal = new OnceSignal(Boolean);

    private var maxRetries:int;
    private var dataFormat:String;
    private var url:String;
    private var params:Object;
    private var urlRequest:URLRequest;
    private var urlLoader:URLLoader;
    private var retriesLeft:int;
    private var inProgress:Boolean;

    public function AppEngineRetryLoader() {
        this.inProgress = false;
        this.maxRetries = 0;
        this.dataFormat = URLLoaderDataFormat.TEXT;
    }

    public function get complete():OnceSignal {
        return (this._complete);
    }

    public function isInProgress():Boolean {
        return (this.inProgress);
    }

    public function setDataFormat(_arg1:String):void {
        this.dataFormat = _arg1;
    }

    public function setMaxRetries(_arg1:int):void {
        this.maxRetries = _arg1;
    }

    public function sendRequest(_arg1:String, _arg2:Object):void {
        this.url = _arg1;
        this.params = _arg2;
        this.retriesLeft = this.maxRetries;
        this.inProgress = true;
        this.internalSendRequest();
    }

    private function internalSendRequest():void {
        this.cancelPendingRequest();
        this.urlRequest = this.makeUrlRequest();
        this.urlLoader = this.makeUrlLoader();
        this.urlLoader.load(this.urlRequest);
    }

    private function makeUrlRequest():URLRequest {
        var _local1:URLRequest = new URLRequest(this.url);
        _local1.method = URLRequestMethod.POST;
        _local1.data = this.makeUrlVariables();
        return (_local1);
    }

    private function makeUrlVariables():URLVariables {
        var _local2:String;
        var _local1:URLVariables = new URLVariables();
        _local1.ignore = getTimer();
        for (_local2 in this.params) {
            _local1[_local2] = this.params[_local2];
        }
        return (_local1);
    }

    private function makeUrlLoader():URLLoader {
        var _local1:URLLoader = new URLLoader();
        _local1.dataFormat = this.dataFormat;
        _local1.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        _local1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        _local1.addEventListener(Event.COMPLETE, this.onComplete);
        return (_local1);
    }

    private function onIOError(_arg1:IOErrorEvent):void {
        this.inProgress = false;
        var _local2:String = this.urlLoader.data;
        if (_local2.length == 0) {
            _local2 = "Unable to contact server";
        }
        this.retryOrReportError(_local2);
    }

    private function onSecurityError(_arg1:SecurityErrorEvent):void {
        this.inProgress = false;
        this.cleanUpAndComplete(false, "Security Error");
    }

    private function retryOrReportError(_arg1:String):void {
        if (this.retriesLeft-- > 0) {
            this.internalSendRequest();
        }
        else {
            this.cleanUpAndComplete(false, _arg1);
        }
    }

    private function onComplete(_arg1:Event):void {
        this.inProgress = false;
        if (this.dataFormat == URLLoaderDataFormat.TEXT) {
            this.handleTextResponse(this.urlLoader.data);
        }
        else {
            this.cleanUpAndComplete(true, ByteArray(this.urlLoader.data));
        }
    }

    private function handleTextResponse(_arg1:String):void {
        if (_arg1.substring(0, 7) == "<Error>") {
            this.retryOrReportError(_arg1);
        }
        else {
            if (_arg1.substring(0, 12) == "<FatalError>") {
                this.cleanUpAndComplete(false, _arg1);
            }
            else {
                this.cleanUpAndComplete(true, _arg1);
            }
        }
    }

    private function cleanUpAndComplete(_arg1:Boolean, _arg2:*):void {
        if (((!(_arg1)) && ((_arg2 is String)))) {
            _arg2 = this.parseXML(_arg2);
        }
        this.cancelPendingRequest();
        this._complete.dispatch(_arg1, _arg2);
    }

    private function parseXML(_arg1:String):String {
        var _local2:Array = _arg1.match("<.*>(.*)</.*>");
        return (((((_local2) && ((_local2.length > 1)))) ? _local2[1] : _arg1));
    }

    private function cancelPendingRequest():void {
        if (this.urlLoader) {
            this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
            this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this.urlLoader.removeEventListener(Event.COMPLETE, this.onComplete);
            this.closeLoader();
            this.urlLoader = null;
        }
    }

    private function closeLoader():void {
        try {
            this.urlLoader.close();
        }
        catch (e:Error) {
        }
    }


}
}
