package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class SkyBeamEffect extends ParticleEffect {

    private static const BUBBLE_PERIOD:int = 30;

    public var go_:GameObject;
    public var color_:uint;
    public var rise_:Number;
    public var radius:Number;
    public var height_:Number;
    public var maxRadius:Number;
    public var speed_:Number;
    public var lastUpdate_:int = -1;

    public function SkyBeamEffect(_arg1:GameObject, _arg2:EffectProperties) {
        this.go_ = _arg1;
        this.color_ = _arg2.color;
        this.rise_ = _arg2.rise;
        this.radius = _arg2.minRadius;
        this.maxRadius = _arg2.maxRadius;
        this.height_ = _arg2.zOffset;
        this.speed_ = _arg2.speed;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local4:int;
        var _local5:SkyBeamParticle;
        var _local6:Number;
        var _local7:Number;
        var _local8:Number;
        var _local9:Number;
        if (this.go_.map_ == null) {
            return (false);
        }
        if (this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0, (_arg1 - 400));
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local3:int = int((this.lastUpdate_ / BUBBLE_PERIOD));
        while (_local3 < int((_arg1 / BUBBLE_PERIOD))) {
            _local4 = (_local3 * BUBBLE_PERIOD);
            _local5 = (FreeList.newObject(SkyBeamParticle) as SkyBeamParticle);
            _local5.setColor(this.color_);
            _local5.height_ = this.height_;
            _local5.restart(_local4, _arg1);
            _local6 = ((2 * Math.random()) * Math.PI);
            _local7 = (Math.random() * this.radius);
            _local5.setSpeed((this.speed_ + (this.maxRadius - _local7)));
            _local8 = (this.go_.x_ + (_local7 * Math.cos(_local6)));
            _local9 = (this.go_.y_ + (_local7 * Math.sin(_local6)));
            map_.addObj(_local5, _local8, _local9);
            _local3++;
        }
        this.radius = Math.min((this.radius + (this.rise_ * (_arg2 / 1000))), this.maxRadius);
        this.lastUpdate_ = _arg1;
        return (true);
    }


}
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

class SkyBeamParticle extends Particle {

    public var startTime_:int;
    public var speed_:Number;
    public var height_:Number;

    public function SkyBeamParticle() {
        var _local1:Number = Math.random();
        super(2542335, this.height_, (80 + (_local1 * 40)));
    }

    public function setSpeed(_arg1:Number):void {
        this.speed_ = _arg1;
    }

    public function restart(_arg1:int, _arg2:int):void {
        this.startTime_ = _arg1;
        var _local3:Number = ((_arg2 - this.startTime_) / 1000);
        z_ = (this.height_ - (this.speed_ * _local3));
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:Number = ((_arg1 - this.startTime_) / 1000);
        z_ = (this.height_ - (this.speed_ * _local3));
        return ((z_ > 0));
    }


}

