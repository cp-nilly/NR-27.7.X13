package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class LineEffect extends ParticleEffect {

    public var start_:Point;
    public var end_:Point;
    public var color_:int;

    public function LineEffect(_arg1:GameObject, _arg2:WorldPosData, _arg3:int) {
        this.start_ = new Point(_arg1.x_, _arg1.y_);
        this.end_ = new Point(_arg2.x_, _arg2.y_);
        this.color_ = _arg3;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        var _local5:Point;
        var _local6:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:int = 30;
        var _local4:int;
        while (_local4 < _local3) {
            _local5 = Point.interpolate(this.start_, this.end_, (_local4 / _local3));
            _local6 = new SparkParticle(100, this.color_, 700, 0.5, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1));
            map_.addObj(_local6, _local5.x, _local5.y);
            _local4++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        var _local5:Point;
        var _local6:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:int = 5;
        var _local4:int;
        while (_local4 < _local3) {
            _local5 = Point.interpolate(this.start_, this.end_, (_local4 / _local3));
            _local6 = new SparkParticle(100, this.color_, 200, 0.5, RandomUtil.plusMinus(1), RandomUtil.plusMinus(1));
            map_.addObj(_local6, _local5.x, _local5.y);
            _local4++;
        }
        return (false);
    }


}
}
