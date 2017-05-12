package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LightningEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;
    public var particleSize_:int;
    public var lifetimeMultiplier_:Number;

    public function LightningEffect(_arg1:GameObject, _arg2:WorldPosData, _arg3:int, _arg4:int, _arg5:* = 1) {
        this.start_ = new Point(_arg1.x_, _arg1.y_);
        this.end_ = new Point(_arg2.x_, _arg2.y_);
        this.color_ = _arg3;
        this.particleSize_ = _arg4;
        this.lifetimeMultiplier_ = _arg5;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        var _local6:Point;
        var _local7:Particle;
        var _local8:Number;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:Number = Point.distance(this.start_, this.end_);
        var _local4:int = (_local3 * 3);
        var _local5:int;
        while (_local5 < _local4) {
            _local6 = Point.interpolate(this.start_, this.end_, (_local5 / _local4));
            _local7 = new SparkParticle(this.particleSize_, this.color_, ((1000 * this.lifetimeMultiplier_) - (((_local5 / _local4) * 900) * this.lifetimeMultiplier_)), 0.5, 0, 0);
            _local8 = Math.min(_local5, (_local4 - _local5));
            map_.addObj(_local7, (_local6.x + RandomUtil.plusMinus(((_local3 / 200) * _local8))), (_local6.y + RandomUtil.plusMinus(((_local3 / 200) * _local8))));
            _local5++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        var _local6:Point;
        var _local7:Particle;
        var _local8:Number;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:Number = Point.distance(this.start_, this.end_);
        var _local4:int = (_local3 * 2);
        this.particleSize_ = 80;
        var _local5:int;
        while (_local5 < _local4) {
            _local6 = Point.interpolate(this.start_, this.end_, (_local5 / _local4));
            _local7 = new SparkParticle(this.particleSize_, this.color_, ((750 * this.lifetimeMultiplier_) - (((_local5 / _local4) * 675) * this.lifetimeMultiplier_)), 0.5, 0, 0);
            _local8 = Math.min(_local5, (_local4 - _local5));
            map_.addObj(_local7, (_local6.x + RandomUtil.plusMinus(((_local3 / 200) * _local8))), (_local6.y + RandomUtil.plusMinus(((_local3 / 200) * _local8))));
            _local5++;
        }
        return (false);
    }


}
}
