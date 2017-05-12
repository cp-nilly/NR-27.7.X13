package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.engine3d.ObjectFace3D;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.GraphicsFillExtra;

public class CaveWall extends ConnectedObject {

    public function CaveWall(_arg1:XML) {
        super(_arg1);
    }

    override protected function buildDot():void {
        var _local6:ObjectFace3D;
        var _local1:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (-0.25 - (Math.random() * 0.25)), 0);
        var _local2:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (-0.25 - (Math.random() * 0.25)), 0);
        var _local3:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local4:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local5:Vector3D = new Vector3D((-0.25 + (Math.random() * 0.5)), (-0.25 + (Math.random() * 0.5)), 1);
        this.faceHelper(null, texture_, _local5, _local1, _local2);
        this.faceHelper(null, texture_, _local5, _local2, _local3);
        this.faceHelper(null, texture_, _local5, _local3, _local4);
        this.faceHelper(null, texture_, _local5, _local4, _local1);
        if (Parameters.isGpuRender()) {
            for each (_local6 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local6.bitmapFill_, true);
            }
        }
    }

    override protected function buildShortLine():void {
        var _local9:ObjectFace3D;
        var _local1:Vector3D = this.getVertex(0, 0);
        var _local2:Vector3D = this.getVertex(0, 3);
        var _local3:Vector3D = new Vector3D((0.25 + (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local4:Vector3D = new Vector3D((-0.25 - (Math.random() * 0.25)), (0.25 + (Math.random() * 0.25)), 0);
        var _local5:Vector3D = this.getVertex(0, 1);
        var _local6:Vector3D = this.getVertex(0, 2);
        var _local7:Vector3D = new Vector3D((Math.random() * 0.25), (Math.random() * 0.25), 0.5);
        var _local8:Vector3D = new Vector3D((Math.random() * -0.25), (Math.random() * 0.25), 0.5);
        this.faceHelper(null, texture_, _local5, _local8, _local4, _local1);
        this.faceHelper(null, texture_, _local8, _local7, _local3, _local4);
        this.faceHelper(null, texture_, _local7, _local6, _local2, _local3);
        this.faceHelper(null, texture_, _local5, _local6, _local7, _local8);
        if (Parameters.isGpuRender()) {
            for each (_local9 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local9.bitmapFill_, true);
            }
        }
    }

    override protected function buildL():void {
        var _local11:ObjectFace3D;
        var _local1:Vector3D = this.getVertex(0, 0);
        var _local2:Vector3D = this.getVertex(0, 3);
        var _local3:Vector3D = this.getVertex(1, 0);
        var _local4:Vector3D = this.getVertex(1, 3);
        var _local5:Vector3D = new Vector3D((-(Math.random()) * 0.25), (Math.random() * 0.25), 0);
        var _local6:Vector3D = this.getVertex(0, 1);
        var _local7:Vector3D = this.getVertex(0, 2);
        var _local8:Vector3D = this.getVertex(1, 1);
        var _local9:Vector3D = this.getVertex(1, 2);
        var _local10:Vector3D = new Vector3D((Math.random() * 0.25), (-(Math.random()) * 0.25), 1);
        this.faceHelper(null, texture_, _local6, _local10, _local5, _local1);
        this.faceHelper(null, texture_, _local10, _local9, _local4, _local5);
        this.faceHelper(N2, texture_, _local8, _local7, _local2, _local3);
        this.faceHelper(null, texture_, _local6, _local7, _local8, _local9, _local10);
        if (Parameters.isGpuRender()) {
            for each (_local11 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local11.bitmapFill_, true);
            }
        }
    }

    override protected function buildLine():void {
        var _local9:ObjectFace3D;
        var _local1:Vector3D = this.getVertex(0, 0);
        var _local2:Vector3D = this.getVertex(0, 3);
        var _local3:Vector3D = this.getVertex(2, 3);
        var _local4:Vector3D = this.getVertex(2, 0);
        var _local5:Vector3D = this.getVertex(0, 1);
        var _local6:Vector3D = this.getVertex(0, 2);
        var _local7:Vector3D = this.getVertex(2, 2);
        var _local8:Vector3D = this.getVertex(2, 1);
        this.faceHelper(N7, texture_, _local5, _local8, _local4, _local1);
        this.faceHelper(N3, texture_, _local7, _local6, _local2, _local3);
        this.faceHelper(null, texture_, _local5, _local6, _local7, _local8);
        if (Parameters.isGpuRender()) {
            for each (_local9 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local9.bitmapFill_, true);
            }
        }
    }

    override protected function buildT():void {
        var _local13:ObjectFace3D;
        var _local1:Vector3D = this.getVertex(0, 0);
        var _local2:Vector3D = this.getVertex(0, 3);
        var _local3:Vector3D = this.getVertex(1, 0);
        var _local4:Vector3D = this.getVertex(1, 3);
        var _local5:Vector3D = this.getVertex(3, 3);
        var _local6:Vector3D = this.getVertex(3, 0);
        var _local7:Vector3D = this.getVertex(0, 1);
        var _local8:Vector3D = this.getVertex(0, 2);
        var _local9:Vector3D = this.getVertex(1, 1);
        var _local10:Vector3D = this.getVertex(1, 2);
        var _local11:Vector3D = this.getVertex(3, 2);
        var _local12:Vector3D = this.getVertex(3, 1);
        this.faceHelper(N2, texture_, _local9, _local8, _local2, _local3);
        this.faceHelper(null, texture_, _local11, _local10, _local4, _local5);
        this.faceHelper(N0, texture_, _local7, _local12, _local6, _local1);
        this.faceHelper(null, texture_, _local7, _local8, _local9, _local10, _local11, _local12);
        if (Parameters.isGpuRender()) {
            for each (_local13 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local13.bitmapFill_, true);
            }
        }
    }

    override protected function buildCross():void {
        var _local17:ObjectFace3D;
        var _local1:Vector3D = this.getVertex(0, 0);
        var _local2:Vector3D = this.getVertex(0, 3);
        var _local3:Vector3D = this.getVertex(1, 0);
        var _local4:Vector3D = this.getVertex(1, 3);
        var _local5:Vector3D = this.getVertex(2, 3);
        var _local6:Vector3D = this.getVertex(2, 0);
        var _local7:Vector3D = this.getVertex(3, 3);
        var _local8:Vector3D = this.getVertex(3, 0);
        var _local9:Vector3D = this.getVertex(0, 1);
        var _local10:Vector3D = this.getVertex(0, 2);
        var _local11:Vector3D = this.getVertex(1, 1);
        var _local12:Vector3D = this.getVertex(1, 2);
        var _local13:Vector3D = this.getVertex(2, 2);
        var _local14:Vector3D = this.getVertex(2, 1);
        var _local15:Vector3D = this.getVertex(3, 2);
        var _local16:Vector3D = this.getVertex(3, 1);
        this.faceHelper(N2, texture_, _local11, _local10, _local2, _local3);
        this.faceHelper(N4, texture_, _local13, _local12, _local4, _local5);
        this.faceHelper(N6, texture_, _local15, _local14, _local6, _local7);
        this.faceHelper(N0, texture_, _local9, _local16, _local8, _local1);
        this.faceHelper(null, texture_, _local9, _local10, _local11, _local12, _local13, _local14, _local15, _local16);
        if (Parameters.isGpuRender()) {
            for each (_local17 in obj3D_.faces_) {
                GraphicsFillExtra.setSoftwareDraw(_local17.bitmapFill_, true);
            }
        }
    }

    protected function getVertex(_arg1:int, _arg2:int):Vector3D {
        var _local6:int;
        var _local7:Number;
        var _local8:Number;
        var _local3:int = x_;
        var _local4:int = y_;
        var _local5:int = ((_arg1 + rotation_) % 4);
        switch (_local5) {
            case 1:
                _local3++;
                break;
            case 2:
                _local4++;
                break;
        }
        switch (_arg2) {
            case 0:
            case 3:
                _local6 = (15 + (((_local3 * 1259) ^ (_local4 * 2957)) % 35));
                break;
            case 1:
            case 2:
                _local6 = (3 + (((_local3 * 2179) ^ (_local4 * 1237)) % 35));
                break;
        }
        switch (_arg2) {
            case 0:
                _local7 = (-(_local6) / 100);
                _local8 = 0;
                break;
            case 1:
                _local7 = (-(_local6) / 100);
                _local8 = 1;
                break;
            case 2:
                _local7 = (_local6 / 100);
                _local8 = 1;
                break;
            case 3:
                _local7 = (_local6 / 100);
                _local8 = 0;
                break;
        }
        switch (_arg1) {
            case 0:
                return (new Vector3D(_local7, -0.5, _local8));
            case 1:
                return (new Vector3D(0.5, _local7, _local8));
            case 2:
                return (new Vector3D(_local7, 0.5, _local8));
            case 3:
                return (new Vector3D(-0.5, _local7, _local8));
        }
        return (null);
    }

    protected function faceHelper(_arg1:Vector3D, _arg2:BitmapData, ..._args):void {
        var _local5:Vector3D;
        var _local6:int;
        var _local7:int;
        var _local4:int = (obj3D_.vL_.length / 3);
        for each (_local5 in _args) {
            obj3D_.vL_.push(_local5.x, _local5.y, _local5.z);
        }
        _local6 = obj3D_.faces_.length;
        if (_args.length == 4) {
            obj3D_.uvts_.push(0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0);
            if (Math.random() < 0.5) {
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 3)]), new ObjectFace3D(obj3D_, new <int>[(_local4 + 1), (_local4 + 2), (_local4 + 3)]));
            }
            else {
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 2), (_local4 + 3)]), new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 2)]));
            }
        }
        else {
            if (_args.length == 3) {
                obj3D_.uvts_.push(0, 0, 0, 0, 1, 0, 1, 1, 0);
                obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 2)]));
            }
            else {
                if (_args.length == 5) {
                    obj3D_.uvts_.push(0.2, 0, 0, 0.8, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0, 0.8, 0);
                    obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 2), (_local4 + 3), (_local4 + 4)]));
                }
                else {
                    if (_args.length == 6) {
                        obj3D_.uvts_.push(0, 0, 0, 0.2, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0, 0.8, 0, 0, 0.2, 0);
                        obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 2), (_local4 + 3), (_local4 + 4), (_local4 + 5)]));
                    }
                    else {
                        if (_args.length == 8) {
                            obj3D_.uvts_.push(0, 0, 0, 0.2, 0, 0, 1, 0.2, 0, 1, 0.8, 0, 0.8, 1, 0, 0.2, 1, 0, 0, 0.8, 0, 0, 0.2, 0);
                            obj3D_.faces_.push(new ObjectFace3D(obj3D_, new <int>[_local4, (_local4 + 1), (_local4 + 2), (_local4 + 3), (_local4 + 4), (_local4 + 5), (_local4 + 6), (_local4 + 7)]));
                        }
                    }
                }
            }
        }
        if (((!((_arg1 == null))) || (!((_arg2 == null))))) {
            _local7 = _local6;
            while (_local7 < obj3D_.faces_.length) {
                obj3D_.faces_[_local7].normalL_ = _arg1;
                obj3D_.faces_[_local7].texture_ = _arg2;
                _local7++;
            }
        }
    }


}
}
