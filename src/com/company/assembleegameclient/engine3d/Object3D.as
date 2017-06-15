package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.map.Camera;

import flash.display.BitmapData;
import flash.display.IGraphicsData;
import flash.geom.Matrix3D;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class Object3D {

    public var model_:Model3D = null;
    public var vL_:Vector.<Number>;
    public var uvts_:Vector.<Number>;
    public var faces_:Vector.<ObjectFace3D>;
    public var vS_:Vector.<Number>;
    public var vW_:Vector.<Number>;
    public var lToW_:Matrix3D;

    public function Object3D(_arg1:Model3D = null) {
        var _local2:ModelFace3D;
        this.faces_ = new Vector.<ObjectFace3D>();
        this.vS_ = new Vector.<Number>();
        this.vW_ = new Vector.<Number>();
        this.lToW_ = new Matrix3D();
        super();
        if (_arg1 != null) {
            this.model_ = _arg1;
            this.vL_ = this.model_.vL_;
            this.uvts_ = this.model_.uvts_.concat();
            for each (_local2 in this.model_.faces_) {
                this.faces_.push(new ObjectFace3D(this, _local2.indicies_, _local2.useTexture_));
            }
        }
        else {
            this.vL_ = new Vector.<Number>();
            this.uvts_ = new Vector.<Number>();
        }
        this.setPosition(0, 0, 0, 0);
    }

    public static function getObject(_arg1:String):Object3D {
        var _local2:Model3D = Model3D.getModel(_arg1);
        return (new Object3D(_local2));
    }


    public function dispose():void {
        var _local1:ObjectFace3D;
        this.vL_ = null;
        this.uvts_ = null;
        for each (_local1 in this.faces_) {
            _local1.dispose();
        }
        this.faces_.length = 0;
        this.faces_ = null;
        this.vS_ = null;
        this.vW_ = null;
        this.lToW_ = null;
    }

    public function setPosition(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):void {
        var _local5:ObjectFace3D;
        this.lToW_.identity();
        this.lToW_.appendRotation(_arg4, Vector3D.Z_AXIS);
        this.lToW_.appendTranslation(_arg1, _arg2, _arg3);
        this.lToW_.transformVectors(this.vL_, this.vW_);
        for each (_local5 in this.faces_) {
            _local5.computeLighting();
        }
    }

    public function getVecW(_arg1:int):Vector3D {
        var _local2:int = (_arg1 * 3);
        if (_local2 >= this.vW_.length) {
            return (null);
        }
        return (new Vector3D(this.vW_[_local2], this.vW_[(_local2 + 1)], this.vW_[(_local2 + 2)]));
    }

    public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:uint, _arg4:BitmapData):void {
        var _local5:ObjectFace3D;
        Utils3D.projectVectors(_arg2.wToS_, this.vW_, this.vS_, this.uvts_);
        for each (_local5 in this.faces_) {
            _local5.draw(_arg1, _arg3, _arg4);
        }
    }


}
}
