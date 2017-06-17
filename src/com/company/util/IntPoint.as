package com.company.util {
import flash.geom.Matrix;
import flash.geom.Point;

public class IntPoint {

    public var x_:int;
    public var y_:int;

    public function IntPoint(_arg1:int = 0, _arg2:int = 0) {
        this.x_ = _arg1;
        this.y_ = _arg2;
    }

    public static function unitTest():void {
        var _local1:UnitTest = new UnitTest();
    }

    public static function fromPoint(_arg1:Point):IntPoint {
        return (new IntPoint(Math.round(_arg1.x), Math.round(_arg1.y)));
    }


    public function x():int {
        return (this.x_);
    }

    public function y():int {
        return (this.y_);
    }

    public function setX(_arg1:int):void {
        this.x_ = _arg1;
    }

    public function setY(_arg1:int):void {
        this.y_ = _arg1;
    }

    public function clone():IntPoint {
        return (new IntPoint(this.x_, this.y_));
    }

    public function same(_arg1:IntPoint):Boolean {
        return ((((this.x_ == _arg1.x_)) && ((this.y_ == _arg1.y_))));
    }

    public function distanceAsInt(_arg1:IntPoint):int {
        var _local2:int = (_arg1.x_ - this.x_);
        var _local3:int = (_arg1.y_ - this.y_);
        return (Math.round(Math.sqrt(((_local2 * _local2) + (_local3 * _local3)))));
    }

    public function distanceAsNumber(_arg1:IntPoint):Number {
        var _local2:int = (_arg1.x_ - this.x_);
        var _local3:int = (_arg1.y_ - this.y_);
        return (Math.sqrt(((_local2 * _local2) + (_local3 * _local3))));
    }

    public function distanceToPoint(_arg1:Point):Number {
        var _local2:int = (_arg1.x - this.x_);
        var _local3:int = (_arg1.y - this.y_);
        return (Math.sqrt(((_local2 * _local2) + (_local3 * _local3))));
    }

    public function trunc1000():IntPoint {
        return (new IntPoint((int((this.x_ / 1000)) * 1000), (int((this.y_ / 1000)) * 1000)));
    }

    public function round1000():IntPoint {
        return (new IntPoint((Math.round((this.x_ / 1000)) * 1000), (Math.round((this.y_ / 1000)) * 1000)));
    }

    public function distanceSquared(_arg1:IntPoint):int {
        var _local2:int = (_arg1.x() - this.x_);
        var _local3:int = (_arg1.y() - this.y_);
        return (((_local2 * _local2) + (_local3 * _local3)));
    }

    public function toPoint():Point {
        return (new Point(this.x_, this.y_));
    }

    public function transform(_arg1:Matrix):IntPoint {
        var _local2:Point = _arg1.transformPoint(this.toPoint());
        return (new IntPoint(Math.round(_local2.x), Math.round(_local2.y)));
    }

    public function toString():String {
        return ((((("(" + this.x_) + ", ") + this.y_) + ")"));
    }


}
}

import com.company.util.IntPoint;

class UnitTest {

    public function UnitTest() {
        var _local1:IntPoint;
        var _local2:IntPoint;
        var _local3:Number;
        super();
        trace("STARTING UNITTEST: IntPoint");
        _local1 = new IntPoint(999, 1001);
        _local2 = _local1.round1000();
        if (((!((_local2.x() == 1000))) || (!((_local2.y() == 1000))))) {
            trace("ERROR IN UNITTEST: IntPoint1");
        }
        _local1 = new IntPoint(500, 400);
        _local2 = _local1.round1000();
        if (((!((_local2.x() == 1000))) || (!((_local2.y() == 0))))) {
            trace("ERROR IN UNITTEST: IntPoint2");
        }
        _local1 = new IntPoint(-400, -500);
        _local2 = _local1.round1000();
        if (((!((_local2.x() == 0))) || (!((_local2.y() == 0))))) {
            trace("ERROR IN UNITTEST: IntPoint3");
        }
        _local1 = new IntPoint(-501, -999);
        _local2 = _local1.round1000();
        if (((!((_local2.x() == -1000))) || (!((_local2.y() == -1000))))) {
            trace("ERROR IN UNITTEST: IntPoint4");
        }
        _local1 = new IntPoint(-1000, -1001);
        _local2 = _local1.round1000();
        if (((!((_local2.x() == -1000))) || (!((_local2.y() == -1000))))) {
            trace("ERROR IN UNITTEST: IntPoint5");
        }
        _local1 = new IntPoint(999, 1001);
        _local2 = _local1.trunc1000();
        if (((!((_local2.x() == 0))) || (!((_local2.y() == 1000))))) {
            trace("ERROR IN UNITTEST: IntPoint6");
        }
        _local1 = new IntPoint(500, 400);
        _local2 = _local1.trunc1000();
        if (((!((_local2.x() == 0))) || (!((_local2.y() == 0))))) {
            trace("ERROR IN UNITTEST: IntPoint7");
        }
        _local1 = new IntPoint(-400, -500);
        _local2 = _local1.trunc1000();
        if (((!((_local2.x() == 0))) || (!((_local2.y() == 0))))) {
            trace("ERROR IN UNITTEST: IntPoint8");
        }
        _local1 = new IntPoint(-501, -999);
        _local2 = _local1.trunc1000();
        if (((!((_local2.x() == 0))) || (!((_local2.y() == 0))))) {
            trace("ERROR IN UNITTEST: IntPoint9");
        }
        _local1 = new IntPoint(-1000, -1001);
        _local2 = _local1.trunc1000();
        if (((!((_local2.x() == -1000))) || (!((_local2.y() == -1000))))) {
            trace("ERROR IN UNITTEST: IntPoint10");
        }
        _local3 = 0.9999998;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint40");
        }
        _local3 = 0.5;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint41");
        }
        _local3 = 0.499999;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint42");
        }
        _local3 = -0.499999;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint43");
        }
        _local3 = -0.5;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint44");
        }
        _local3 = -0.99999;
        if (int(_local3) != 0) {
            trace("ERROR IN UNITTEST: IntPoint45");
        }
        trace("FINISHED UNITTEST: IntPoint");
    }

}

