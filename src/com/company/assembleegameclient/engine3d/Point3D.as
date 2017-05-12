package com.company.assembleegameclient.engine3d {
import com.company.assembleegameclient.map.Camera;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Matrix3D;
import flash.geom.Utils3D;
import flash.geom.Vector3D;

public class Point3D {

    private static const commands_:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO];
    private static const END_FILL:GraphicsEndFill = new GraphicsEndFill();

    private const data_:Vector.<Number> = new Vector.<Number>();
    private const path_:GraphicsPath = new GraphicsPath(commands_, data_);
    private const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill(null, new Matrix(), false, false);
    private const solidFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);

    public var size_:Number;
    public var posS_:Vector3D;

    public function Point3D(_arg1:Number) {
        this.size_ = _arg1;
    }

    public function setSize(_arg1:Number):void {
        this.size_ = _arg1;
    }

    public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Vector3D, _arg3:Number, _arg4:Matrix3D, _arg5:Camera, _arg6:BitmapData, _arg7:uint = 0):void {
        var _local10:Number;
        var _local11:Number;
        var _local12:Matrix;
        this.posS_ = Utils3D.projectVector(_arg4, _arg2);
        if (this.posS_.w < 0) {
            return;
        }
        var _local8:Number = (this.posS_.w * Math.sin(((_arg5.pp_.fieldOfView / 2) * Trig.toRadians)));
        var _local9:Number = (this.size_ / _local8);
        this.data_.length = 0;
        if (_arg3 == 0) {
            this.data_.push((this.posS_.x - _local9), (this.posS_.y - _local9), (this.posS_.x + _local9), (this.posS_.y - _local9), (this.posS_.x + _local9), (this.posS_.y + _local9), (this.posS_.x - _local9), (this.posS_.y + _local9));
        }
        else {
            _local10 = Math.cos(_arg3);
            _local11 = Math.sin(_arg3);
            this.data_.push((this.posS_.x + ((_local10 * -(_local9)) + (_local11 * -(_local9)))), (this.posS_.y + ((_local11 * -(_local9)) - (_local10 * -(_local9)))), (this.posS_.x + ((_local10 * _local9) + (_local11 * -(_local9)))), (this.posS_.y + ((_local11 * _local9) - (_local10 * -(_local9)))), (this.posS_.x + ((_local10 * _local9) + (_local11 * _local9))), (this.posS_.y + ((_local11 * _local9) - (_local10 * _local9))), (this.posS_.x + ((_local10 * -(_local9)) + (_local11 * _local9))), (this.posS_.y + ((_local11 * -(_local9)) - (_local10 * _local9))));
        }
        if (_arg6 != null) {
            this.bitmapFill_.bitmapData = _arg6;
            _local12 = this.bitmapFill_.matrix;
            _local12.identity();
            _local12.scale(((2 * _local9) / _arg6.width), ((2 * _local9) / _arg6.height));
            _local12.translate(-(_local9), -(_local9));
            _local12.rotate(_arg3);
            _local12.translate(this.posS_.x, this.posS_.y);
            _arg1.push(this.bitmapFill_);
        }
        else {
            this.solidFill_.color = _arg7;
            _arg1.push(this.solidFill_);
        }
        _arg1.push(this.path_);
        _arg1.push(END_FILL);
    }


}
}
