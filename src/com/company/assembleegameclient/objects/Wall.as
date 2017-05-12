package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.Face3D;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

public class Wall extends GameObject {

    private static const UVT:Vector.<Number> = new <Number>[0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0];
    private static const sqX:Vector.<int> = new <int>[0, 1, 0, -1];
    private static const sqY:Vector.<int> = new <int>[-1, 0, 1, 0];

    public var faces_:Vector.<Face3D>;
    private var topFace_:Face3D = null;
    private var topTexture_:BitmapData = null;

    public function Wall(_arg1:XML) {
        this.faces_ = new Vector.<Face3D>();
        super(_arg1);
        hasShadow_ = false;
        var _local2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
        this.topTexture_ = _local2.getTexture(0);
    }

    override public function setObjectId(_arg1:int):void {
        super.setObjectId(_arg1);
        var _local2:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
        this.topTexture_ = _local2.getTexture(_arg1);
    }

    override public function getColor():uint {
        return (BitmapUtil.mostCommonColor(this.topTexture_));
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        var _local6:BitmapData;
        var _local7:Face3D;
        var _local8:Square;
        if (texture_ == null) {
            return;
        }
        if (this.faces_.length == 0) {
            this.rebuild3D();
        }
        var _local4:BitmapData = texture_;
        if (animations_ != null) {
            _local6 = animations_.getTexture(_arg3);
            if (_local6 != null) {
                _local4 = _local6;
            }
        }
        var _local5:int;
        while (_local5 < this.faces_.length) {
            _local7 = this.faces_[_local5];
            _local8 = map_.lookupSquare((x_ + sqX[_local5]), (y_ + sqY[_local5]));
            if ((((((_local8 == null)) || ((_local8.texture_ == null)))) || (((((!((_local8 == null))) && ((_local8.obj_ is Wall)))) && (!(_local8.obj_.dead_)))))) {
                _local7.blackOut_ = true;
            }
            else {
                _local7.blackOut_ = false;
                if (animations_ != null) {
                    _local7.setTexture(_local4);
                }
            }
            _local7.draw(_arg1, _arg2);
            _local5++;
        }
        this.topFace_.draw(_arg1, _arg2);
    }

    public function rebuild3D():void {
        this.faces_.length = 0;
        var _local1:int = x_;
        var _local2:int = y_;
        var _local3:Vector.<Number> = new <Number>[_local1, _local2, 1, (_local1 + 1), _local2, 1, (_local1 + 1), (_local2 + 1), 1, _local1, (_local2 + 1), 1];
        this.topFace_ = new Face3D(this.topTexture_, _local3, UVT, false, true);
        this.topFace_.bitmapFill_.repeat = true;
        this.addWall(_local1, _local2, 1, (_local1 + 1), _local2, 1);
        this.addWall((_local1 + 1), _local2, 1, (_local1 + 1), (_local2 + 1), 1);
        this.addWall((_local1 + 1), (_local2 + 1), 1, _local1, (_local2 + 1), 1);
        this.addWall(_local1, (_local2 + 1), 1, _local1, _local2, 1);
    }

    private function addWall(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number):void {
        var _local7:Vector.<Number> = new <Number>[_arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg4, _arg5, (_arg6 - 1), _arg1, _arg2, (_arg3 - 1)];
        var _local8:Face3D = new Face3D(texture_, _local7, UVT, true, true);
        _local8.bitmapFill_.repeat = true;
        this.faces_.push(_local8);
    }


}
}
