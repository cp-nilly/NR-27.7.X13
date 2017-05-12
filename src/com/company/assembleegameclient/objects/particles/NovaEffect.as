package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

public class NovaEffect extends ParticleEffect {

    public var start_:Point;
    public var novaRadius_:Number;
    public var color_:int;

    public function NovaEffect(_arg1:GameObject, _arg2:Number, _arg3:int) {
        this.start_ = new Point(_arg1.x_, _arg1.y_);
        this.novaRadius_ = _arg2;
        this.color_ = _arg3;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        var _local7:Number;
        var _local8:Point;
        var _local9:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3 = 200;
        var _local4 = 200;
        var _local5:int = (4 + (this.novaRadius_ * 2));
        var _local6:int;
        while (_local6 < _local5) {
            _local7 = (((_local6 * 2) * Math.PI) / _local5);
            _local8 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local7))), (this.start_.y + (this.novaRadius_ * Math.sin(_local7))));
            _local9 = new SparkerParticle(_local3, this.color_, _local4, this.start_, _local8);
            map_.addObj(_local9, x_, y_);
            _local6++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        var _local7:Number;
        var _local8:Point;
        var _local9:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:int = 10;
        var _local4 = 200;
        var _local5:int = (0 + (this.novaRadius_ * 2));
        var _local6:int;
        while (_local6 < _local5) {
            _local7 = (((_local6 * 2) * Math.PI) / _local5);
            _local8 = new Point((this.start_.x + (this.novaRadius_ * Math.cos(_local7))), (this.start_.y + (this.novaRadius_ * Math.sin(_local7))));
            _local9 = new SparkerParticle(_local3, this.color_, _local4, this.start_, _local8);
            map_.addObj(_local9, x_, y_);
            _local6++;
        }
        return (false);
    }


}
}
