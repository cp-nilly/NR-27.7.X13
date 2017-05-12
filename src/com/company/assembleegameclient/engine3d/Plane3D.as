package com.company.assembleegameclient.engine3d {
import flash.geom.Vector3D;

public class Plane3D {

    public static const NONE:int = 0;
    public static const POSITIVE:int = 1;
    public static const NEGATIVE:int = 2;
    public static const EQUAL:int = 3;

    public var normal_:Vector3D;
    public var d_:Number;

    public function Plane3D(_arg1:Vector3D = null, _arg2:Vector3D = null, _arg3:Vector3D = null) {
        if (((((!((_arg1 == null))) && (!((_arg2 == null))))) && (!((_arg3 == null))))) {
            this.normal_ = new Vector3D();
            computeNormal(_arg1, _arg2, _arg3, this.normal_);
            this.d_ = -(this.normal_.dotProduct(_arg1));
        }
    }

    public static function computeNormal(_arg1:Vector3D, _arg2:Vector3D, _arg3:Vector3D, _arg4:Vector3D):void {
        var _local5:Number = (_arg2.x - _arg1.x);
        var _local6:Number = (_arg2.y - _arg1.y);
        var _local7:Number = (_arg2.z - _arg1.z);
        var _local8:Number = (_arg3.x - _arg1.x);
        var _local9:Number = (_arg3.y - _arg1.y);
        var _local10:Number = (_arg3.z - _arg1.z);
        _arg4.x = ((_local6 * _local10) - (_local7 * _local9));
        _arg4.y = ((_local7 * _local8) - (_local5 * _local10));
        _arg4.z = ((_local5 * _local9) - (_local6 * _local8));
        _arg4.normalize();
    }

    public static function computeNormalVec(_arg1:Vector.<Number>, _arg2:Vector3D):void {
        var _local3:Number = (_arg1[3] - _arg1[0]);
        var _local4:Number = (_arg1[4] - _arg1[1]);
        var _local5:Number = (_arg1[5] - _arg1[2]);
        var _local6:Number = (_arg1[6] - _arg1[0]);
        var _local7:Number = (_arg1[7] - _arg1[1]);
        var _local8:Number = (_arg1[8] - _arg1[2]);
        _arg2.x = ((_local4 * _local8) - (_local5 * _local7));
        _arg2.y = ((_local5 * _local6) - (_local3 * _local8));
        _arg2.z = ((_local3 * _local7) - (_local4 * _local6));
        _arg2.normalize();
    }


    public function testPoint(_arg1:Vector3D):int {
        var _local2:Number = (this.normal_.dotProduct(_arg1) + this.d_);
        if (_local2 > 0.001) {
            return (POSITIVE);
        }
        if (_local2 < -0.001) {
            return (NEGATIVE);
        }
        return (EQUAL);
    }

    public function lineIntersect(_arg1:Line3D):Number {
        var _local2:Number = (((-(this.d_) - (this.normal_.x * _arg1.v0_.x)) - (this.normal_.y * _arg1.v0_.y)) - (this.normal_.z * _arg1.v0_.z));
        var _local3:Number = (((this.normal_.x * (_arg1.v1_.x - _arg1.v0_.x)) + (this.normal_.y * (_arg1.v1_.y - _arg1.v0_.y))) + (this.normal_.z * (_arg1.v1_.z - _arg1.v0_.z)));
        if (_local3 == 0) {
            return (NaN);
        }
        return ((_local2 / _local3));
    }

    public function zAtXY(_arg1:Number, _arg2:Number):Number {
        return ((-(((this.d_ + (this.normal_.x * _arg1)) + (this.normal_.y * _arg2))) / this.normal_.z));
    }

    public function toString():String {
        return ((((("Plane(n = " + this.normal_) + ", d = ") + this.d_) + ")"));
    }


}
}
