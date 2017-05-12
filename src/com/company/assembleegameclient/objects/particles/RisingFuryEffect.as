package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;

import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class RisingFuryEffect extends ParticleEffect {

    public var start_:Point;
    public var go:GameObject;
    private var startX:Number;
    private var startY:Number;
    private var particleField:ParticleField;
    private var time:uint;
    private var timer:Timer;
    private var isCharged:Boolean;

    public function RisingFuryEffect(_arg1:GameObject, _arg2:uint) {
        this.go = _arg1;
        this.startX = (Math.floor((_arg1.x_ * 10)) / 10);
        this.startY = (Math.floor((_arg1.y_ * 10)) / 10);
        this.time = _arg2;
        this.createTimer();
        this.createParticleField();
    }

    private function createTimer():void {
        var _local1:uint = (((this.go.texture_.height == 8)) ? 50 : 30);
        this.timer = new Timer(_local1, Math.round((this.time / _local1)));
        this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onChargingComplete);
        this.timer.start();
    }

    private function onTimer(_arg1:TimerEvent):void {
        var _local2:Number = (Math.floor((this.go.x_ * 10)) / 10);
        var _local3:Number = (Math.floor((this.go.y_ * 10)) / 10);
        if (((!((this.startX == _local2))) || (!((this.startY == _local3))))) {
            this.timer.stop();
            this.particleField.destroy();
        }
    }

    private function onChargingComplete(_arg1:TimerEvent):void {
        this.particleField.destroy();
        var _local2:Timer = new Timer(33, 12);
        _local2.addEventListener(TimerEvent.TIMER, this.onShockTimer);
        _local2.start();
    }

    private function onShockTimer(_arg1:TimerEvent):void {
        this.isCharged = !(this.isCharged);
        this.go.toggleChargingEffect(this.isCharged);
    }

    private function createParticleField():void {
        this.particleField = new ParticleField(this.go.texture_.width, this.go.texture_.height);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        map_.addObj(this.particleField, this.go.x_, this.go.y_);
        return (false);
    }


}
}
