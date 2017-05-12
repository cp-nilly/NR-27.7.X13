package com.company.assembleegameclient.objects {
import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class FlashDescription {

    public var startTime_:int;
    public var color_:uint;
    public var periodMS_:int;
    public var repeats_:int;
    public var targetR:int;
    public var targetG:int;
    public var targetB:int;

    public function FlashDescription(_arg1:int, _arg2:uint, _arg3:Number, _arg4:int) {
        this.startTime_ = _arg1;
        this.color_ = _arg2;
        this.periodMS_ = (_arg3 * 1000);
        this.repeats_ = _arg4;
        this.targetR = ((_arg2 >> 16) & 0xFF);
        this.targetG = ((_arg2 >> 8) & 0xFF);
        this.targetB = (_arg2 & 0xFF);
    }

    public function apply(_arg1:BitmapData, _arg2:int):BitmapData {
        var _local3:int = ((_arg2 - this.startTime_) % this.periodMS_);
        var _local4:Number = Math.sin(((_local3 / this.periodMS_) * Math.PI));
        var _local5:Number = (_local4 * 0.5);
        var _local6:ColorTransform = new ColorTransform((1 - _local5), (1 - _local5), (1 - _local5), 1, (_local5 * this.targetR), (_local5 * this.targetG), (_local5 * this.targetB), 0);
        var _local7:BitmapData = _arg1.clone();
        _local7.colorTransform(_local7.rect, _local6);
        return (_local7);
    }

    public function applyGPUTextureColorTransform(_arg1:BitmapData, _arg2:int):void {
        var _local3:int = ((_arg2 - this.startTime_) % this.periodMS_);
        var _local4:Number = Math.sin(((_local3 / this.periodMS_) * Math.PI));
        var _local5:Number = (_local4 * 0.5);
        var _local6:ColorTransform = new ColorTransform((1 - _local5), (1 - _local5), (1 - _local5), 1, (_local5 * this.targetR), (_local5 * this.targetG), (_local5 * this.targetB), 0);
        GraphicsFillExtra.setColorTransform(_arg1, _local6);
    }

    public function doneAt(_arg1:int):Boolean {
        return ((_arg1 > (this.startTime_ + (this.periodMS_ * this.repeats_))));
    }


}
}
