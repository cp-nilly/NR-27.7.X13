package com.company.assembleegameclient.background {
import com.company.assembleegameclient.map.Camera;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class NexusBackground extends Background {

    public static const MOVEMENT:Point = new Point(0.01, 0.01);

    private var water_:BitmapData;
    private var islands_:Vector.<Island>;
    protected var graphicsData_:Vector.<IGraphicsData>;
    private var bitmapFill_:GraphicsBitmapFill;
    private var path_:GraphicsPath;

    public function NexusBackground() {
        this.islands_ = new Vector.<Island>();
        this.graphicsData_ = new Vector.<IGraphicsData>();
        this.bitmapFill_ = new GraphicsBitmapFill(null, new Matrix(), true, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        super();
        this.water_ = new BitmapDataSpy(0x0400, 0x0400, false, 0);
        this.water_.perlinNoise(0x0400, 0x0400, 8, Math.random(), true, true, BitmapDataChannel.BLUE, false, null);
    }

    override public function draw(_arg1:Camera, _arg2:int):void {
        this.graphicsData_.length = 0;
        var _local3:Matrix = this.bitmapFill_.matrix;
        _local3.identity();
        _local3.translate((_arg2 * MOVEMENT.x), (_arg2 * MOVEMENT.y));
        _local3.rotate(-(_arg1.angleRad_));
        this.bitmapFill_.bitmapData = this.water_;
        this.graphicsData_.push(this.bitmapFill_);
        this.path_.data.length = 0;
        var _local4:Rectangle = _arg1.clipRect_;
        this.path_.data.push(_local4.left, _local4.top, _local4.right, _local4.top, _local4.right, _local4.bottom, _local4.left, _local4.bottom);
        this.graphicsData_.push(this.path_);
        this.graphicsData_.push(GraphicsUtil.END_FILL);
        this.drawIslands(_arg1, _arg2);
        graphics.clear();
        graphics.drawGraphicsData(this.graphicsData_);
    }

    private function drawIslands(_arg1:Camera, _arg2:int):void {
        var _local4:Island;
        var _local3:int;
        while (_local3 < this.islands_.length) {
            _local4 = this.islands_[_local3];
            _local4.draw(_arg1, _arg2, this.graphicsData_);
            _local3++;
        }
    }


}
}

import com.company.assembleegameclient.background.NexusBackground;
import com.company.assembleegameclient.map.Camera;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.geom.Matrix;
import flash.geom.Point;

class Island {

    public var center_:Point;
    public var startTime_:int;
    public var bitmapData_:BitmapData;
    /*private*/
    var bitmapFill_:GraphicsBitmapFill;
    /*private*/
    var path_:GraphicsPath;

    public function Island(_arg1:Number, _arg2:Number, _arg3:int):void {
        this.bitmapFill_ = new GraphicsBitmapFill(null, new Matrix(), true, false);
        this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS, new Vector.<Number>());
        super();
        this.center_ = new Point(_arg1, _arg2);
        this.startTime_ = _arg3;
        this.bitmapData_ = AssetLibrary.getImage("stars");
    }

    public function draw(_arg1:Camera, _arg2:int, _arg3:Vector.<IGraphicsData>):void {
        var _local4:int = (_arg2 - this.startTime_);
        var _local5:Number = (this.center_.x + (_local4 * NexusBackground.MOVEMENT.x));
        var _local6:Number = (this.center_.y + (_local4 * NexusBackground.MOVEMENT.y));
        var _local7:Matrix = this.bitmapFill_.matrix;
        _local7.identity();
        _local7.translate(_local5, _local6);
        _local7.rotate(-(_arg1.angleRad_));
        this.bitmapFill_.bitmapData = this.bitmapData_;
        _arg3.push(this.bitmapFill_);
        this.path_.data.length = 0;
        var _local8:Point = _local7.transformPoint(new Point(_local5, _local6));
        var _local9:Point = _local7.transformPoint(new Point((_local5 + this.bitmapData_.width), (_local6 + this.bitmapData_.height)));
        this.path_.data.push(_local8.x, _local8.y, _local9.x, _local8.y, _local9.x, _local9.y, _local8.x, _local9.y);
        _arg3.push(this.path_);
        _arg3.push(GraphicsUtil.END_FILL);
    }


}

