package kabam.rotmg.assets.services {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.TextureDataConcrete;

import flash.display.BitmapData;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.IDataInput;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;

import ion.utils.png.PNGDecoder;

public class RequestEmbeddedAssetsTask extends BaseTask {
    
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var setLoadingMessage:SetLoadingMessageSignal;
    
    
    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.setDataFormat(URLLoaderDataFormat.BINARY);
        this.client.sendRequest("/app/getTextures", null);
    }
    
    private function onComplete(success:Boolean, data:*):void {
        if (success) {
            onAssetsComplete(data);
        }
        else {
            onTextError(data);
        }
        completeTask(success, data);
    }
    
    private function onAssetsComplete(data:IDataInput):void {
        var textures:Dictionary = new Dictionary();
        
        // get textures
        var count:int = data.readInt();
        for (var i:int = 0; i < count; i++) {
            var id:String = data.readUTF();
            var img:ByteArray = new ByteArray();
            data.readBytes(img, 0, data.readInt());
            textures[id] = img;
        }
        
        // set textures
        var tex:TextureDataConcrete;
        for each (tex in ObjectLibrary.typeToTextureData_) {
            if (tex.isRemoteTexture() && textures.hasOwnProperty(tex.id())) {
                var mask:String = tex.id() + "_mask";
                var maskImg:BitmapData;
                if (textures[mask] != null)
                    maskImg = PNGDecoder.decodeImage(textures[mask]);
                
                tex.onRemoteTexture(PNGDecoder.decodeImage(textures[tex.id()]), maskImg);
            }
        }
    }
    
    private function onTextError(data:String):void {
        this.setLoadingMessage.dispatch("error.loadError");
    }
    
    
}
}