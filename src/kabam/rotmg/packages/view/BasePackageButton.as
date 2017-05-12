package kabam.rotmg.packages.view {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class BasePackageButton extends Sprite {

    public static const IMAGE_NAME:String = "redLootBag";
    public static const IMAGE_ID:int = 0;


    protected static function makeIcon():DisplayObject {
        var _local2:DisplayObject;
        var _local1:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, IMAGE_ID);
        _local1 = TextureRedrawer.redraw(_local1, 40, true, 0);
        _local1 = BitmapUtil.cropToBitmapData(_local1, 10, 10, (_local1.width - 20), (_local1.height - 20));
        _local2 = new Bitmap(_local1);
        _local2.x = 3;
        _local2.y = 3;
        return (_local2);
    }


    protected function positionText(_arg1:DisplayObject, _arg2:TextFieldDisplayConcrete):void {
        var _local4:Number;
        var _local3:Rectangle = _arg1.getBounds(this);
        _local4 = (_local3.top + (_local3.height / 2));
        _arg2.x = _local3.right;
        _arg2.y = (_local4 - (_arg2.height / 2));
    }


}
}
