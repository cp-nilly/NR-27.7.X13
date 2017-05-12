package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.Camera;
import com.company.util.Trig;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class AnimatedChar {

    public static const RIGHT:int = 0;
    public static const LEFT:int = 1;
    public static const DOWN:int = 2;
    public static const UP:int = 3;
    public static const NUM_DIR:int = 4;
    public static const STAND:int = 0;
    public static const WALK:int = 1;
    public static const ATTACK:int = 2;
    public static const NUM_ACTION:int = 3;
    private static const SEC_TO_DIRS:Vector.<Vector.<int>> = new <Vector.<int>>[new <int>[LEFT, UP, DOWN], new <int>[UP, LEFT, DOWN], new <int>[UP, RIGHT, DOWN], new <int>[RIGHT, UP, DOWN], new <int>[RIGHT, DOWN], new <int>[DOWN, RIGHT], new <int>[DOWN, LEFT], new <int>[LEFT, DOWN]];
    private static const PIOVER4:Number = (Math.PI / 4);//0.785398163397448

    public var origImage_:MaskedImage;
    private var width_:int;
    private var height_:int;
    private var firstDir_:int;
    private var dict_:Dictionary;

    public function AnimatedChar(_arg1:MaskedImage, _arg2:int, _arg3:int, _arg4:int) {
        this.dict_ = new Dictionary();
        super();
        this.origImage_ = _arg1;
        this.width_ = _arg2;
        this.height_ = _arg3;
        this.firstDir_ = _arg4;
        var _local5:Dictionary = new Dictionary();
        var _local6:MaskedImageSet = new MaskedImageSet();
        _local6.addFromMaskedImage(_arg1, _arg2, _arg3);
        if (_arg4 == RIGHT) {
            this.dict_[RIGHT] = this.loadDir(0, false, false, _local6);
            this.dict_[LEFT] = this.loadDir(0, true, false, _local6);
            if (_local6.images_.length >= 14) {
                this.dict_[DOWN] = this.loadDir(7, false, true, _local6);
                if (_local6.images_.length >= 21) {
                    this.dict_[UP] = this.loadDir(14, false, true, _local6);
                }
            }
        }
        else {
            if (_arg4 == DOWN) {
                this.dict_[DOWN] = this.loadDir(0, false, true, _local6);
                if (_local6.images_.length >= 14) {
                    this.dict_[RIGHT] = this.loadDir(7, false, false, _local6);
                    this.dict_[LEFT] = this.loadDir(7, true, false, _local6);
                    if (_local6.images_.length >= 21) {
                        this.dict_[UP] = this.loadDir(14, false, true, _local6);
                    }
                }
                return;
            }
        }
    }

    public function getFirstDirImage():BitmapData {
        var _local1:BitmapData = new BitmapDataSpy((this.width_ * 7), this.height_, true, 0);
        var _local2:Dictionary = this.dict_[this.firstDir_];
        var _local3:Vector.<MaskedImage> = _local2[STAND];
        if (_local3.length > 0) {
            _local1.copyPixels(_local3[0].image_, _local3[0].image_.rect, new Point(0, 0));
        }
        _local3 = _local2[WALK];
        if (_local3.length > 0) {
            _local1.copyPixels(_local3[0].image_, _local3[0].image_.rect, new Point(this.width_, 0));
        }
        if (_local3.length > 1) {
            _local1.copyPixels(_local3[1].image_, _local3[1].image_.rect, new Point((this.width_ * 2), 0));
        }
        _local3 = _local2[ATTACK];
        if (_local3.length > 0) {
            _local1.copyPixels(_local3[0].image_, _local3[0].image_.rect, new Point((this.width_ * 4), 0));
        }
        if (_local3.length > 1) {
            _local1.copyPixels(_local3[1].image_, new Rectangle(this.width_, 0, (this.width_ * 2), this.height_), new Point((this.width_ * 5), 0));
        }
        return (_local1);
    }

    public function imageVec(_arg1:int, _arg2:int):Vector.<MaskedImage> {
        return (this.dict_[_arg1][_arg2]);
    }

    public function imageFromDir(_arg1:int, _arg2:int, _arg3:Number):MaskedImage {
        var _local4:Vector.<MaskedImage> = this.dict_[_arg1][_arg2];
        _arg3 = Math.max(0, Math.min(0.99999, _arg3));
        var _local5:int = (_arg3 * _local4.length);
        return (_local4[_local5]);
    }

    public function imageFromAngle(_arg1:Number, _arg2:int, _arg3:Number):MaskedImage {
        var _local4:int = (int(((_arg1 / PIOVER4) + 4)) % 8);
        var _local5:Vector.<int> = SEC_TO_DIRS[_local4];
        var _local6:Dictionary = this.dict_[_local5[0]];
        if (_local6 == null) {
            _local6 = this.dict_[_local5[1]];
            if (_local6 == null) {
                _local6 = this.dict_[_local5[2]];
            }
        }
        var _local7:Vector.<MaskedImage> = _local6[_arg2];
        _arg3 = Math.max(0, Math.min(0.99999, _arg3));
        var _local8:int = (_arg3 * _local7.length);
        return (_local7[_local8]);
    }

    public function imageFromFacing(_arg1:Number, _arg2:Camera, _arg3:int, _arg4:Number):MaskedImage {
        var _local5:Number = Trig.boundToPI((_arg1 - _arg2.angleRad_));
        var _local6:int = (int(((_local5 / PIOVER4) + 4)) % 8);
        var _local7:Vector.<int> = SEC_TO_DIRS[_local6];
        var _local8:Dictionary = this.dict_[_local7[0]];
        if (_local8 == null) {
            _local8 = this.dict_[_local7[1]];
            if (_local8 == null) {
                _local8 = this.dict_[_local7[2]];
            }
        }
        var _local9:Vector.<MaskedImage> = _local8[_arg3];
        _arg4 = Math.max(0, Math.min(0.99999, _arg4));
        var _local10:int = (_arg4 * _local9.length);
        return (_local9[_local10]);
    }

    private function loadDir(_arg1:int, _arg2:Boolean, _arg3:Boolean, _arg4:MaskedImageSet):Dictionary {
        var _local14:Vector.<MaskedImage>;
        var _local15:BitmapData;
        var _local16:BitmapData;
        var _local5:Dictionary = new Dictionary();
        var _local6:MaskedImage = _arg4.images_[(_arg1 + 0)];
        var _local7:MaskedImage = _arg4.images_[(_arg1 + 1)];
        var _local8:MaskedImage = _arg4.images_[(_arg1 + 2)];
        if (_local8.amountTransparent() == 1) {
            _local8 = null;
        }
        var _local9:MaskedImage = _arg4.images_[(_arg1 + 4)];
        var _local10:MaskedImage = _arg4.images_[(_arg1 + 5)];
        if (_local9.amountTransparent() == 1) {
            _local9 = null;
        }
        if (_local10.amountTransparent() == 1) {
            _local10 = null;
        }
        var _local11:MaskedImage = _arg4.images_[(_arg1 + 6)];
        if (((!((_local10 == null))) && (!((_local11.amountTransparent() == 1))))) {
            _local15 = new BitmapDataSpy((this.width_ * 3), this.height_, true, 0);
            _local15.copyPixels(_local10.image_, new Rectangle(0, 0, this.width_, this.height_), new Point(this.width_, 0));
            _local15.copyPixels(_local11.image_, new Rectangle(0, 0, this.width_, this.height_), new Point((this.width_ * 2), 0));
            _local16 = null;
            if (((!((_local10.mask_ == null))) || (!((_local11.mask_ == null))))) {
                _local16 = new BitmapDataSpy((this.width_ * 3), this.height_, true, 0);
            }
            if (_local10.mask_ != null) {
                _local16.copyPixels(_local10.mask_, new Rectangle(0, 0, this.width_, this.height_), new Point(this.width_, 0));
            }
            if (_local11.mask_ != null) {
                _local16.copyPixels(_local11.mask_, new Rectangle(0, 0, this.width_, this.height_), new Point((this.width_ * 2), 0));
            }
            _local10 = new MaskedImage(_local15, _local16);
        }
        var _local12:Vector.<MaskedImage> = new Vector.<MaskedImage>();
        _local12.push(((_arg2) ? _local6.mirror() : _local6));
        _local5[STAND] = _local12;
        var _local13:Vector.<MaskedImage> = new Vector.<MaskedImage>();
        _local13.push(((_arg2) ? _local7.mirror() : _local7));
        if (_local8 != null) {
            _local13.push(((_arg2) ? _local8.mirror() : _local8));
        }
        else {
            if (_arg3) {
                _local13.push(((_arg2) ? _local7 : _local7.mirror(7)));
            }
            else {
                _local13.push(((_arg2) ? _local6.mirror() : _local6));
            }
        }
        _local5[WALK] = _local13;
        if ((((_local9 == null)) && ((_local10 == null)))) {
            _local14 = _local13;
        }
        else {
            _local14 = new Vector.<MaskedImage>();
            if (_local9 != null) {
                _local14.push(((_arg2) ? _local9.mirror() : _local9));
            }
            if (_local10 != null) {
                _local14.push(((_arg2) ? _local10.mirror() : _local10));
            }
        }
        _local5[ATTACK] = _local14;
        return (_local5);
    }

    public function getHeight():int {
        return (this.height_);
    }


}
}
