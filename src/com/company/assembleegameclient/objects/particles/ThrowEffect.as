package com.company.assembleegameclient.objects.particles {
import flash.geom.Point;

public class ThrowEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;

    public function ThrowEffect(_arg1:Point, _arg2:Point, _arg3:int) {
        this.start_ = _arg1;
        this.end_ = _arg2;
        this.color_ = _arg3;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3 = 200;
        var _local4:ThrowParticle = new ThrowParticle(_local3, this.color_, 1500, this.start_, this.end_);
        map_.addObj(_local4, x_, y_);
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:int = 10;
        var _local4:ThrowParticle = new ThrowParticle(_local3, this.color_, 1500, this.start_, this.end_);
        map_.addObj(_local4, x_, y_);
        return (false);
    }


}
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

class ThrowParticle extends Particle {

    public var lifetime_:int;
    public var timeLeft_:int;
    public var initialSize_:int;
    public var start_:Point;
    public var end_:Point;
    public var dx_:Number;
    public var dy_:Number;
    public var pathX_:Number;
    public var pathY_:Number;

    public function ThrowParticle(_arg1:int, _arg2:int, _arg3:int, _arg4:Point, _arg5:Point) {
        super(_arg2, 0, _arg1);
        this.lifetime_ = (this.timeLeft_ = _arg3);
        this.initialSize_ = _arg1;
        this.start_ = _arg4;
        this.end_ = _arg5;
        this.dx_ = ((this.end_.x - this.start_.x) / this.timeLeft_);
        this.dy_ = ((this.end_.y - this.start_.y) / this.timeLeft_);
        var _local6:Number = (Point.distance(_arg4, _arg5) / this.timeLeft_);
        this.pathX_ = (x_ = this.start_.x);
        this.pathY_ = (y_ = this.start_.y);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        this.timeLeft_ = (this.timeLeft_ - _arg2);
        if (this.timeLeft_ <= 0) {
            return (false);
        }
        z_ = (Math.sin(((this.timeLeft_ / this.lifetime_) * Math.PI)) * 2);
        setSize(0);
        this.pathX_ = (this.pathX_ + (this.dx_ * _arg2));
        this.pathY_ = (this.pathY_ + (this.dy_ * _arg2));
        moveTo(this.pathX_, this.pathY_);
        map_.addObj(new SparkParticle((100 * (z_ + 1)), color_, 400, z_, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1)), this.pathX_, this.pathY_);
        return (true);
    }


}

