package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.FreeList;

public class VentEffect extends ParticleEffect {

    private static const BUBBLE_PERIOD:int = 50;

    public var go_:GameObject;
    public var lastUpdate_:int = -1;

    public function VentEffect(_arg1:GameObject) {
        this.go_ = _arg1;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local4:int;
        var _local5:VentParticle;
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
            _local5 = (FreeList.newObject(VentParticle) as VentParticle);
            _local5.restart(_local4, _arg1);
            _local6 = (Math.random() * Math.PI);
            _local7 = (Math.random() * 0.4);
            _local8 = (this.go_.x_ + (_local7 * Math.cos(_local6)));
            _local9 = (this.go_.y_ + (_local7 * Math.sin(_local6)));
            map_.addObj(_local5, _local8, _local9);
            _local3++;
        }
        this.lastUpdate_ = _arg1;
        return (true);
    }


}
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

class VentParticle extends Particle {

    public var startTime_:int;
    public var speed_:int;

    public function VentParticle() {
        var _local1:Number = Math.random();
        super(2542335, 0, (75 + (_local1 * 50)));
        this.speed_ = (2.5 - (_local1 * 1.5));
    }

    public function restart(_arg1:int, _arg2:int):void {
        this.startTime_ = _arg1;
        var _local3:Number = ((_arg2 - this.startTime_) / 1000);
        z_ = (0 + (this.speed_ * _local3));
    }

    override public function removeFromMap():void {
        super.removeFromMap();
        FreeList.deleteObject(this);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:Number = ((_arg1 - this.startTime_) / 1000);
        z_ = (0 + (this.speed_ * _local3));
        return ((z_ < 1));
    }


}

