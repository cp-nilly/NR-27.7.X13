package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.particles.ConfettiEffect;
import com.company.assembleegameclient.objects.particles.LightningEffect;
import com.company.assembleegameclient.objects.particles.NovaEffect;

import flash.display.IGraphicsData;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getTimer;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ParticleModalMap extends Map {

    public static const MODE_SNOW:int = 1;
    public static const MODE_AUTO_UPDATE:int = 2;
    public static const PSCALE:Number = 16;

    private var inUpdate_:Boolean = false;
    private var objsToAdd_:Vector.<BasicObject>;
    private var idsToRemove_:Vector.<int>;
    private var dt:uint = 0;
    private var dtBuildup:uint = 0;
    private var time:uint = 0;
    private var graphicsData_:Vector.<IGraphicsData>;

    public function ParticleModalMap(_arg1:int = -1) {
        this.objsToAdd_ = new Vector.<BasicObject>();
        this.idsToRemove_ = new Vector.<int>();
        this.graphicsData_ = new Vector.<IGraphicsData>();
        super(null);
        if (_arg1 == MODE_SNOW) {
            addEventListener(Event.ENTER_FRAME, this.activateModeSnow);
        }
        if (_arg1 == MODE_AUTO_UPDATE) {
            addEventListener(Event.ENTER_FRAME, this.updater);
        }
    }

    public static function getLocalPos(_arg1:Number):Number {
        return ((_arg1 / PSCALE));
    }


    override public function addObj(_arg1:BasicObject, _arg2:Number, _arg3:Number):void {
        _arg1.x_ = _arg2;
        _arg1.y_ = _arg3;
        if (this.inUpdate_) {
            this.objsToAdd_.push(_arg1);
        }
        else {
            this.internalAddObj(_arg1);
        }
    }

    override public function internalAddObj(_arg1:BasicObject):void {
        var _local2:Dictionary = boDict_;
        if (_local2[_arg1.objectId_] != null) {
            return;
        }
        _arg1.map_ = this;
        _local2[_arg1.objectId_] = _arg1;
    }

    override public function internalRemoveObj(_arg1:int):void {
        var _local2:Dictionary = boDict_;
        var _local3:BasicObject = _local2[_arg1];
        if (_local3 == null) {
            return;
        }
        _local3.removeFromMap();
        delete _local2[_arg1];
    }

    override public function update(_arg1:int, _arg2:int):void {
        var _local3:BasicObject;
        var _local4:int;
        this.inUpdate_ = true;
        for each (_local3 in boDict_) {
            if (!_local3.update(_arg1, _arg2)) {
                this.idsToRemove_.push(_local3.objectId_);
            }
        }
        this.inUpdate_ = false;
        for each (_local3 in this.objsToAdd_) {
            this.internalAddObj(_local3);
        }
        this.objsToAdd_.length = 0;
        for each (_local4 in this.idsToRemove_) {
            this.internalRemoveObj(_local4);
        }
        this.idsToRemove_.length = 0;
    }

    override public function draw(_arg1:Camera, _arg2:int):void {
        var _local3:BasicObject;
        this.graphicsData_.length = 0;
        var _local4:int;
        for each (_local3 in boDict_) {
            _local4++;
            _local3.computeSortValNoCamera(PSCALE);
            _local3.draw(this.graphicsData_, _arg1, _arg2);
        }
        graphics.clear();
        if (this.graphicsData_.length > 0) {
            graphics.drawGraphicsData(this.graphicsData_);
        }
    }

    private function activateModeSnow(_arg1:Event):void {
        var _local2 = 600;
        var _local3 = 600;
        if (this.time != 0) {
            this.dt = (getTimer() - this.time);
        }
        this.dtBuildup = (this.dtBuildup + this.dt);
        this.time = getTimer();
        if (this.dtBuildup > 500) {
            this.dtBuildup = 0;
            this.doSnow((Math.random() * 600), -100);
        }
        this.update(this.time, this.dt);
        this.draw(null, this.time);
    }

    private function updater(_arg1:Event):void {
        if (this.time != 0) {
            this.dt = (getTimer() - this.time);
        }
        this.time = getTimer();
        this.update(this.time, this.dt);
        this.draw(null, this.time);
    }

    public function doNova(_arg1:Number, _arg2:Number, _arg3:int = 20, _arg4:int = 12447231):void {
        var _local5:GameObject = new GameObject(null);
        _local5.x_ = getLocalPos(_arg1);
        _local5.y_ = getLocalPos(_arg2);
        var _local6:NovaEffect = new NovaEffect(_local5, _arg3, _arg4);
        this.addObj(_local6, _local5.x_, _local5.y_);
    }

    private function doSnow(_arg1:Number, _arg2:Number, _arg3:int = 20, _arg4:int = 12447231):void {
        var _local5:WorldPosData = new WorldPosData();
        var _local6:WorldPosData = new WorldPosData();
        _local5.x_ = getLocalPos(_arg1);
        _local5.y_ = getLocalPos(_arg2);
        _local6.x_ = getLocalPos(_arg1);
        _local6.y_ = getLocalPos(600);
        var _local7:ConfettiEffect = new ConfettiEffect(_local5, _local6, _arg4, _arg3, true);
        this.addObj(_local7, _local5.x_, _local5.y_);
    }

    public function doLightning(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:int = 200, _arg6:int = 12447231, _arg7:Number = 1):void {
        var _local8:GameObject = new GameObject(null);
        _local8.x_ = getLocalPos(_arg1);
        _local8.y_ = getLocalPos(_arg2);
        var _local9:WorldPosData = new WorldPosData();
        _local9.x_ = getLocalPos(_arg3);
        _local9.y_ = getLocalPos(_arg4);
        var _local10:LightningEffect = new LightningEffect(_local8, _local9, _arg6, _arg5, _arg7);
        this.addObj(_local10, _local8.x_, _local8.y_);
    }


}
}
