package com.company.util {
import flash.geom.Point;

public class LineSegmentUtil {


    public static function intersection(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number):Point {
        var _local9:Number = (((_arg8 - _arg6) * (_arg3 - _arg1)) - ((_arg7 - _arg5) * (_arg4 - _arg2)));
        if (_local9 == 0) {
            return (null);
        }
        var _local10:Number = ((((_arg7 - _arg5) * (_arg2 - _arg6)) - ((_arg8 - _arg6) * (_arg1 - _arg5))) / _local9);
        var _local11:Number = ((((_arg3 - _arg1) * (_arg2 - _arg6)) - ((_arg4 - _arg2) * (_arg1 - _arg5))) / _local9);
        if ((((((((_local10 > 1)) || ((_local10 < 0)))) || ((_local11 > 1)))) || ((_local11 < 0)))) {
            return (null);
        }
        var _local12:Point = new Point((_arg1 + (_local10 * (_arg3 - _arg1))), (_arg2 + (_local10 * (_arg4 - _arg2))));
        return (_local12);
    }

    public static function pointDistance(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number):Number {
        var _local10:Number;
        var _local11:Number;
        var _local12:Number;
        var _local7:Number = (_arg5 - _arg3);
        var _local8:Number = (_arg6 - _arg4);
        var _local9:Number = ((_local7 * _local7) + (_local8 * _local8));
        if (_local9 < 0.001) {
            _local10 = _arg3;
            _local11 = _arg4;
        }
        else {
            _local12 = ((((_arg1 - _arg3) * _local7) + ((_arg2 - _arg4) * _local8)) / _local9);
            if (_local12 < 0) {
                _local10 = _arg3;
                _local11 = _arg4;
            }
            else {
                if (_local12 > 1) {
                    _local10 = _arg5;
                    _local11 = _arg6;
                }
                else {
                    _local10 = (_arg3 + (_local12 * _local7));
                    _local11 = (_arg4 + (_local12 * _local8));
                }
            }
        }
        _local7 = (_arg1 - _local10);
        _local8 = (_arg2 - _local11);
        return (Math.sqrt(((_local7 * _local7) + (_local8 * _local8))));
    }


}
}
