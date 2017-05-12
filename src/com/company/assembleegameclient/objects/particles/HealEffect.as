package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

public class HealEffect extends ParticleEffect {

    public var go_:GameObject;
    public var color_:uint;

    public function HealEffect(_arg1:GameObject, _arg2:uint) {
        this.go_ = _arg1;
        this.color_ = _arg2;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local5:Number;
        var _local6:int;
        var _local7:Number;
        var _local8:HealParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local3:int = 10;
        var _local4:int;
        while (_local4 < _local3) {
            _local5 = ((2 * Math.PI) * (_local4 / _local3));
            _local6 = ((3 + int((Math.random() * 5))) * 20);
            _local7 = (0.3 + (0.4 * Math.random()));
            _local8 = new HealParticle(this.color_, (Math.random() * 0.3), _local6, 1000, (0.1 + (Math.random() * 0.1)), this.go_, _local5, _local7);
            map_.addObj(_local8, (x_ + (_local7 * Math.cos(_local5))), (y_ + (_local7 * Math.sin(_local5))));
            _local4++;
        }
        return (false);
    }


}
}
