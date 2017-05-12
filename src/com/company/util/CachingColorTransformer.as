package com.company.util {
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

public class CachingColorTransformer {

    private static var bds_:Dictionary = new Dictionary();


    public static function transformBitmapData(_arg1:BitmapData, _arg2:ColorTransform):BitmapData {
        var _local3:BitmapData;
        var _local4:Object = bds_[_arg1];
        if (_local4 != null) {
            _local3 = _local4[_arg2];
        }
        else {
            _local4 = new Object();
            bds_[_arg1] = _local4;
        }
        if (_local3 == null) {
            _local3 = _arg1.clone();
            _local3.colorTransform(_local3.rect, _arg2);
            _local4[_arg2] = _local3;
        }
        return (_local3);
    }

    public static function filterBitmapData(_arg1:BitmapData, _arg2:BitmapFilter):BitmapData {
        var _local3:BitmapData;
        var _local4:Object = bds_[_arg1];
        if (_local4 != null) {
            _local3 = _local4[_arg2];
        }
        else {
            _local4 = new Object();
            bds_[_arg1] = _local4;
        }
        if (_local3 == null) {
            _local3 = _arg1.clone();
            _local3.applyFilter(_local3, _local3.rect, new Point(), _arg2);
            _local4[_arg2] = _local3;
        }
        return (_local3);
    }

    public static function alphaBitmapData(_arg1:BitmapData, _arg2:Number):BitmapData {
        var _local3:int = int((_arg2 * 100));
        var _local4:ColorTransform = new ColorTransform(1, 1, 1, (_local3 / 100));
        return (transformBitmapData(_arg1, _local4));
    }

    public static function clear():void {
        var _local1:Object;
        var _local2:BitmapData;
        for each (_local1 in bds_) {
            for each (_local2 in _local1) {
                _local2.dispose();
            }
        }
        bds_ = new Dictionary();
    }


}
}
