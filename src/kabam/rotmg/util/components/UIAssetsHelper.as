package kabam.rotmg.util.components {
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

public class UIAssetsHelper {

    public static const LEFT_NEVIGATOR:String = "left";
    public static const RIGHT_NEVIGATOR:String = "right";


    public static function createLeftNevigatorIcon(_arg1:String = "left", _arg2:int = 4, _arg3:Number = 0):Sprite {
        var _local4:BitmapData;
        if (_arg1 == LEFT_NEVIGATOR) {
            _local4 = AssetLibrary.getImageFromSet("lofiInterface", 55);
        }
        else {
            _local4 = AssetLibrary.getImageFromSet("lofiInterface", 54);
        }
        var _local5:Bitmap = new Bitmap(_local4);
        _local5.scaleX = _arg2;
        _local5.scaleY = _arg2;
        _local5.rotation = _arg3;
        var _local6:Sprite = new Sprite();
        _local6.addChild(_local5);
        return (_local6);
    }


}
}
