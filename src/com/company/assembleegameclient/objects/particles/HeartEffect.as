package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.ColorUtil;

public class HeartEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:uint;
    public var color2_:uint;
    public var rise_:Number;
    public var rad_:Number;
    public var maxRad_:Number;
    public var lastUpdate_:int = -1;
    public var bInitialized_:Boolean = false;
    public var amount_:int;
    public var maxLife_:int;
    public var speed_:Number;
    public var parts_:Vector.<HeartParticle>;

    public function HeartEffect(_arg1:GameObject, _arg2:EffectProperties) {
        this.parts_ = new Vector.<HeartParticle>();
        super();
        this.go_ = _arg1;
        this.color_ = _arg2.color;
        this.color2_ = _arg2.color2;
        this.rise_ = _arg2.rise;
        this.rad_ = _arg2.minRadius;
        this.maxRad_ = _arg2.maxRadius;
        this.amount_ = _arg2.amount;
        this.maxLife_ = (_arg2.life * 1000);
        this.speed_ = (_arg2.speed / (2 * Math.PI));
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:HeartParticle;
        var _local4:int;
        var _local5:Number;
        var _local6:Number;
        if (this.go_.map_ == null) {
            return (false);
        }
        if (this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0, (_arg1 - 400));
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        if (!this.bInitialized_) {
            _local4 = 0;
            while (_local4 < this.amount_) {
                _local3 = new HeartParticle(ColorUtil.rangeRandomSmart(this.color_, this.color2_));
                _local3.cX_ = x_;
                _local3.cY_ = y_;
                _local5 = (2 * Math.PI);
                _local6 = (_local5 / this.amount_);
                _local3.restart((_arg1 + ((_local6 * _local4) * 1000)), _arg1);
                _local3.rad_ = this.rad_;
                this.parts_.push(_local3);
                map_.addObj(_local3, x_, y_);
                _local3.z_ = (0.4 + (Math.sin(((_local6 * _local4) * 1.5)) * 0.05));
                _local4++;
            }
            this.bInitialized_ = true;
        }
        for each (_local3 in this.parts_) {
            _local3.rad_ = this.rad_;
        }
        if (this.maxLife_ <= 500) {
            this.rad_ = Math.max((this.rad_ - ((2 * this.maxRad_) * (_arg2 / 1000))), 0);
        }
        else {
            this.rad_ = Math.min((this.rad_ + (this.rise_ * (_arg2 / 1000))), this.maxRad_);
        }
        this.maxLife_ = (this.maxLife_ - _arg2);
        if (this.maxLife_ <= 0) {
            this.endEffect();
            return (false);
        }
        this.lastUpdate_ = _arg1;
        return (true);
    }

    private function endEffect():void {
        var _local1:HeartParticle;
        for each (_local1 in this.parts_) {
            _local1.alive_ = false;
        }
    }

    override public function removeFromMap():void {
        this.endEffect();
        super.removeFromMap();
    }


}
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

class HeartParticle extends Particle {

    public var startTime_:int;
    public var cX_:Number;
    public var cY_:Number;
    public var rad_:Number;
    public var alive_:Boolean = true;
    public var speed_:Number;
    /*private*/
    var radVar_:Number;

    public function HeartParticle(_arg1:uint = 0xFF0000) {
        this.radVar_ = (0.97 + (Math.random() * 0.06));
        super(_arg1, 0, (140 + (Math.random() * 40)));
    }

    /*private*/
    function move(_arg1:Number):void {
        x_ = (this.cX_ + (((((16 * Math.sin(_arg1)) * Math.sin(_arg1)) * Math.sin(_arg1)) / 16) * (this.rad_ * this.radVar_)));
        y_ = (this.cY_ - ((((((13 * Math.cos(_arg1)) - (5 * Math.cos((2 * _arg1)))) - (2 * Math.cos((3 * _arg1)))) - Math.cos((4 * _arg1))) / 16) * (this.rad_ * this.radVar_)));
    }

    public function restart(_arg1:int, _arg2:int):void {
        this.startTime_ = _arg1;
        var _local3:Number = ((_arg2 - this.startTime_) / 1000);
        this.move(_local3);
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:Number = ((_arg1 - this.startTime_) / 1000);
        this.move(_local3);
        return (this.alive_);
    }


}

