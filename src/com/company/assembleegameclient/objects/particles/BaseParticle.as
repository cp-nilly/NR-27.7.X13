package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class BaseParticle extends BasicObject {

    public var timeLeft:Number = 0;
    public var spdX:Number;
    public var spdY:Number;
    public var spdZ:Number;
    protected var vS_:Vector.<Number>;
    protected var fillMatrix_:Matrix;
    protected var path_:GraphicsPath;
    protected var bitmapFill_:GraphicsBitmapFill;

    public function BaseParticle(_arg1:BitmapData) {
        this.vS_ = new Vector.<Number>(8);
        this.fillMatrix_ = new Matrix();
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        super();
        this.bitmapFill_.bitmapData = _arg1;
        objectId_ = getNextFakeObjectId();
    }

    public function initialize(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:int):void {
        this.timeLeft = _arg1;
        this.spdX = _arg2;
        this.spdY = _arg3;
        this.spdZ = _arg4;
        z_ = _arg5;
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        var _local4:Number = (this.bitmapFill_.bitmapData.width / 2);
        var _local5:Number = (this.bitmapFill_.bitmapData.height / 2);
        this.vS_[6] = (this.vS_[0] = (posS_[3] - _local4));
        this.vS_[3] = (this.vS_[1] = (posS_[4] - _local5));
        this.vS_[4] = (this.vS_[2] = (posS_[3] + _local4));
        this.vS_[7] = (this.vS_[5] = (posS_[4] + _local5));
        this.path_.data = this.vS_;
        this.fillMatrix_.identity();
        this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
        this.bitmapFill_.matrix = this.fillMatrix_;
        _arg1.push(this.bitmapFill_);
        _arg1.push(this.path_);
        _arg1.push(GraphicsUtil.END_FILL);
    }

    override public function removeFromMap():void {
        map_ = null;
        square_ = null;
    }


}
}
