package kabam.rotmg.appengine.impl {
import com.company.assembleegameclient.parameters.Parameters;

import flash.net.URLLoaderDataFormat;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.appengine.api.RetryLoader;
import kabam.rotmg.application.api.ApplicationSetup;

import org.osflash.signals.OnceSignal;

public class SimpleAppEngineClient implements AppEngineClient {

    [Inject]
    public var loader:RetryLoader;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var account:Account;
    private var isEncrypted:Boolean;
    private var maxRetries:int;
    private var dataFormat:String;

    public function SimpleAppEngineClient() {
        this.isEncrypted = true;
        this.maxRetries = 0;
        this.dataFormat = URLLoaderDataFormat.TEXT;
    }

    public function get complete():OnceSignal {
        return (this.loader.complete);
    }

    public function setDataFormat(_arg1:String):void {
        this.loader.setDataFormat(_arg1);
    }

    public function setSendEncrypted(_arg1:Boolean):void {
        this.isEncrypted = _arg1;
    }

    public function setMaxRetries(_arg1:int):void {
        this.loader.setMaxRetries(_arg1);
    }

    public function sendRequest(_arg1:String, _arg2:Object):void {
        try {
            if (_arg2 == null) {
                _arg2 = {};
                _arg2.gameClientVersion = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            }
            else {
                _arg2.gameClientVersion = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            }
        }
        catch (e:Error) {
        }
        if (((!((_arg2 == null))) && (_arg2.guid))) {
            this.loader.sendRequest(this.makeURL(((_arg1 + "?g=") + escape(_arg2.guid))), _arg2);
        }
        else {
            this.loader.sendRequest(this.makeURL(_arg1), _arg2);
        }
    }

    private function makeURL(_arg1:String):String {
        if (_arg1.charAt(0) != "/") {
            _arg1 = ("/" + _arg1);
        }
        return ((this.setup.getAppEngineUrl() + _arg1));
    }

    public function requestInProgress():Boolean {
        return (this.loader.isInProgress());
    }


}
}
