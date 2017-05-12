package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.ColorUtil;

public class CircleEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:uint;
    public var rise_:Number;
    public var rad_:Number;
    public var maxRad_:Number;
    public var lastUpdate_:int = -1;
    public var bInitialized_:Boolean = false;
    public var amount_:int;
    public var maxLife_:int;
    public var speed_:Number;
    public var parts_:Vector.<CircleParticle>;

    public function CircleEffect(_arg1:GameObject, _arg2:EffectProperties) {
        this.parts_ = new Vector.<CircleParticle>();
        super();
        this.go_ = _arg1;
        this.color_ = _arg2.color;
        this.rise_ = _arg2.rise;
        this.rad_ = _arg2.minRadius;
        this.maxRad_ = _arg2.maxRadius;
        this.amount_ = _arg2.amount;
        this.maxLife_ = (_arg2.life * 1000);
        this.speed_ = _arg2.speed;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:CircleParticle;
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
                _local3 = new CircleParticle(ColorUtil.randomSmart(this.color_));
                _local3.cX_ = x_;
                _local3.cY_ = y_;
                _local5 = (2 * Math.PI);
                _local6 = (_local5 / this.amount_);
                _local3.startTime_ = _arg1;
                _local3.angle_ = (_local6 * _local4);
                _local3.rad_ = this.rad_;
                _local3.speed_ = this.speed_;
                this.parts_.push(_local3);
                map_.addObj(_local3, x_, y_);
                _local3.move();
                _local4++;
            }
            this.bInitialized_ = true;
        }
        for each (_local3 in this.parts_) {
            _local3.rad_ = this.rad_;
        }
        this.rad_ = Math.min((this.rad_ + (this.rise_ * (_arg2 / 1000))), this.maxRad_);
        this.maxLife_ = (this.maxLife_ - _arg2);
        if (this.maxLife_ <= 0) {
            this.endEffect();
            return (false);
        }
        this.lastUpdate_ = _arg1;
        return (true);
    }

    private function endEffect():void {
        var _local1:CircleParticle;
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

class CircleParticle extends Particle {

    public var startTime_:int;
    public var speed_:Number;
    public var cX_:Number;
    public var cY_:Number;
    public var angle_:Number;
    public var rad_:Number;
    public var alive_:Boolean = true;

    public function CircleParticle(_arg1:uint = 0) {
        var _local2:Number = Math.random();
        super(_arg1, (0.2 + (Math.random() * 0.2)), (100 + (_local2 * 20)));
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    public function move():void {
        x_ = (this.cX_ + (this.rad_ * Math.cos(this.angle_)));
        y_ = (this.cY_ + (this.rad_ * Math.sin(this.angle_)));
        this.angle_ = (this.angle_ + this.speed_);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        this.move();
        return (this.alive_);
    }


}

