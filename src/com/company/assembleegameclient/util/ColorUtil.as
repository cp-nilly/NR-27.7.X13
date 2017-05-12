package com.company.assembleegameclient.util {
public class ColorUtil {


    public static function rangeRandomSmart(_arg1:uint, _arg2:uint):Number {
        var _local3:uint = ((_arg1 >> 16) & 0xFF);
        var _local4:uint = ((_arg1 >> 8) & 0xFF);
        var _local5:uint = (_arg1 & 0xFF);
        var _local6:uint = ((_arg2 >> 16) & 0xFF);
        var _local7:uint = ((_arg2 >> 8) & 0xFF);
        var _local8:uint = (_arg2 & 0xFF);
        var _local9:uint = (_local6 + (Math.random() * (_local3 - _local6)));
        var _local10:uint = (_local7 + (Math.random() * (_local4 - _local7)));
        var _local11:uint = (_local8 + (Math.random() * (_local5 - _local8)));
        return ((((_local9 << 16) | (_local10 << 8)) | _local11));
    }

    public static function randomSmart(_arg1:uint):Number {
        var _local2:uint = ((_arg1 >> 16) & 0xFF);
        var _local3:uint = ((_arg1 >> 8) & 0xFF);
        var _local4:uint = (_arg1 & 0xFF);
        var _local5:* = Math.max(0, Math.min(0xFF, (_local2 + RandomUtil.plusMinus((_local2 * 0.05)))));
        var _local6:* = Math.max(0, Math.min(0xFF, (_local3 + RandomUtil.plusMinus((_local3 * 0.05)))));
        var _local7:* = Math.max(0, Math.min(0xFF, (_local4 + RandomUtil.plusMinus((_local4 * 0.05)))));
        return ((((_local5 << 16) | (_local6 << 8)) | _local7));
    }

    public static function rangeRandomMix(_arg1:uint, _arg2:uint):Number {
        var _local3:uint = ((_arg1 >> 16) & 0xFF);
        var _local4:uint = ((_arg1 >> 8) & 0xFF);
        var _local5:uint = (_arg1 & 0xFF);
        var _local6:uint = ((_arg2 >> 16) & 0xFF);
        var _local7:uint = ((_arg2 >> 8) & 0xFF);
        var _local8:uint = (_arg2 & 0xFF);
        var _local9:Number = Math.random();
        var _local10:uint = (_local6 + (_local9 * (_local3 - _local6)));
        var _local11:uint = (_local7 + (_local9 * (_local4 - _local7)));
        var _local12:uint = (_local8 + (_local9 * (_local5 - _local8)));
        return ((((_local10 << 16) | (_local11 << 8)) | _local12));
    }

    public static function rangeRandom(_arg1:uint, _arg2:uint):Number {
        return ((_arg2 + (Math.random() * (_arg1 - _arg2))));
    }


}
}
