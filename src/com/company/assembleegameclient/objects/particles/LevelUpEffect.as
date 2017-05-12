package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

public class LevelUpEffect extends ParticleEffect {

    private static const LIFETIME:int = 2000;

    public var go_:GameObject;
    public var parts1_:Vector.<LevelUpParticle>;
    public var parts2_:Vector.<LevelUpParticle>;
    public var startTime_:int = -1;

    public function LevelUpEffect(_arg1:GameObject, _arg2:uint, _arg3:int) {
        var _local4:LevelUpParticle;
        this.parts1_ = new Vector.<LevelUpParticle>();
        this.parts2_ = new Vector.<LevelUpParticle>();
        super();
        this.go_ = _arg1;
        var _local5:int;
        while (_local5 < _arg3) {
            _local4 = new LevelUpParticle(_arg2, 100);
            this.parts1_.push(_local4);
            _local4 = new LevelUpParticle(_arg2, 100);
            this.parts2_.push(_local4);
            _local5++;
        }
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        if (this.go_.map_ == null) {
            this.endEffect();
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        if (this.startTime_ < 0) {
            this.startTime_ = _arg1;
        }
        var _local3:Number = ((_arg1 - this.startTime_) / LIFETIME);
        if (_local3 >= 1) {
            this.endEffect();
            return (false);
        }
        this.updateSwirl(this.parts1_, 1, 0, _local3);
        this.updateSwirl(this.parts2_, 1, Math.PI, _local3);
        return (true);
    }

    private function endEffect():void {
        var _local1:LevelUpParticle;
        for each (_local1 in this.parts1_) {
            _local1.alive_ = false;
        }
        for each (_local1 in this.parts2_) {
            _local1.alive_ = false;
        }
    }

    public function updateSwirl(_arg1:Vector.<LevelUpParticle>, _arg2:Number, _arg3:Number, _arg4:Number):void {
        var _local5:int;
        var _local6:LevelUpParticle;
        var _local7:Number;
        var _local8:Number;
        var _local9:Number;
        _local5 = 0;
        while (_local5 < _arg1.length) {
            _local6 = _arg1[_local5];
            _local6.z_ = (((_arg4 * 2) - 1) + (_local5 / _arg1.length));
            if (_local6.z_ >= 0) {
                if (_local6.z_ > 1) {
                    _local6.alive_ = false;
                }
                else {
                    _local7 = (_arg2 * ((((2 * Math.PI) * (_local5 / _arg1.length)) + ((2 * Math.PI) * _arg4)) + _arg3));
                    _local8 = (this.go_.x_ + (0.5 * Math.cos(_local7)));
                    _local9 = (this.go_.y_ + (0.5 * Math.sin(_local7)));
                    if (_local6.map_ == null) {
                        map_.addObj(_local6, _local8, _local9);
                    }
                    else {
                        _local6.moveTo(_local8, _local9);
                    }
                }
            }
            _local5++;
        }
    }


}
}

import com.company.assembleegameclient.objects.particles.Particle;

class LevelUpParticle extends Particle {

    public var alive_:Boolean = true;

    public function LevelUpParticle(_arg1:uint, _arg2:int) {
        super(_arg1, 0, _arg2);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        return (this.alive_);
    }


}

