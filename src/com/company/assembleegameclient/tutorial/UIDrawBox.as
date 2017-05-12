package com.company.assembleegameclient.tutorial {
import com.company.util.ConversionUtil;

import flash.display.Graphics;
import flash.geom.Point;
import flash.geom.Rectangle;

public class UIDrawBox {

    public const ANIMATION_MS:int = 500;
    public const ORIGIN:Point = new Point(250, 200);

    public var rect_:Rectangle;
    public var color_:uint;

    public function UIDrawBox(_arg1:XML) {
        this.rect_ = ConversionUtil.toRectangle(_arg1);
        this.color_ = uint(_arg1.@color);
    }

    public function draw(_arg1:int, _arg2:Graphics, _arg3:int):void {
        var _local4:Number;
        var _local5:Number;
        var _local6:Number = (this.rect_.width - _arg1);
        var _local7:Number = (this.rect_.height - _arg1);
        if (_arg3 < this.ANIMATION_MS) {
            _local4 = (this.ORIGIN.x + (((this.rect_.x - this.ORIGIN.x) * _arg3) / this.ANIMATION_MS));
            _local5 = (this.ORIGIN.y + (((this.rect_.y - this.ORIGIN.y) * _arg3) / this.ANIMATION_MS));
            _local6 = (_local6 * (_arg3 / this.ANIMATION_MS));
            _local7 = (_local7 * (_arg3 / this.ANIMATION_MS));
        }
        else {
            _local4 = (this.rect_.x + (_arg1 / 2));
            _local5 = (this.rect_.y + (_arg1 / 2));
        }
        _arg2.lineStyle(_arg1, this.color_);
        _arg2.drawRect(_local4, _local5, _local6, _local7);
    }


}
}
