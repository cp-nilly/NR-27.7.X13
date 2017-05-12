package com.company.util {
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class RectangleUtil {


    public static function pointDist(_arg1:Rectangle, _arg2:Number, _arg3:Number):Number {
        var _local4:Number = _arg2;
        var _local5:Number = _arg3;
        if (_local4 < _arg1.x) {
            _local4 = _arg1.x;
        }
        else {
            if (_local4 > _arg1.right) {
                _local4 = _arg1.right;
            }
        }
        if (_local5 < _arg1.y) {
            _local5 = _arg1.y;
        }
        else {
            if (_local5 > _arg1.bottom) {
                _local5 = _arg1.bottom;
            }
        }
        if ((((_local4 == _arg2)) && ((_local5 == _arg3)))) {
            return (0);
        }
        return (PointUtil.distanceXY(_local4, _local5, _arg2, _arg3));
    }

    public static function closestPoint(_arg1:Rectangle, _arg2:Number, _arg3:Number):Point {
        var _local4:Number = _arg2;
        var _local5:Number = _arg3;
        if (_local4 < _arg1.x) {
            _local4 = _arg1.x;
        }
        else {
            if (_local4 > _arg1.right) {
                _local4 = _arg1.right;
            }
        }
        if (_local5 < _arg1.y) {
            _local5 = _arg1.y;
        }
        else {
            if (_local5 > _arg1.bottom) {
                _local5 = _arg1.bottom;
            }
        }
        return (new Point(_local4, _local5));
    }

    public static function lineSegmentIntersectsXY(_arg1:Rectangle, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number):Boolean {
        var _local8:Number;
        var _local9:Number;
        var _local10:Number;
        var _local11:Number;
        if ((((((((((_arg1.left > _arg2)) && ((_arg1.left > _arg4)))) || ((((_arg1.right < _arg2)) && ((_arg1.right < _arg4)))))) || ((((_arg1.top > _arg3)) && ((_arg1.top > _arg5)))))) || ((((_arg1.bottom < _arg3)) && ((_arg1.bottom < _arg5)))))) {
            return (false);
        }
        if ((((((((((_arg1.left < _arg2)) && ((_arg2 < _arg1.right)))) && ((_arg1.top < _arg3)))) && ((_arg3 < _arg1.bottom)))) || ((((((((_arg1.left < _arg4)) && ((_arg4 < _arg1.right)))) && ((_arg1.top < _arg5)))) && ((_arg5 < _arg1.bottom)))))) {
            return (true);
        }
        var _local6:Number = ((_arg5 - _arg3) / (_arg4 - _arg2));
        var _local7:Number = (_arg3 - (_local6 * _arg2));
        if (_local6 > 0) {
            _local8 = ((_local6 * _arg1.left) + _local7);
            _local9 = ((_local6 * _arg1.right) + _local7);
        }
        else {
            _local8 = ((_local6 * _arg1.right) + _local7);
            _local9 = ((_local6 * _arg1.left) + _local7);
        }
        if (_arg3 < _arg5) {
            _local11 = _arg3;
            _local10 = _arg5;
        }
        else {
            _local11 = _arg5;
            _local10 = _arg3;
        }
        var _local12:Number = (((_local8 > _local11)) ? _local8 : _local11);
        var _local13:Number = (((_local9 < _local10)) ? _local9 : _local10);
        return ((((_local12 < _local13)) && (!((((_local13 < _arg1.top)) || ((_local12 > _arg1.bottom)))))));
    }

    public static function lineSegmentIntersectXY(_arg1:Rectangle, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Point):Boolean {
        var _local7:Number;
        var _local8:Number;
        var _local9:Number;
        var _local10:Number;
        if (_arg4 <= _arg1.x) {
            _local7 = ((_arg5 - _arg3) / (_arg4 - _arg2));
            _local8 = (_arg3 - (_arg2 * _local7));
            _local9 = ((_local7 * _arg1.x) + _local8);
            if ((((_local9 >= _arg1.y)) && ((_local9 <= (_arg1.y + _arg1.height))))) {
                _arg6.x = _arg1.x;
                _arg6.y = _local9;
                return (true);
            }
        }
        else {
            if (_arg4 >= (_arg1.x + _arg1.width)) {
                _local7 = ((_arg5 - _arg3) / (_arg4 - _arg2));
                _local8 = (_arg3 - (_arg2 * _local7));
                _local9 = ((_local7 * (_arg1.x + _arg1.width)) + _local8);
                if ((((_local9 >= _arg1.y)) && ((_local9 <= (_arg1.y + _arg1.height))))) {
                    _arg6.x = (_arg1.x + _arg1.width);
                    _arg6.y = _local9;
                    return (true);
                }
            }
        }
        if (_arg5 <= _arg1.y) {
            _local7 = ((_arg4 - _arg2) / (_arg5 - _arg3));
            _local8 = (_arg2 - (_arg3 * _local7));
            _local10 = ((_local7 * _arg1.y) + _local8);
            if ((((_local10 >= _arg1.x)) && ((_local10 <= (_arg1.x + _arg1.width))))) {
                _arg6.x = _local10;
                _arg6.y = _arg1.y;
                return (true);
            }
        }
        else {
            if (_arg5 >= (_arg1.y + _arg1.height)) {
                _local7 = ((_arg4 - _arg2) / (_arg5 - _arg3));
                _local8 = (_arg2 - (_arg3 * _local7));
                _local10 = ((_local7 * (_arg1.y + _arg1.height)) + _local8);
                if ((((_local10 >= _arg1.x)) && ((_local10 <= (_arg1.x + _arg1.width))))) {
                    _arg6.x = _local10;
                    _arg6.y = (_arg1.y + _arg1.height);
                    return (true);
                }
            }
        }
        return (false);
    }

    public static function lineSegmentIntersect(_arg1:Rectangle, _arg2:IntPoint, _arg3:IntPoint):Point {
        var _local4:Number;
        var _local5:Number;
        var _local6:Number;
        var _local7:Number;
        if (_arg3.x() <= _arg1.x) {
            _local4 = ((_arg3.y() - _arg2.y()) / (_arg3.x() - _arg2.x()));
            _local5 = (_arg2.y() - (_arg2.x() * _local4));
            _local6 = ((_local4 * _arg1.x) + _local5);
            if ((((_local6 >= _arg1.y)) && ((_local6 <= (_arg1.y + _arg1.height))))) {
                return (new Point(_arg1.x, _local6));
            }
        }
        else {
            if (_arg3.x() >= (_arg1.x + _arg1.width)) {
                _local4 = ((_arg3.y() - _arg2.y()) / (_arg3.x() - _arg2.x()));
                _local5 = (_arg2.y() - (_arg2.x() * _local4));
                _local6 = ((_local4 * (_arg1.x + _arg1.width)) + _local5);
                if ((((_local6 >= _arg1.y)) && ((_local6 <= (_arg1.y + _arg1.height))))) {
                    return (new Point((_arg1.x + _arg1.width), _local6));
                }
            }
        }
        if (_arg3.y() <= _arg1.y) {
            _local4 = ((_arg3.x() - _arg2.x()) / (_arg3.y() - _arg2.y()));
            _local5 = (_arg2.x() - (_arg2.y() * _local4));
            _local7 = ((_local4 * _arg1.y) + _local5);
            if ((((_local7 >= _arg1.x)) && ((_local7 <= (_arg1.x + _arg1.width))))) {
                return (new Point(_local7, _arg1.y));
            }
        }
        else {
            if (_arg3.y() >= (_arg1.y + _arg1.height)) {
                _local4 = ((_arg3.x() - _arg2.x()) / (_arg3.y() - _arg2.y()));
                _local5 = (_arg2.x() - (_arg2.y() * _local4));
                _local7 = ((_local4 * (_arg1.y + _arg1.height)) + _local5);
                if ((((_local7 >= _arg1.x)) && ((_local7 <= (_arg1.x + _arg1.width))))) {
                    return (new Point(_local7, (_arg1.y + _arg1.height)));
                }
            }
        }
        return (null);
    }

    public static function getRotatedRectExtents2D(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number):Extents2D {
        var _local9:Point;
        var _local11:int;
        var _local6:Matrix = new Matrix();
        _local6.translate((-(_arg4) / 2), (-(_arg5) / 2));
        _local6.rotate(_arg3);
        _local6.translate(_arg1, _arg2);
        var _local7:Extents2D = new Extents2D();
        var _local8:Point = new Point();
        var _local10:int;
        while (_local10 <= 1) {
            _local11 = 0;
            while (_local11 <= 1) {
                _local8.x = (_local10 * _arg4);
                _local8.y = (_local11 * _arg5);
                _local9 = _local6.transformPoint(_local8);
                _local7.add(_local9.x, _local9.y);
                _local11++;
            }
            _local10++;
        }
        return (_local7);
    }


}
}
