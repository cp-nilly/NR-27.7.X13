package kabam.rotmg.assets.services {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.map.GroundLibrary;

import flash.net.URLLoaderDataFormat;
import flash.utils.IDataInput;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;

public class RequestEmbeddedDataTask extends BaseTask {
    
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var setLoadingMessage:SetLoadingMessageSignal;
    
    
    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.setDataFormat(URLLoaderDataFormat.BINARY);
        this.client.sendRequest("/app/getServerXmls", null);
    }

    private function onComplete(success:Boolean, data:*):void {
        if (success) {
            onDataComplete(data);
        }
        else {
            onTextError(data);
        }
        completeTask(success, data);
    }

    private function onDataComplete(data:IDataInput):void {
        var count:int = data.readInt();
        for (var i:int = 0; i < count; i++) {
            this.insertXml(data.readUTFBytes(data.readInt()));
        }
    }
    
    private function insertXml(rawXml:String):void {
        var xml:XML = XML(rawXml);
        GroundLibrary.parseFromXML(xml);
        ObjectLibrary.parseFromXML(xml);
    }
    
    private function onTextError(data:String):void {
        this.setLoadingMessage.dispatch("error.loadError");
    }
    
    
}
}