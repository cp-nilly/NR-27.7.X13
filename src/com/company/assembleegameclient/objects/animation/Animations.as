package com.company.assembleegameclient.objects.animation {
import flash.display.BitmapData;

public class Animations {

    public var animationsData_:AnimationsData;
    public var nextRun_:Vector.<int> = null;
    public var running_:RunningAnimation = null;

    public function Animations(_arg1:AnimationsData) {
        this.animationsData_ = _arg1;
    }

    public function getTexture(_arg1:int):BitmapData {
        var _local2:AnimationData;
        var _local4:BitmapData;
        var _local5:int;
        if (this.nextRun_ == null) {
            this.nextRun_ = new Vector.<int>();
            for each (_local2 in this.animationsData_.animations) {
                this.nextRun_.push(_local2.getLastRun(_arg1));
            }
        }
        if (this.running_ != null) {
            _local4 = this.running_.getTexture(_arg1);
            if (_local4 != null) {
                return (_local4);
            }
            this.running_ = null;
        }
        var _local3:int;
        while (_local3 < this.nextRun_.length) {
            if (_arg1 > this.nextRun_[_local3]) {
                _local5 = this.nextRun_[_local3];
                _local2 = this.animationsData_.animations[_local3];
                this.nextRun_[_local3] = _local2.getNextRun(_arg1);
                if (!((!((_local2.prob_ == 1))) && ((Math.random() > _local2.prob_)))) {
                    this.running_ = new RunningAnimation(_local2, _local5);
                    return (this.running_.getTexture(_arg1));
                }
            }
            _local3++;
        }
        return (null);
    }


}
}

import com.company.assembleegameclient.objects.animation.AnimationData;
import com.company.assembleegameclient.objects.animation.FrameData;

import flash.display.BitmapData;

class RunningAnimation {

    public var animationData_:AnimationData;
    public var start_:int;
    public var frameId_:int;
    public var frameStart_:int;
    public var texture_:BitmapData;

    public function RunningAnimation(_arg1:AnimationData, _arg2:int) {
        this.animationData_ = _arg1;
        this.start_ = _arg2;
        this.frameId_ = 0;
        this.frameStart_ = _arg2;
        this.texture_ = null;
    }

    public function getTexture(_arg1:int):BitmapData {
        var _local2:FrameData = this.animationData_.frames[this.frameId_];
        while ((_arg1 - this.frameStart_) > _local2.time_) {
            if (this.frameId_ >= (this.animationData_.frames.length - 1)) {
                return (null);
            }
            this.frameStart_ = (this.frameStart_ + _local2.time_);
            this.frameId_++;
            _local2 = this.animationData_.frames[this.frameId_];
            this.texture_ = null;
        }
        if (this.texture_ == null) {
            this.texture_ = _local2.textureData_.getTexture((Math.random() * 100));
        }
        return (this.texture_);
    }


}

