package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.GroundProperties;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.ImageSet;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

public class TileRedrawer {

    private static const rect0:Rectangle = new Rectangle(0, 0, 4, 4);
    private static const p0:Point = new Point(0, 0);
    private static const rect1:Rectangle = new Rectangle(4, 0, 4, 4);
    private static const p1:Point = new Point(4, 0);
    private static const rect2:Rectangle = new Rectangle(0, 4, 4, 4);
    private static const p2:Point = new Point(0, 4);
    private static const rect3:Rectangle = new Rectangle(4, 4, 4, 4);
    private static const p3:Point = new Point(4, 4);
    private static const INNER:int = 0;
    private static const SIDE0:int = 1;
    private static const SIDE1:int = 2;
    private static const OUTER:int = 3;
    private static const INNERP1:int = 4;
    private static const INNERP2:int = 5;
    private static const mlist_:Vector.<Vector.<ImageSet>> = getMasks();
    private static const RECT01:Rectangle = new Rectangle(0, 0, 8, 4);
    private static const RECT13:Rectangle = new Rectangle(4, 0, 4, 8);
    private static const RECT23:Rectangle = new Rectangle(0, 4, 8, 4);
    private static const RECT02:Rectangle = new Rectangle(0, 0, 4, 8);
    private static const RECT0:Rectangle = new Rectangle(0, 0, 4, 4);
    private static const RECT1:Rectangle = new Rectangle(4, 0, 4, 4);
    private static const RECT2:Rectangle = new Rectangle(0, 4, 4, 4);
    private static const RECT3:Rectangle = new Rectangle(4, 4, 4, 4);
    private static const POINT0:Point = new Point(0, 0);
    private static const POINT1:Point = new Point(4, 0);
    private static const POINT2:Point = new Point(0, 4);
    private static const POINT3:Point = new Point(4, 4);

    private static var cache_:Vector.<Object> = new <Object>[null, new Object()];


    public static function redraw(_arg1:Square, _arg2:Boolean):BitmapData {
        var _local3:*;
        var _local5:BitmapData;
        if (Parameters.blendType_ == 0) {
            return (null);
        }
        if (_arg1.tileType_ == 253) {
            _local3 = getCompositeSig(_arg1);
        }
        else {
            if (_arg1.props_.hasEdge_) {
                _local3 = getEdgeSig(_arg1);
            }
            else {
                _local3 = getSig(_arg1);
            }
        }
        if (_local3 == null) {
            return (null);
        }
        var _local4:Object = cache_[Parameters.blendType_];
        if (_local4.hasOwnProperty(_local3)) {
            return (_local4[_local3]);
        }
        if (_arg1.tileType_ == 253) {
            _local5 = buildComposite(_local3);
            _local4[_local3] = _local5;
            return (_local5);
        }
        if (_arg1.props_.hasEdge_) {
            _local5 = drawEdges(_local3);
            _local4[_local3] = _local5;
            return (_local5);
        }
        var _local6:Boolean;
        var _local7:Boolean;
        var _local8:Boolean;
        var _local9:Boolean;
        if (_local3[1] != _local3[4]) {
            _local6 = true;
            _local7 = true;
        }
        if (_local3[3] != _local3[4]) {
            _local6 = true;
            _local8 = true;
        }
        if (_local3[5] != _local3[4]) {
            _local7 = true;
            _local9 = true;
        }
        if (_local3[7] != _local3[4]) {
            _local8 = true;
            _local9 = true;
        }
        if (((!(_local6)) && (!((_local3[0] == _local3[4]))))) {
            _local6 = true;
        }
        if (((!(_local7)) && (!((_local3[2] == _local3[4]))))) {
            _local7 = true;
        }
        if (((!(_local8)) && (!((_local3[6] == _local3[4]))))) {
            _local8 = true;
        }
        if (((!(_local9)) && (!((_local3[8] == _local3[4]))))) {
            _local9 = true;
        }
        if (((((((!(_local6)) && (!(_local7)))) && (!(_local8)))) && (!(_local9)))) {
            _local4[_local3] = null;
            return (null);
        }
        var _local10:BitmapData = GroundLibrary.getBitmapData(_arg1.tileType_);
        if (_arg2) {
            _local5 = _local10.clone();
        }
        else {
            _local5 = new BitmapDataSpy(_local10.width, _local10.height, true, 0);
        }
        if (_local6) {
            redrawRect(_local5, rect0, p0, mlist_[0], _local3[4], _local3[3], _local3[0], _local3[1]);
        }
        if (_local7) {
            redrawRect(_local5, rect1, p1, mlist_[1], _local3[4], _local3[1], _local3[2], _local3[5]);
        }
        if (_local8) {
            redrawRect(_local5, rect2, p2, mlist_[2], _local3[4], _local3[7], _local3[6], _local3[3]);
        }
        if (_local9) {
            redrawRect(_local5, rect3, p3, mlist_[3], _local3[4], _local3[5], _local3[8], _local3[7]);
        }
        _local4[_local3] = _local5;
        return (_local5);
    }

    private static function redrawRect(_arg1:BitmapData, _arg2:Rectangle, _arg3:Point, _arg4:Vector.<ImageSet>, _arg5:uint, _arg6:uint, _arg7:uint, _arg8:uint):void {
        var _local9:BitmapData;
        var _local10:BitmapData;
        if ((((_arg5 == _arg6)) && ((_arg5 == _arg8)))) {
            _local10 = _arg4[OUTER].random();
            _local9 = GroundLibrary.getBitmapData(_arg7);
        }
        else {
            if (((!((_arg5 == _arg6))) && (!((_arg5 == _arg8))))) {
                if (_arg6 != _arg8) {
                    _arg1.copyPixels(GroundLibrary.getBitmapData(_arg6), _arg2, _arg3, _arg4[INNERP1].random(), p0, true);
                    _arg1.copyPixels(GroundLibrary.getBitmapData(_arg8), _arg2, _arg3, _arg4[INNERP2].random(), p0, true);
                    return;
                }
                _local10 = _arg4[INNER].random();
                _local9 = GroundLibrary.getBitmapData(_arg6);
            }
            else {
                if (_arg5 != _arg6) {
                    _local10 = _arg4[SIDE0].random();
                    _local9 = GroundLibrary.getBitmapData(_arg6);
                }
                else {
                    _local10 = _arg4[SIDE1].random();
                    _local9 = GroundLibrary.getBitmapData(_arg8);
                }
            }
        }
        _arg1.copyPixels(_local9, _arg2, _arg3, _local10, p0, true);
    }

    private static function getSig(_arg1:Square):Array {
        var _local6:int;
        var _local7:Square;
        var _local2:Array = new Array();
        var _local3:Map = _arg1.map_;
        var _local4:uint = _arg1.tileType_;
        var _local5:int = (_arg1.y_ - 1);
        while (_local5 <= (_arg1.y_ + 1)) {
            _local6 = (_arg1.x_ - 1);
            while (_local6 <= (_arg1.x_ + 1)) {
                if ((((((((((_local6 < 0)) || ((_local6 >= _local3.width_)))) || ((_local5 < 0)))) || ((_local5 >= _local3.height_)))) || ((((_local6 == _arg1.x_)) && ((_local5 == _arg1.y_)))))) {
                    _local2.push(_local4);
                }
                else {
                    _local7 = _local3.squares_[(_local6 + (_local5 * _local3.width_))];
                    if ((((_local7 == null)) || ((_local7.props_.blendPriority_ <= _arg1.props_.blendPriority_)))) {
                        _local2.push(_local4);
                    }
                    else {
                        _local2.push(_local7.tileType_);
                    }
                }
                _local6++;
            }
            _local5++;
        }
        return (_local2);
    }

    private static function getMasks():Vector.<Vector.<ImageSet>> {
        var _local1:Vector.<Vector.<ImageSet>> = new Vector.<Vector.<ImageSet>>();
        addMasks(_local1, AssetLibrary.getImageSet("inner_mask"), AssetLibrary.getImageSet("sides_mask"), AssetLibrary.getImageSet("outer_mask"), AssetLibrary.getImageSet("innerP1_mask"), AssetLibrary.getImageSet("innerP2_mask"));
        return (_local1);
    }

    private static function addMasks(_arg1:Vector.<Vector.<ImageSet>>, _arg2:ImageSet, _arg3:ImageSet, _arg4:ImageSet, _arg5:ImageSet, _arg6:ImageSet):void {
        var _local7:int;
        for each (_local7 in [-1, 0, 2, 1]) {
            _arg1.push(new <ImageSet>[rotateImageSet(_arg2, _local7), rotateImageSet(_arg3, (_local7 - 1)), rotateImageSet(_arg3, _local7), rotateImageSet(_arg4, _local7), rotateImageSet(_arg5, _local7), rotateImageSet(_arg6, _local7)]);
        }
    }

    private static function rotateImageSet(_arg1:ImageSet, _arg2:int):ImageSet {
        var _local4:BitmapData;
        var _local3:ImageSet = new ImageSet();
        for each (_local4 in _arg1.images_) {
            _local3.add(BitmapUtil.rotateBitmapData(_local4, _arg2));
        }
        return (_local3);
    }

    private static function getCompositeSig(_arg1:Square):Array {
        var _local14:Square;
        var _local15:Square;
        var _local16:Square;
        var _local17:Square;
        var _local2:Array = new Array();
        _local2.length = 4;
        var _local3:Map = _arg1.map_;
        var _local4:int = _arg1.x_;
        var _local5:int = _arg1.y_;
        var _local6:Square = _local3.lookupSquare(_local4, (_local5 - 1));
        var _local7:Square = _local3.lookupSquare((_local4 - 1), _local5);
        var _local8:Square = _local3.lookupSquare((_local4 + 1), _local5);
        var _local9:Square = _local3.lookupSquare(_local4, (_local5 + 1));
        var _local10:int = (((_local6) != null) ? _local6.props_.compositePriority_ : -1);
        var _local11:int = (((_local7) != null) ? _local7.props_.compositePriority_ : -1);
        var _local12:int = (((_local8) != null) ? _local8.props_.compositePriority_ : -1);
        var _local13:int = (((_local9) != null) ? _local9.props_.compositePriority_ : -1);
        if ((((_local10 < 0)) && ((_local11 < 0)))) {
            _local14 = _local3.lookupSquare((_local4 - 1), (_local5 - 1));
            _local2[0] = (((((_local14 == null)) || ((_local14.props_.compositePriority_ < 0)))) ? 0xFF : _local14.tileType_);
        }
        else {
            if (_local10 < _local11) {
                _local2[0] = _local7.tileType_;
            }
            else {
                _local2[0] = _local6.tileType_;
            }
        }
        if ((((_local10 < 0)) && ((_local12 < 0)))) {
            _local15 = _local3.lookupSquare((_local4 + 1), (_local5 - 1));
            _local2[1] = (((((_local15 == null)) || ((_local15.props_.compositePriority_ < 0)))) ? 0xFF : _local15.tileType_);
        }
        else {
            if (_local10 < _local12) {
                _local2[1] = _local8.tileType_;
            }
            else {
                _local2[1] = _local6.tileType_;
            }
        }
        if ((((_local11 < 0)) && ((_local13 < 0)))) {
            _local16 = _local3.lookupSquare((_local4 - 1), (_local5 + 1));
            _local2[2] = (((((_local16 == null)) || ((_local16.props_.compositePriority_ < 0)))) ? 0xFF : _local16.tileType_);
        }
        else {
            if (_local11 < _local13) {
                _local2[2] = _local9.tileType_;
            }
            else {
                _local2[2] = _local7.tileType_;
            }
        }
        if ((((_local12 < 0)) && ((_local13 < 0)))) {
            _local17 = _local3.lookupSquare((_local4 + 1), (_local5 + 1));
            _local2[3] = (((((_local17 == null)) || ((_local17.props_.compositePriority_ < 0)))) ? 0xFF : _local17.tileType_);
        }
        else {
            if (_local12 < _local13) {
                _local2[3] = _local9.tileType_;
            }
            else {
                _local2[3] = _local8.tileType_;
            }
        }
        return (_local2);
    }

    private static function buildComposite(_arg1:Array):BitmapData {
        var _local3:BitmapData;
        var _local2:BitmapData = new BitmapDataSpy(8, 8, false, 0);
        if (_arg1[0] != 0xFF) {
            _local3 = GroundLibrary.getBitmapData(_arg1[0]);
            _local2.copyPixels(_local3, RECT0, POINT0);
        }
        if (_arg1[1] != 0xFF) {
            _local3 = GroundLibrary.getBitmapData(_arg1[1]);
            _local2.copyPixels(_local3, RECT1, POINT1);
        }
        if (_arg1[2] != 0xFF) {
            _local3 = GroundLibrary.getBitmapData(_arg1[2]);
            _local2.copyPixels(_local3, RECT2, POINT2);
        }
        if (_arg1[3] != 0xFF) {
            _local3 = GroundLibrary.getBitmapData(_arg1[3]);
            _local2.copyPixels(_local3, RECT3, POINT3);
        }
        return (_local2);
    }

    private static function getEdgeSig(_arg1:Square):Array {
        var _local7:int;
        var _local8:Square;
        var _local9:Boolean;
        var _local2:Array = new Array();
        var _local3:Map = _arg1.map_;
        var _local4:Boolean;
        var _local5:Boolean = _arg1.props_.sameTypeEdgeMode_;
        var _local6:int = (_arg1.y_ - 1);
        while (_local6 <= (_arg1.y_ + 1)) {
            _local7 = (_arg1.x_ - 1);
            while (_local7 <= (_arg1.x_ + 1)) {
                _local8 = _local3.lookupSquare(_local7, _local6);
                if ((((_local7 == _arg1.x_)) && ((_local6 == _arg1.y_)))) {
                    _local2.push(_local8.tileType_);
                }
                else {
                    if (_local5) {
                        _local9 = (((_local8 == null)) || ((_local8.tileType_ == _arg1.tileType_)));
                    }
                    else {
                        _local9 = (((_local8 == null)) || (!((_local8.tileType_ == 0xFF))));
                    }
                    _local2.push(_local9);
                    _local4 = ((_local4) || (!(_local9)));
                }
                _local7++;
            }
            _local6++;
        }
        return (((_local4) ? _local2 : null));
    }

    private static function drawEdges(_arg1:Array):BitmapData {
        var _local2:BitmapData = GroundLibrary.getBitmapData(_arg1[4]);
        var _local3:BitmapData = _local2.clone();
        var _local4:GroundProperties = GroundLibrary.propsLibrary_[_arg1[4]];
        var _local5:Vector.<BitmapData> = _local4.getEdges();
        var _local6:Vector.<BitmapData> = _local4.getInnerCorners();
        var _local7:int = 1;
        while (_local7 < 8) {
            if (!_arg1[_local7]) {
                _local3.copyPixels(_local5[_local7], _local5[_local7].rect, PointUtil.ORIGIN, null, null, true);
            }
            _local7 = (_local7 + 2);
        }
        if (_local5[0] != null) {
            if (((((_arg1[3]) && (_arg1[1]))) && (!(_arg1[0])))) {
                _local3.copyPixels(_local5[0], _local5[0].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg1[1]) && (_arg1[5]))) && (!(_arg1[2])))) {
                _local3.copyPixels(_local5[2], _local5[2].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg1[5]) && (_arg1[7]))) && (!(_arg1[8])))) {
                _local3.copyPixels(_local5[8], _local5[8].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((((_arg1[3]) && (_arg1[7]))) && (!(_arg1[6])))) {
                _local3.copyPixels(_local5[6], _local5[6].rect, PointUtil.ORIGIN, null, null, true);
            }
        }
        if (_local6 != null) {
            if (((!(_arg1[3])) && (!(_arg1[1])))) {
                _local3.copyPixels(_local6[0], _local6[0].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg1[1])) && (!(_arg1[5])))) {
                _local3.copyPixels(_local6[2], _local6[2].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg1[5])) && (!(_arg1[7])))) {
                _local3.copyPixels(_local6[8], _local6[8].rect, PointUtil.ORIGIN, null, null, true);
            }
            if (((!(_arg1[3])) && (!(_arg1[7])))) {
                _local3.copyPixels(_local6[6], _local6[6].rect, PointUtil.ORIGIN, null, null, true);
            }
        }
        return (_local3);
    }


}
}
