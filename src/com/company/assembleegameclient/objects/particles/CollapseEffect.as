package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class CollapseEffect extends ParticleEffect {

    public var center_:Point;
    public var edgePoint_:Point;
    public var color_:int;

    public function CollapseEffect(_arg1:GameObject, _arg2:WorldPosData, _arg3:WorldPosData, _arg4:int) {
        this.center_ = new Point(_arg2.x_, _arg2.y_);
        this.edgePoint_ = new Point(_arg3.x_, _arg3.y_);
        this.color_ = _arg4;
    }

    override public function runNormalRendering(_arg1:int, _arg2:int):Boolean {
        var _local8:Number;
        var _local9:Point;
        var _local10:Particle;
        x_ = this.center_.x;
        y_ = this.center_.y;
        var _local3:Number = Point.distance(this.center_, this.edgePoint_);
        var _local4 = 300;
        var _local5 = 200;
        var _local6:int = 24;
        var _local7:int;
        while (_local7 < _local6) {
            _local8 = (((_local7 * 2) * Math.PI) / _local6);
            _local9 = new Point((this.center_.x + (_local3 * Math.cos(_local8))), (this.center_.y + (_local3 * Math.sin(_local8))));
            _local10 = new SparkerParticle(_local4, this.color_, _local5, _local9, this.center_);
            map_.addObj(_local10, x_, y_);
            _local7++;
        }
        return (false);
    }

    override public function runEasyRendering(_arg1:int, _arg2:int):Boolean {
        var _local8:Number;
        var _local9:Point;
        var _local10:Particle;
        x_ = this.center_.x;
        y_ = this.center_.y;
        var _local3:Number = Point.distance(this.center_, this.edgePoint_);
        var _local4:int = 50;
        var _local5 = 150;
        var _local6:int = 8;
        var _local7:int;
        while (_local7 < _local6) {
            _local8 = (((_local7 * 2) * Math.PI) / _local6);
            _local9 = new Point((this.center_.x + (_local3 * Math.cos(_local8))), (this.center_.y + (_local3 * Math.sin(_local8))));
            _local10 = new SparkerParticle(_local4, this.color_, _local5, _local9, this.center_);
            map_.addObj(_local10, x_, y_);
            _local7++;
        }
        return (false);
    }


}
}
