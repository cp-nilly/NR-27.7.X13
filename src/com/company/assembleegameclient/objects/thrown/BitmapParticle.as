package com.company.assembleegameclient.objects.thrown {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class BitmapParticle extends BasicObject {

    protected var bitmapFill_:GraphicsBitmapFill;
    protected var path_:GraphicsPath;
    protected var vS_:Vector.<Number>;
    protected var fillMatrix_:Matrix;
    public var size_:int;
    public var _bitmapData:BitmapData;
    protected var _rotationDelta:Number = 0;
    public var _rotation:Number = 0;

    public function BitmapParticle(_arg1:BitmapData, _arg2:Number) {
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.vS_ = new Vector.<Number>();
        this.fillMatrix_ = new Matrix();
        super();
        hasShadow_ = false;
        objectId_ = getNextFakeObjectId();
        this._bitmapData = _arg1;
        z_ = _arg2;
    }

    public function moveTo(_arg1:Number, _arg2:Number):Boolean {
        var _local3:Square;
        _local3 = map_.getSquare(_arg1, _arg2);
        if (!_local3) {
            return (false);
        }
        x_ = _arg1;
        y_ = _arg2;
        square_ = _local3;
        return (true);
    }

    public function setSize(_arg1:int):void {
        this.size_ = ((_arg1 / 100) * 5);
    }

    override public function drawShadow(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
    }

    override public function draw(graphicsData:Vector.<IGraphicsData>, camera:Camera, time:int):void {
        var texture:BitmapData;
        var w:int;
        var h:int;
        try {
            texture = this._bitmapData;
            w = texture.width;
            h = texture.height;
            if (((!(w)) || (!(h)))) {
                return;
            }
            this.vS_.length = 0;
            this.vS_.push((posS_[3] - (w / 2)), (posS_[4] - (h / 2)), (posS_[3] + (w / 2)), (posS_[4] - (h / 2)), (posS_[3] + (w / 2)), (posS_[4] + (h / 2)), (posS_[3] - (w / 2)), (posS_[4] + (h / 2)));
            this.path_.data = this.vS_;
            this.bitmapFill_.bitmapData = texture;
            this.fillMatrix_.identity();
            if (((this._rotation) || (this._rotationDelta))) {
                if (this._rotationDelta) {
                    this._rotation = (this._rotation + this._rotationDelta);
                }
                this.fillMatrix_.translate((-(w) / 2), (-(h) / 2));
                this.fillMatrix_.rotate(this._rotation);
                this.fillMatrix_.translate((w / 2), (h / 2));
            }
            this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
            this.bitmapFill_.matrix = this.fillMatrix_;
            graphicsData.push(this.bitmapFill_);
            graphicsData.push(this.bitmapFill_);
            graphicsData.push(this.path_);
            graphicsData.push(GraphicsUtil.END_FILL);
        }
        catch (error:Error) {
            return;
        }
    }


}
}
