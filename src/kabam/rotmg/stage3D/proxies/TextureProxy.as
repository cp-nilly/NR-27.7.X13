package kabam.rotmg.stage3D.proxies {
import flash.display.BitmapData;
import flash.display3D.textures.Texture;
import flash.display3D.textures.TextureBase;

public class TextureProxy {

    private var texture:Texture;
    protected var width:int;
    protected var height:int;

    public function TextureProxy(_arg1:Texture) {
        this.texture = _arg1;
    }

    public function uploadFromBitmapData(_arg1:BitmapData):void {
        this.width = _arg1.width;
        this.height = _arg1.height;
        this.texture.uploadFromBitmapData(_arg1);
    }

    public function getTexture():TextureBase {
        return (this.texture);
    }

    public function getWidth():int {
        return (this.width);
    }

    public function getHeight():int {
        return (this.height);
    }

    public function dispose():void {
        this.texture.dispose();
    }


}
}
