package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class ObjectFace3D {

    public static const blackBitmap:BitmapData = new BitmapData(1, 1, true, 0xFF000000);

    public const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill();

    public var obj_:Object3D;
    public var indices_:Vector.<int>;
    public var useTexture_:Boolean;
    public var softwareException_:Boolean = false;
    public var texture_:BitmapData = null;
    public var normalL_:Vector3D = null;
    public var normalW_:Vector3D;
    public var shade_:Number = 1;
    private var path_:GraphicsPath;
    private var solidFill_:GraphicsSolidFill;
    private var tToS_:Matrix;
    private var tempMatrix_:Matrix;

    public function ObjectFace3D(_arg1:Object3D, _arg2:Vector.<int>, _arg3:Boolean = true) {
        this.solidFill_ = new GraphicsSolidFill(0xFFFFFF, 1);
        this.tToS_ = new Matrix();
        this.tempMatrix_ = new Matrix();
        super();
        this.obj_ = _arg1;
        this.indices_ = _arg2;
        this.useTexture_ = _arg3;
        var _local4:Vector.<int> = new Vector.<int>();
        var _local5:int;
        while (_local5 < this.indices_.length) {
            _local4.push((((_local5 == 0)) ? GraphicsPathCommand.MOVE_TO : GraphicsPathCommand.LINE_TO));
            _local5++;
        }
        var _local6:Vector.<Number> = new Vector.<Number>();
        _local6.length = (this.indices_.length * 2);
        this.path_ = new GraphicsPath(_local4, _local6);
    }

    public function dispose():void {
        this.indices_ = null;
        this.path_.commands = null;
        this.path_.data = null;
        this.path_ = null;
    }

    public function computeLighting():void {
        this.normalW_ = new Vector3D();
        Plane3D.computeNormal(this.obj_.getVecW(this.indices_[0]), this.obj_.getVecW(this.indices_[1]), this.obj_.getVecW(this.indices_[(this.indices_.length - 1)]), this.normalW_);
        this.shade_ = Lighting3D.shadeValue(this.normalW_, 0.75);
        if (this.normalL_ != null) {
            this.normalW_ = this.obj_.lToW_.deltaTransformVector(this.normalL_);
        }
    }

    public function draw(_arg1:Vector.<IGraphicsData>, _arg2:uint, _arg3:BitmapData):void {
        var _local13:int;
        var _local4:int = (this.indices_[0] * 2);
        var _local5:int = (this.indices_[1] * 2);
        var _local6:int = (this.indices_[(this.indices_.length - 1)] * 2);
        var _local7:Vector.<Number> = this.obj_.vS_;
        var _local8:Number = (_local7[_local5] - _local7[_local4]);
        var _local9:Number = (_local7[(_local5 + 1)] - _local7[(_local4 + 1)]);
        var _local10:Number = (_local7[_local6] - _local7[_local4]);
        var _local11:Number = (_local7[(_local6 + 1)] - _local7[(_local4 + 1)]);
        if (((_local8 * _local11) - (_local9 * _local10)) < 0) {
            return;
        }
        if (((!(Parameters.data_.GPURender)) && (((!(this.useTexture_)) || ((_arg3 == null)))))) {
            this.solidFill_.color = MoreColorUtil.transformColor(new ColorTransform(this.shade_, this.shade_, this.shade_), _arg2);
            _arg1.push(this.solidFill_);
        }
        else {
            if ((((_arg3 == null)) && (Parameters.data_.GPURender))) {
                _arg3 = blackBitmap;
            }
            else {
                _arg3 = TextureRedrawer.redrawFace(_arg3, this.shade_);
            }
            this.bitmapFill_.bitmapData = _arg3;
            this.bitmapFill_.matrix = this.tToS(_arg3);
            _arg1.push(this.bitmapFill_);
        }
        var _local12:int;
        while (_local12 < this.indices_.length) {
            _local13 = this.indices_[_local12];
            this.path_.data[(_local12 * 2)] = _local7[(_local13 * 2)];
            this.path_.data[((_local12 * 2) + 1)] = _local7[((_local13 * 2) + 1)];
            _local12++;
        }
        _arg1.push(this.path_);
        _arg1.push(GraphicsUtil.END_FILL);
        if (((((this.softwareException_) && (Parameters.isGpuRender()))) && (!((this.bitmapFill_ == null))))) {
            GraphicsFillExtra.setSoftwareDraw(this.bitmapFill_, true);
        }
    }

    private function tToS(_arg1:BitmapData):Matrix {
        var _local2:Vector.<Number> = this.obj_.uvts_;
        var _local3:int = (this.indices_[0] * 3);
        var _local4:int = (this.indices_[1] * 3);
        var _local5:int = (this.indices_[(this.indices_.length - 1)] * 3);
        var _local6:Number = (_local2[_local3] * _arg1.width);
        var _local7:Number = (_local2[(_local3 + 1)] * _arg1.height);
        this.tToS_.a = ((_local2[_local4] * _arg1.width) - _local6);
        this.tToS_.b = ((_local2[(_local4 + 1)] * _arg1.height) - _local7);
        this.tToS_.c = ((_local2[_local5] * _arg1.width) - _local6);
        this.tToS_.d = ((_local2[(_local5 + 1)] * _arg1.height) - _local7);
        this.tToS_.tx = _local6;
        this.tToS_.ty = _local7;
        this.tToS_.invert();
        _local3 = (this.indices_[0] * 2);
        _local4 = (this.indices_[1] * 2);
        _local5 = (this.indices_[(this.indices_.length - 1)] * 2);
        var _local8:Vector.<Number> = this.obj_.vS_;
        this.tempMatrix_.a = (_local8[_local4] - _local8[_local3]);
        this.tempMatrix_.b = (_local8[(_local4 + 1)] - _local8[(_local3 + 1)]);
        this.tempMatrix_.c = (_local8[_local5] - _local8[_local3]);
        this.tempMatrix_.d = (_local8[(_local5 + 1)] - _local8[(_local3 + 1)]);
        this.tempMatrix_.tx = _local8[_local3];
        this.tempMatrix_.ty = _local8[(_local3 + 1)];
        this.tToS_.concat(this.tempMatrix_);
        return (this.tToS_);
    }


}
}
