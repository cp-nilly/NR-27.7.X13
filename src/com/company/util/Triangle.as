package com.company.util {
import flash.geom.Point;
import flash.geom.Rectangle;

public class Triangle {

    public var x0_:Number;
    public var y0_:Number;
    public var x1_:Number;
    public var y1_:Number;
    public var x2_:Number;
    public var y2_:Number;
    public var vx1_:Number;
    public var vy1_:Number;
    public var vx2_:Number;
    public var vy2_:Number;

    public function Triangle(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number) {
        this.x0_ = _arg1;
        this.y0_ = _arg2;
        this.x1_ = _arg3;
        this.y1_ = _arg4;
        this.x2_ = _arg5;
        this.y2_ = _arg6;
        this.vx1_ = (this.x1_ - this.x0_);
        this.vy1_ = (this.y1_ - this.y0_);
        this.vx2_ = (this.x2_ - this.x0_);
        this.vy2_ = (this.y2_ - this.y0_);
    }

    public static function containsXY(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number):Boolean {
        var _local9:Number = (_arg3 - _arg1);
        var _local10:Number = (_arg4 - _arg2);
        var _local11:Number = (_arg5 - _arg1);
        var _local12:Number = (_arg6 - _arg2);
        var _local13:Number = ((((_arg7 * _local12) - (_arg8 * _local11)) - ((_arg1 * _local12) - (_arg2 * _local11))) / ((_local9 * _local12) - (_local10 * _local11)));
        var _local14:Number = (-((((_arg7 * _local10) - (_arg8 * _local9)) - ((_arg1 * _local10) - (_arg2 * _local9)))) / ((_local9 * _local12) - (_local10 * _local11)));
        return ((((((_local13 >= 0)) && ((_local14 >= 0)))) && (((_local13 + _local14) <= 1))));
    }

    public static function intersectTriAABB(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number, _arg9:Number, _arg10:Number):Boolean {
        if ((((((((((((_arg7 > _arg1)) && ((_arg7 > _arg3)))) && ((_arg7 > _arg5)))) || ((((((_arg9 < _arg1)) && ((_arg9 < _arg3)))) && ((_arg9 < _arg5)))))) || ((((((_arg8 > _arg2)) && ((_arg8 > _arg4)))) && ((_arg8 > _arg6)))))) || ((((((_arg10 < _arg2)) && ((_arg10 < _arg4)))) && ((_arg10 < _arg6)))))) {
            return (false);
        }
        if ((((((((((((_arg7 < _arg1)) && ((_arg1 < _arg9)))) && ((_arg8 < _arg2)))) && ((_arg2 < _arg10)))) || ((((((((_arg7 < _arg3)) && ((_arg3 < _arg9)))) && ((_arg8 < _arg4)))) && ((_arg4 < _arg10)))))) || ((((((((_arg7 < _arg5)) && ((_arg5 < _arg9)))) && ((_arg8 < _arg6)))) && ((_arg6 < _arg10)))))) {
            return (true);
        }
        return (((((lineRectIntersect(_arg1, _arg2, _arg3, _arg4, _arg7, _arg8, _arg9, _arg10)) || (lineRectIntersect(_arg3, _arg4, _arg5, _arg6, _arg7, _arg8, _arg9, _arg10)))) || (lineRectIntersect(_arg5, _arg6, _arg1, _arg2, _arg7, _arg8, _arg9, _arg10))));
    }

    private static function lineRectIntersect(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number):Boolean {
        var _local11:Number;
        var _local12:Number;
        var _local13:Number;
        var _local14:Number;
        var _local9:Number = ((_arg4 - _arg2) / (_arg3 - _arg1));
        var _local10:Number = (_arg2 - (_local9 * _arg1));
        if (_local9 > 0) {
            _local11 = ((_local9 * _arg5) + _local10);
            _local12 = ((_local9 * _arg7) + _local10);
        }
        else {
            _local11 = ((_local9 * _arg7) + _local10);
            _local12 = ((_local9 * _arg5) + _local10);
        }
        if (_arg2 < _arg4) {
            _local13 = _arg2;
            _local14 = _arg4;
        }
        else {
            _local13 = _arg4;
            _local14 = _arg2;
        }
        var _local15:Number = (((_local11 > _local13)) ? _local11 : _local13);
        var _local16:Number = (((_local12 < _local14)) ? _local12 : _local14);
        return ((((_local15 < _local16)) && (!((((_local16 < _arg6)) || ((_local15 > _arg8)))))));
    }


    public function aabb():Rectangle {
        var _local1:Number = Math.min(this.x0_, this.x1_, this.x2_);
        var _local2:Number = Math.max(this.x0_, this.x1_, this.x2_);
        var _local3:Number = Math.min(this.y0_, this.y1_, this.y2_);
        var _local4:Number = Math.max(this.y0_, this.y1_, this.y2_);
        return (new Rectangle(_local1, _local3, (_local2 - _local1), (_local4 - _local3)));
    }

    public function area():Number {
        return (Math.abs(((((this.x0_ * (this.y1_ - this.y2_)) + (this.x1_ * (this.y2_ - this.y0_))) + (this.x2_ * (this.y0_ - this.y1_))) / 2)));
    }

    public function incenter(_arg1:Point):void {
        var _local2:Number = PointUtil.distanceXY(this.x1_, this.y1_, this.x2_, this.y2_);
        var _local3:Number = PointUtil.distanceXY(this.x0_, this.y0_, this.x2_, this.y2_);
        var _local4:Number = PointUtil.distanceXY(this.x0_, this.y0_, this.x1_, this.y1_);
        _arg1.x = ((((_local2 * this.x0_) + (_local3 * this.x1_)) + (_local4 * this.x2_)) / ((_local2 + _local3) + _local4));
        _arg1.y = ((((_local2 * this.y0_) + (_local3 * this.y1_)) + (_local4 * this.y2_)) / ((_local2 + _local3) + _local4));
    }

    public function contains(_arg1:Number, _arg2:Number):Boolean {
        var _local3:Number = ((((_arg1 * this.vy2_) - (_arg2 * this.vx2_)) - ((this.x0_ * this.vy2_) - (this.y0_ * this.vx2_))) / ((this.vx1_ * this.vy2_) - (this.vy1_ * this.vx2_)));
        var _local4:Number = (-((((_arg1 * this.vy1_) - (_arg2 * this.vx1_)) - ((this.x0_ * this.vy1_) - (this.y0_ * this.vx1_)))) / ((this.vx1_ * this.vy2_) - (this.vy1_ * this.vx2_)));
        return ((((((_local3 >= 0)) && ((_local4 >= 0)))) && (((_local3 + _local4) <= 1))));
    }

    public function distance(_arg1:Number, _arg2:Number):Number {
        if (this.contains(_arg1, _arg2)) {
            return (0);
        }
        return (Math.min(LineSegmentUtil.pointDistance(_arg1, _arg2, this.x0_, this.y0_, this.x1_, this.y1_), LineSegmentUtil.pointDistance(_arg1, _arg2, this.x1_, this.y1_, this.x2_, this.y2_), LineSegmentUtil.pointDistance(_arg1, _arg2, this.x0_, this.y0_, this.x2_, this.y2_)));
    }

    public function intersectAABB(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Boolean {
        return (intersectTriAABB(this.x0_, this.y0_, this.x1_, this.y1_, this.x2_, this.y2_, _arg1, _arg2, _arg3, _arg4));
    }


}
}
