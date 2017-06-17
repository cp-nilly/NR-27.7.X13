package com.company.assembleegameclient.engine3d {
import flash.display.BitmapData;
import flash.geom.Matrix;

public class TextureMatrix {

    public var texture_:BitmapData = null;
    public var tToS_:Matrix;
    private var uvMatrix_:Matrix;
    private var tempMatrix_:Matrix;

    public function TextureMatrix(_arg1:BitmapData, _arg2:Vector.<Number>) {
        this.tToS_ = new Matrix();
        this.uvMatrix_ = new Matrix();
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

    public function calculateTextureMatrix(vout:Vector.<Number>):void {
        this.tToS_.a = this.uvMatrix_.a;
        this.tToS_.b = this.uvMatrix_.b;
        this.tToS_.c = this.uvMatrix_.c;
        this.tToS_.d = this.uvMatrix_.d;
        this.tToS_.tx = this.uvMatrix_.tx;
        this.tToS_.ty = this.uvMatrix_.ty;
        var i:int = vout.length - 2;
        var j:int = i + 1;
        this.tempMatrix_.a = vout[2] - vout[0];
        this.tempMatrix_.b = vout[3] - vout[1];
        this.tempMatrix_.c = vout[i] - vout[0];
        this.tempMatrix_.d = vout[j] - vout[1];
        this.tempMatrix_.tx = vout[0];
        this.tempMatrix_.ty = vout[1];
        this.tToS_.concat(this.tempMatrix_);
    }

    public function calculateUVMatrix(uvt:Vector.<Number>):void {
        if (this.texture_ == null) {
            this.uvMatrix_ = null;
            return;
        }

        var i:int = uvt.length - 3;
        var tx:Number = uvt[0] * this.texture_.width;
        var ty:Number = uvt[1] * this.texture_.height;
        this.uvMatrix_.a = uvt[3] * this.texture_.width - tx;
        this.uvMatrix_.b = uvt[4] * this.texture_.height - ty;
        this.uvMatrix_.c = uvt[i] * this.texture_.width - tx;
        this.uvMatrix_.d = uvt[i + 1] * this.texture_.height - ty;
        this.uvMatrix_.tx = tx;
        this.uvMatrix_.ty = ty;
        this.uvMatrix_.invert();
    }


}
}
