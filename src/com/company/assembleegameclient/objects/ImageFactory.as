package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ImageFactory {


    public function getImageFromSet(_arg1:String, _arg2:int):BitmapData {
        return (AssetLibrary.getImageFromSet(_arg1, _arg2));
    }

    public function getTexture(_arg1:int, _arg2:int):BitmapData {
        var _local4:Number;
        var _local5:BitmapData;
        var _local3:BitmapData = ObjectLibrary.getBitmapData(_arg1);
        if (_local3) {
            _local4 = ((_arg2 - TextureRedrawer.minSize) / _local3.width);
            _local5 = ObjectLibrary.getRedrawnTextureFromType(_arg1, 100, true, false, _local4);
            return (_local5);
        }
        return (new BitmapDataSpy(_arg2, _arg2));
    }


}
}
