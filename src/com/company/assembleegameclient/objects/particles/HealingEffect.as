package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

public class HealingEffect extends ParticleEffect {

    public var go_:GameObject;
    public var lastPart_:int;

    public function HealingEffect(_arg1:GameObject) {
        this.go_ = _arg1;
        this.lastPart_ = 0;
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local4:Number;
        var _local5:int;
        var _local6:Number;
        var _local7:HealParticle;
        if (this.go_.map_ == null) {
            return (false);
        }
        x_ = this.go_.x_;
        y_ = this.go_.y_;
        var _local3:int = (_arg1 - this.lastPart_);
        if (_local3 > 500) {
            _local4 = ((2 * Math.PI) * Math.random());
            _local5 = ((3 + int((Math.random() * 5))) * 20);
            _local6 = (0.3 + (0.4 * Math.random()));
            _local7 = new HealParticle(0xFFFFFF, (Math.random() * 0.3), _local5, 1000, (0.1 + (Math.random() * 0.1)), this.go_, _local4, _local6);
            map_.addObj(_local7, (x_ + (_local6 * Math.cos(_local4))), (y_ + (_local6 * Math.sin(_local4))));
            this.lastPart_ = _arg1;
        }
        return (true);
    }


}
}
