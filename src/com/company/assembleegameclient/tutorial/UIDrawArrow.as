package com.company.assembleegameclient.tutorial {
import com.company.util.ConversionUtil;
import com.company.util.PointUtil;

import flash.display.Graphics;
import flash.geom.Point;

public class UIDrawArrow {

    public const ANIMATION_MS:int = 500;

    public var p0_:Point;
    public var p1_:Point;
    public var color_:uint;

    public function UIDrawArrow(_arg1:XML) {
        var _local2:Array = ConversionUtil.toPointPair(_arg1);
        this.p0_ = _local2[0];
        this.p1_ = _local2[1];
        this.color_ = uint(_arg1.@color);
    }

    public function draw(_arg1:int, _arg2:Graphics, _arg3:int):void {
        var _local6:Point;
        var _local4:Point = new Point();
        if (_arg3 < this.ANIMATION_MS) {
            _local4.x = (this.p0_.x + (((this.p1_.x - this.p0_.x) * _arg3) / this.ANIMATION_MS));
            _local4.y = (this.p0_.y + (((this.p1_.y - this.p0_.y) * _arg3) / this.ANIMATION_MS));
        }
        else {
            _local4.x = this.p1_.x;
            _local4.y = this.p1_.y;
        }
        _arg2.lineStyle(_arg1, this.color_);
        _arg2.moveTo(this.p0_.x, this.p0_.y);
        _arg2.lineTo(_local4.x, _local4.y);
        var _local5:Number = PointUtil.angleTo(_local4, this.p0_);
        _local6 = PointUtil.pointAt(_local4, (_local5 + (Math.PI / 8)), 30);
        _arg2.lineTo(_local6.x, _local6.y);
        _local6 = PointUtil.pointAt(_local4, (_local5 - (Math.PI / 8)), 30);
        _arg2.moveTo(_local4.x, _local4.y);
        _arg2.lineTo(_local6.x, _local6.y);
    }


}
}
