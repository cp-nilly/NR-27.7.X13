package com.company.assembleegameclient.util {
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class BloodComposition {

    private static var idDict_:Dictionary = new Dictionary();
    private static var imageDict_:Dictionary = new Dictionary();


    public static function getBloodComposition(_arg1:int, _arg2:BitmapData, _arg3:Number, _arg4:uint):Vector.<uint> {
        var _local5:Vector.<uint> = idDict_[_arg1];
        if (_local5 != null) {
            return (_local5);
        }
        _local5 = new Vector.<uint>();
        var _local6:Vector.<uint> = getColors(_arg2);
        var _local7:int;
        while (_local7 < _local6.length) {
            if (Math.random() < _arg3) {
                _local5.push(_arg4);
            }
            else {
                _local5.push(_local6[int((_local6.length * Math.random()))]);
            }
            _local7++;
        }
        return (_local5);
    }

    public static function getColors(_arg1:BitmapData):Vector.<uint> {
        var _local2:Vector.<uint> = imageDict_[_arg1];
        if (_local2 == null) {
            _local2 = buildColors(_arg1);
            imageDict_[_arg1] = _local2;
        }
        return (_local2);
    }

    private static function buildColors(_arg1:BitmapData):Vector.<uint> {
        var _local4:int;
        var _local5:uint;
        var _local2:Vector.<uint> = new Vector.<uint>();
        var _local3:int;
        while (_local3 < _arg1.width) {
            _local4 = 0;
            while (_local4 < _arg1.height) {
                _local5 = _arg1.getPixel32(_local3, _local4);
                if ((_local5 & 0xFF000000) != 0) {
                    _local2.push(_local5);
                }
                _local4++;
            }
            _local3++;
        }
        return (_local2);
    }


}
}
