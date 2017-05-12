package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.thrown.BitmapParticle;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.geom.Point;

public class ShockParticle extends BitmapParticle {

    private var numFramesRemaining:int;
    private var dx_:Number;
    private var dy_:Number;
    private var originX:Number;
    private var originY:Number;
    private var radians:Number;
    private var frameUpdateModulator:uint = 0;
    private var currentFrame:uint = 0;
    private var numFrames:uint;
    private var go:GameObject;
    private var plusX:Number = 0;
    private var plusY:Number = 0;
    private var cameraAngle:Number;
    private var images:Vector.<BitmapData>;

    public function ShockParticle(_arg1:uint, _arg2:int, _arg3:uint, _arg4:Point, _arg5:Point, _arg6:Number, _arg7:GameObject, _arg8:Vector.<BitmapData>) {
        this.cameraAngle = Parameters.data_.cameraAngle;
        this.go = _arg7;
        this.radians = _arg6;
        this.images = _arg8;
        super(_arg8[0], 0);
        this.numFrames = _arg8.length;
        this.numFramesRemaining = _arg2;
        this.dx_ = ((_arg5.x - _arg4.x) / this.numFramesRemaining);
        this.dy_ = ((_arg5.y - _arg4.y) / this.numFramesRemaining);
        this.originX = (_arg4.x - _arg7.x_);
        this.originY = (_arg4.y - _arg7.y_);
        _rotation = (-(_arg6) - this.cameraAngle);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        this.numFramesRemaining--;
        if (this.numFramesRemaining <= 0) {
            return (false);
        }
        this.frameUpdateModulator++;
        if ((this.frameUpdateModulator % 2)) {
            this.currentFrame++;
        }
        _bitmapData = this.images[(this.currentFrame % this.numFrames)];
        this.plusX = (this.plusX + this.dx_);
        this.plusY = (this.plusY + this.dy_);
        if (Parameters.data_.cameraAngle != this.cameraAngle) {
            this.cameraAngle = Parameters.data_.cameraAngle;
            _rotation = (-(this.radians) - this.cameraAngle);
        }
        moveTo(((this.go.x_ + this.originX) + this.plusX), ((this.go.y_ + this.originY) + this.plusY));
        return (true);
    }


}
}
