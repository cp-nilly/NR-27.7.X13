package com.company.assembleegameclient.engine3d {
import flash.display.BitmapData;
import flash.geom.Matrix;

public class TextureMatrix {

    public var texture_:BitmapData = null;
    public var tToS_:Matrix;
    private var uvMatrix_:Matrix = null;
    private var tempMatrix_:Matrix;

    public function TextureMatrix(_arg1:BitmapData, _arg2:Vector.<Number>) {
        this.tToS_ = new Matrix();
        this.tempMatrix_ = new Matrix();
        super();
        this.texture_ = _arg1;
        this.calculateUVMatrix(_arg2);
    }

    public function setUVT(_arg1:Vector.<Number>):void {
        this.calculateUVMatrix(_arg1);
    }

    public function setVOut(_arg1:Vector.<Number>):void {
        this.calculateTextureMatrix(_arg1);
    }

    public function calculateTextureMatrix(_arg1:Vector.<Number>):void {
        this.tToS_.a = this.uvMatrix_.a;
        this.tToS_.b = this.uvMatrix_.b;
        this.tToS_.c = this.uvMatrix_.c;
        this.tToS_.d = this.uvMatrix_.d;
        this.tToS_.tx = this.uvMatrix_.tx;
        this.tToS_.ty = this.uvMatrix_.ty;
        var _local2:int = (_arg1.length - 2);
        var _local3:int = (_local2 + 1);
        this.tempMatrix_.a = (_arg1[2] - _arg1[0]);
        this.tempMatrix_.b = (_arg1[3] - _arg1[1]);
        this.tempMatrix_.c = (_arg1[_local2] - _arg1[0]);
        this.tempMatrix_.d = (_arg1[_local3] - _arg1[1]);
        this.tempMatrix_.tx = _arg1[0];
        this.tempMatrix_.ty = _arg1[1];
        this.tToS_.concat(this.tempMatrix_);
    }

    public function calculateUVMatrix(_arg1:Vector.<Number>):void {
        if (this.texture_ == null) {
            this.uvMatrix_ = null;
            return;
        }
        var _local2:int = (_arg1.length - 3);
        var _local3:Number = (_arg1[0] * this.texture_.width);
        var _local4:Number = (_arg1[1] * this.texture_.height);
        var _local5:Number = (_arg1[3] * this.texture_.width);
        var _local6:Number = (_arg1[4] * this.texture_.height);
        var _local7:Number = (_arg1[_local2] * this.texture_.width);
        var _local8:Number = (_arg1[(_local2 + 1)] * this.texture_.height);
        var _local9:Number = (_local5 - _local3);
        var _local10:Number = (_local6 - _local4);
        var _local11:Number = (_local7 - _local3);
        var _local12:Number = (_local8 - _local4);
        this.uvMatrix_ = new Matrix(_local9, _local10, _local11, _local12, _local3, _local4);
        this.uvMatrix_.invert();
    }


}
}
