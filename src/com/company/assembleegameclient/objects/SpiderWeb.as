package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Square;

import flash.display.IGraphicsData;

public class SpiderWeb extends GameObject {

    private var wallFound_:Boolean = false;

    public function SpiderWeb(_arg1:XML) {
        super(_arg1);
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        if (!this.wallFound_) {
            this.wallFound_ = this.findWall();
        }
        if (this.wallFound_) {
            super.draw(_arg1, _arg2, _arg3);
        }
    }

    private function findWall():Boolean {
        var _local1:Square;
        _local1 = map_.lookupSquare((x_ - 1), y_);
        if (((!((_local1 == null))) && ((_local1.obj_ is Wall)))) {
            return (true);
        }
        _local1 = map_.lookupSquare(x_, (y_ - 1));
        if (((!((_local1 == null))) && ((_local1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 90);
            return (true);
        }
        _local1 = map_.lookupSquare((x_ + 1), y_);
        if (((!((_local1 == null))) && ((_local1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 180);
            return (true);
        }
        _local1 = map_.lookupSquare(x_, (y_ + 1));
        if (((!((_local1 == null))) && ((_local1.obj_ is Wall)))) {
            obj3D_.setPosition(x_, y_, 0, 270);
            return (true);
        }
        return (false);
    }


}
}
