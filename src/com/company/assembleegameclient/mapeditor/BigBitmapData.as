package com.company.assembleegameclient.mapeditor {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

public class BigBitmapData {

    private static const CHUNK_SIZE:int = 0x0100;

    public var width_:int;
    public var height_:int;
    public var fillColor_:uint;
    private var maxChunkX_:int;
    private var maxChunkY_:int;
    private var chunks_:Vector.<BitmapData>;

    public function BigBitmapData(_arg1:int, _arg2:int, _arg3:Boolean, _arg4:uint) {
        var _local6:int;
        var _local7:int;
        var _local8:int;
        super();
        this.width_ = _arg1;
        this.height_ = _arg2;
        this.fillColor_ = _arg4;
        this.maxChunkX_ = Math.ceil((this.width_ / CHUNK_SIZE));
        this.maxChunkY_ = Math.ceil((this.height_ / CHUNK_SIZE));
        this.chunks_ = new Vector.<BitmapData>((this.maxChunkX_ * this.maxChunkY_), true);
        var _local5:int;
        while (_local5 < this.maxChunkX_) {
            _local6 = 0;
            while (_local6 < this.maxChunkY_) {
                _local7 = Math.min(CHUNK_SIZE, (this.width_ - (_local5 * CHUNK_SIZE)));
                _local8 = Math.min(CHUNK_SIZE, (this.height_ - (_local6 * CHUNK_SIZE)));
                this.chunks_[(_local5 + (_local6 * this.maxChunkX_))] = new BitmapDataSpy(_local7, _local8, _arg3, this.fillColor_);
                _local6++;
            }
            _local5++;
        }
    }

    public function copyTo(_arg1:BitmapData, _arg2:Rectangle, _arg3:Rectangle):void {
        var _local12:int;
        var _local13:BitmapData;
        var _local14:Rectangle;
        var _local4:Number = (_arg3.width / _arg2.width);
        var _local5:Number = (_arg3.height / _arg2.height);
        var _local6:int = int((_arg3.x / CHUNK_SIZE));
        var _local7:int = int((_arg3.y / CHUNK_SIZE));
        var _local8:int = Math.ceil((_arg3.right / CHUNK_SIZE));
        var _local9:int = Math.ceil((_arg3.bottom / CHUNK_SIZE));
        var _local10:Matrix = new Matrix();
        var _local11:int = _local6;
        while (_local11 < _local8) {
            _local12 = _local7;
            while (_local12 < _local9) {
                _local13 = this.chunks_[(_local11 + (_local12 * this.maxChunkX_))];
                _local10.identity();
                _local10.scale(_local4, _local5);
                _local10.translate(((_arg3.x - (_local11 * CHUNK_SIZE)) - (_arg2.x * _local4)), ((_arg3.y - (_local12 * CHUNK_SIZE)) - (_arg2.x * _local5)));
                _local14 = new Rectangle((_arg3.x - (_local11 * CHUNK_SIZE)), (_arg3.y - (_local12 * CHUNK_SIZE)), _arg3.width, _arg3.height);
                _local13.draw(_arg1, _local10, null, null, _local14, false);
                _local12++;
            }
            _local11++;
        }
    }

    public function copyFrom(_arg1:Rectangle, _arg2:BitmapData, _arg3:Rectangle):void {
        var _local13:int;
        var _local14:BitmapData;
        var _local4:Number = (_arg3.width / _arg1.width);
        var _local5:Number = (_arg3.height / _arg1.height);
        var _local6:int = Math.max(0, int((_arg1.x / CHUNK_SIZE)));
        var _local7:int = Math.max(0, int((_arg1.y / CHUNK_SIZE)));
        var _local8:int = Math.min((this.maxChunkX_ - 1), int((_arg1.right / CHUNK_SIZE)));
        var _local9:int = Math.min((this.maxChunkY_ - 1), int((_arg1.bottom / CHUNK_SIZE)));
        var _local10:Rectangle = new Rectangle();
        var _local11:Matrix = new Matrix();
        var _local12:int = _local6;
        while (_local12 <= _local8) {
            _local13 = _local7;
            while (_local13 <= _local9) {
                _local14 = this.chunks_[(_local12 + (_local13 * this.maxChunkX_))];
                _local11.identity();
                _local11.translate((((_arg3.x / _local4) - _arg1.x) + (_local12 * CHUNK_SIZE)), (((_arg3.y / _local5) - _arg1.y) + (_local13 * CHUNK_SIZE)));
                _local11.scale(_local4, _local5);
                _arg2.draw(_local14, _local11, null, null, _arg3, false);
                _local13++;
            }
            _local12++;
        }
    }

    public function erase(_arg1:Rectangle):void {
        var _local8:int;
        var _local9:BitmapData;
        var _local2:int = int((_arg1.x / CHUNK_SIZE));
        var _local3:int = int((_arg1.y / CHUNK_SIZE));
        var _local4:int = Math.ceil((_arg1.right / CHUNK_SIZE));
        var _local5:int = Math.ceil((_arg1.bottom / CHUNK_SIZE));
        var _local6:Rectangle = new Rectangle();
        var _local7:int = _local2;
        while (_local7 < _local4) {
            _local8 = _local3;
            while (_local8 < _local5) {
                _local9 = this.chunks_[(_local7 + (_local8 * this.maxChunkX_))];
                _local6.x = (_arg1.x - (_local7 * CHUNK_SIZE));
                _local6.y = (_arg1.y - (_local8 * CHUNK_SIZE));
                _local6.right = (_arg1.right - (_local7 * CHUNK_SIZE));
                _local6.bottom = (_arg1.bottom - (_local8 * CHUNK_SIZE));
                _local9.fillRect(_local6, this.fillColor_);
                _local8++;
            }
            _local7++;
        }
    }

    public function getDebugSprite():Sprite {
        var _local3:int;
        var _local4:BitmapData;
        var _local5:Bitmap;
        var _local1:Sprite = new Sprite();
        var _local2:int;
        while (_local2 < this.maxChunkX_) {
            _local3 = 0;
            while (_local3 < this.maxChunkY_) {
                _local4 = this.chunks_[(_local2 + (_local3 * this.maxChunkX_))];
                _local5 = new Bitmap(_local4);
                _local5.x = (_local2 * CHUNK_SIZE);
                _local5.y = (_local3 * CHUNK_SIZE);
                _local1.addChild(_local5);
                _local3++;
            }
            _local2++;
        }
        return (_local1);
    }


}
}
