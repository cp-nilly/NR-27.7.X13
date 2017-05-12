package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;

public class Particle extends BasicObject {

    public var size_:int;
    public var color_:uint;
    protected var bitmapFill_:GraphicsBitmapFill;
    protected var path_:GraphicsPath;
    protected var vS_:Vector.<Number>;
    protected var fillMatrix_:Matrix;

    public function Particle(_arg1:uint, _arg2:Number, _arg3:int) {
        this.bitmapFill_ = new GraphicsBitmapFill(null, null, false, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, null);
        this.vS_ = new Vector.<Number>();
        this.fillMatrix_ = new Matrix();
        super();
        objectId_ = getNextFakeObjectId();
        this.setZ(_arg2);
        this.setColor(_arg1);
        this.setSize(_arg3);
    }

    public function moveTo(_arg1:Number, _arg2:Number):Boolean {
        var _local3:Square;
        _local3 = map_.getSquare(_arg1, _arg2);
        if (_local3 == null) {
            return (false);
        }
        x_ = _arg1;
        y_ = _arg2;
        square_ = _local3;
        return (true);
    }

    public function moveToInModal(_arg1:Number, _arg2:Number):Boolean {
        x_ = _arg1;
        y_ = _arg2;
        return (true);
    }

    public function setColor(_arg1:uint):void {
        this.color_ = _arg1;
    }

    public function setZ(_arg1:Number):void {
        z_ = _arg1;
    }

    public function setSize(_arg1:int):void {
        this.size_ = ((_arg1 / 100) * 5);
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        var _local4:BitmapData = TextureRedrawer.redrawSolidSquare(this.color_, this.size_);
        var _local5:int = _local4.width;
        var _local6:int = _local4.height;
        this.vS_.length = 0;
        this.vS_.push((posS_[3] - (_local5 / 2)), (posS_[4] - (_local6 / 2)), (posS_[3] + (_local5 / 2)), (posS_[4] - (_local6 / 2)), (posS_[3] + (_local5 / 2)), (posS_[4] + (_local6 / 2)), (posS_[3] - (_local5 / 2)), (posS_[4] + (_local6 / 2)));
        this.path_.data = this.vS_;
        this.bitmapFill_.bitmapData = _local4;
        this.fillMatrix_.identity();
        this.fillMatrix_.translate(this.vS_[0], this.vS_[1]);
        this.bitmapFill_.matrix = this.fillMatrix_;
        _arg1.push(this.bitmapFill_);
        _arg1.push(this.path_);
        _arg1.push(GraphicsUtil.END_FILL);
    }


}
}
