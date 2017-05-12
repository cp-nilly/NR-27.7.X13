package com.company.util {
import flash.geom.Point;

public class PointUtil {

    public static const ORIGIN:Point = new Point(0, 0);

    public function PointUtil(_arg1:StaticEnforcer) {
    }

    public static function roundPoint(_arg1:Point):Point {
        var _local2:Point = _arg1.clone();
        _local2.x = Math.round(_local2.x);
        _local2.y = Math.round(_local2.y);
        return (_local2);
    }

    public static function distanceSquared(_arg1:Point, _arg2:Point):Number {
        return (distanceSquaredXY(_arg1.x, _arg1.y, _arg2.x, _arg2.y));
    }

    public static function distanceSquaredXY(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number {
        var _local5:Number = (_arg3 - _arg1);
        var _local6:Number = (_arg4 - _arg2);
        return (((_local5 * _local5) + (_local6 * _local6)));
    }

    public static function distanceXY(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number {
        var _local5:Number = (_arg3 - _arg1);
        var _local6:Number = (_arg4 - _arg2);
        return (Math.sqrt(((_local5 * _local5) + (_local6 * _local6))));
    }

    public static function lerpXY(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number):Point {
        return (new Point((_arg1 + ((_arg3 - _arg1) * _arg5)), (_arg2 + ((_arg4 - _arg2) * _arg5))));
    }

    public static function angleTo(_arg1:Point, _arg2:Point):Number {
        return (Math.atan2((_arg2.y - _arg1.y), (_arg2.x - _arg1.x)));
    }

    public static function pointAt(_arg1:Point, _arg2:Number, _arg3:Number):Point {
        var _local4:Point = new Point();
        _local4.x = (_arg1.x + (_arg3 * Math.cos(_arg2)));
        _local4.y = (_arg1.y + (_arg3 * Math.sin(_arg2)));
        return (_local4);
    }


}
}
class StaticEnforcer {


}

