package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.RandomUtil;

public class GasEffect extends ParticleEffect {

    public var go_:GameObject;
    public var props:EffectProperties;
    public var color_:int;
    public var rate:Number;
    public var type:String;

    public function GasEffect(_arg1:GameObject, _arg2:EffectProperties) {
        this.go_ = _arg1;
        this.color_ = _arg2.color;
        this.rate = _arg2.rate;
        this.props = _arg2;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local5:Number;
        var _local6:Number;
        var _local7:Number;
        var _local8:Number;
        var _local9:Number;
        var _local10:GasParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local3:int = 20;
        var _local4:int;
        while (_local4 < this.rate) {
            _local5 = ((Math.random() + 0.3) * 200);
            _local6 = Math.random();
            _local7 = RandomUtil.plusMinus((this.props.speed - (this.props.speed * (_local6 * (1 - this.props.speedVariance)))));
            _local8 = RandomUtil.plusMinus((this.props.speed - (this.props.speed * (_local6 * (1 - this.props.speedVariance)))));
            _local9 = ((this.props.life * 1000) - ((this.props.life * 1000) * (_local6 * this.props.lifeVariance)));
            _local10 = new GasParticle(_local5, this.color_, _local9, this.props.spread, 0.75, _local7, _local8);
            map_.addObj(_local10, x_, y_);
            _local4++;
        }
        return (true);
    }


}
}
