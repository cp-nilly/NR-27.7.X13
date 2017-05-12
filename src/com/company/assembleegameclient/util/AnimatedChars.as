package com.company.assembleegameclient.util {
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class AnimatedChars {

    private static var nameMap_:Dictionary = new Dictionary();


    public static function getAnimatedChar(_arg1:String, _arg2:int):AnimatedChar {
        var _local3:Vector.<AnimatedChar> = nameMap_[_arg1];
        if ((((_local3 == null)) || ((_arg2 >= _local3.length)))) {
            return (null);
        }
        return (_local3[_arg2]);
    }

    public static function add(_arg1:String, _arg2:BitmapData, _arg3:BitmapData, _arg4:int, _arg5:int, _arg6:int, _arg7:int, _arg8:int):void {
        var _local11:MaskedImage;
        var _local9:Vector.<AnimatedChar> = new Vector.<AnimatedChar>();
        var _local10:MaskedImageSet = new MaskedImageSet();
        _local10.addFromBitmapData(_arg2, _arg3, _arg6, _arg7);
        for each (_local11 in _local10.images_) {
            _local9.push(new AnimatedChar(_local11, _arg4, _arg5, _arg8));
        }
        nameMap_[_arg1] = _local9;
    }


}
}
