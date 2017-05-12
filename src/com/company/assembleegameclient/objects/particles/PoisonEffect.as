package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

public class PoisonEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:int;

    public function PoisonEffect(_arg1:GameObject, _arg2:int) {
        this.go_ = _arg1;
        this.color_ = _arg2;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local3:int = 10;
        var _local4:int;
        while (_local4 < _local3) {
            map_.addObj(new SparkParticle(100, this.color_, 400, 0.75, RandomUtil.plusMinus(4), RandomUtil.plusMinus(4)), x_, y_);
            _local4++;
        }
        return (false);
    }


}
}
