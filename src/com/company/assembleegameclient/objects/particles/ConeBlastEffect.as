package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ConeBlastEffect extends ParticleEffect {

    public var start_:Point;
    public var target_:WorldPosData;
    public var blastRadius_:Number;
    public var color_:int;

    public function ConeBlastEffect(_arg1:GameObject, _arg2:WorldPosData, _arg3:Number, _arg4:int) {
        this.start_ = new Point(_arg1.x_, _arg1.y_);
        this.target_ = _arg2;
        this.blastRadius_ = _arg3;
        this.color_ = _arg4;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        var _local9:Number;
        var _local10:Point;
        var _local11:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3 = 200;
        var _local4:int = 100;
        var _local5:Number = (Math.PI / 3);
        var _local6:int = 7;
        var _local7:Number = Math.atan2((this.target_.y_ - this.start_.y), (this.target_.x_ - this.start_.x));
        var _local8:int;
        while (_local8 < _local6) {
            _local9 = ((_local7 - (_local5 / 2)) + ((_local8 * _local5) / _local6));
            _local10 = new Point((this.start_.x + (this.blastRadius_ * Math.cos(_local9))), (this.start_.y + (this.blastRadius_ * Math.sin(_local9))));
            _local11 = new SparkerParticle(_local3, this.color_, _local4, this.start_, _local10);
            map_.addObj(_local11, x_, y_);
            _local8++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        var _local9:Number;
        var _local10:Point;
        var _local11:Particle;
        x_ = this.start_.x;
        y_ = this.start_.y;
        var _local3:int = 50;
        var _local4:int = 10;
        var _local5:Number = (Math.PI / 3);
        var _local6:int = 5;
        var _local7:Number = Math.atan2((this.target_.y_ - this.start_.y), (this.target_.x_ - this.start_.x));
        var _local8:int;
        while (_local8 < _local6) {
            _local9 = ((_local7 - (_local5 / 2)) + ((_local8 * _local5) / _local6));
            _local10 = new Point((this.start_.x + (this.blastRadius_ * Math.cos(_local9))), (this.start_.y + (this.blastRadius_ * Math.sin(_local9))));
            _local11 = new SparkerParticle(_local3, this.color_, _local4, this.start_, _local10);
            map_.addObj(_local11, x_, y_);
            _local8++;
        }
        return (false);
    }


}
}
