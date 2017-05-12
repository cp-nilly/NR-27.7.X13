package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.display.Shader;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class TextureRedrawer {

    public static const magic:int = 12;
    public static const minSize:int = (2 * magic);//24
    private static const BORDER:int = 4;
    public static const OUTLINE_FILTER:GlowFilter = new GlowFilter(0, 0.8, 1.4, 1.4, 0xFF, BitmapFilterQuality.LOW, false, false);

    private static var cache_:Dictionary = new Dictionary();
    private static var faceCache_:Dictionary = new Dictionary();
    private static var redrawCaches:Dictionary = new Dictionary();
    public static var sharedTexture_:BitmapData = null;
    private static var textureShaderEmbed_:Class = TextureRedrawer_textureShaderEmbed_;
    private static var textureShaderData_:ByteArray = (new textureShaderEmbed_() as ByteArray);
    private static var colorTexture1:BitmapData = new BitmapDataSpy(1, 1, false);
    private static var colorTexture2:BitmapData = new BitmapDataSpy(1, 1, false);


    public static function redraw(_arg1:BitmapData, _arg2:int, _arg3:Boolean, _arg4:uint, _arg5:Boolean = true, _arg6:Number = 5):BitmapData {
        var _local7:String = getHash(_arg2, _arg3, _arg4, _arg6);
        if (((_arg5) && (isCached(_arg1, _local7)))) {
            return (redrawCaches[_arg1][_local7]);
        }
        var _local8:BitmapData = resize(_arg1, null, _arg2, _arg3, 0, 0, _arg6);
        _local8 = GlowRedrawer.outlineGlow(_local8, _arg4, 1.4, _arg5);
        if (_arg5) {
            cache(_arg1, _local7, _local8);
        }
        return (_local8);
    }

    private static function getHash(_arg1:int, _arg2:Boolean, _arg3:uint, _arg4:Number):String {
        return (((((((_arg1.toString() + ",") + _arg3.toString()) + ",") + _arg2) + ",") + _arg4));
    }

    private static function cache(_arg1:BitmapData, _arg2:String, _arg3:BitmapData):void {
        if (!(_arg1 in redrawCaches)) {
            redrawCaches[_arg1] = {};
        }
        redrawCaches[_arg1][_arg2] = _arg3;
    }

    private static function isCached(_arg1:BitmapData, _arg2:String):Boolean {
        if ((_arg1 in redrawCaches)) {
            if ((_arg2 in redrawCaches[_arg1])) {
                return (true);
            }
        }
        return (false);
    }

    public static function resize(_arg1:BitmapData, _arg2:BitmapData, _arg3:int, _arg4:Boolean, _arg5:int, _arg6:int, _arg7:Number = 5):BitmapData {
        if (((!((_arg2 == null))) && (((!((_arg5 == 0))) || (!((_arg6 == 0))))))) {
            _arg1 = retexture(_arg1, _arg2, _arg5, _arg6);
            _arg3 = (_arg3 / 5);
        }
        var _local8:int = ((_arg7 * (_arg3 / 100)) * _arg1.width);
        var _local9:int = ((_arg7 * (_arg3 / 100)) * _arg1.height);
        var _local10:Matrix = new Matrix();
        _local10.scale((_local8 / _arg1.width), (_local9 / _arg1.height));
        _local10.translate(magic, magic);
        var _local11:BitmapData = new BitmapDataSpy((_local8 + minSize), ((_local9 + ((_arg4) ? magic : 1)) + magic), true, 0);
        _local11.draw(_arg1, _local10);
        return (_local11);
    }

    public static function redrawSolidSquare(_arg1:uint, _arg2:int):BitmapData {
        var _local3:Dictionary = cache_[_arg2];
        if (_local3 == null) {
            _local3 = new Dictionary();
            cache_[_arg2] = _local3;
        }
        var _local4:BitmapData = _local3[_arg1];
        if (_local4 != null) {
            return (_local4);
        }
        _local4 = new BitmapDataSpy(((_arg2 + 4) + 4), ((_arg2 + 4) + 4), true, 0);
        _local4.fillRect(new Rectangle(4, 4, _arg2, _arg2), (0xFF000000 | _arg1));
        _local4.applyFilter(_local4, _local4.rect, PointUtil.ORIGIN, OUTLINE_FILTER);
        _local3[_arg1] = _local4;
        return (_local4);
    }

    public static function clearCache():void {
        var _local1:BitmapData;
        var _local2:Dictionary;
        var _local3:Dictionary;
        for each (_local2 in cache_) {
            for each (_local1 in _local2) {
                _local1.dispose();
            }
        }
        cache_ = new Dictionary();
        for each (_local3 in faceCache_) {
            for each (_local1 in _local3) {
                _local1.dispose();
            }
        }
        faceCache_ = new Dictionary();
    }

    public static function redrawFace(_arg1:BitmapData, _arg2:Number):BitmapData {
        if (_arg2 == 1) {
            return (_arg1);
        }
        var _local3:Dictionary = faceCache_[_arg2];
        if (_local3 == null) {
            _local3 = new Dictionary();
            faceCache_[_arg2] = _local3;
        }
        var _local4:BitmapData = _local3[_arg1];
        if (_local4 != null) {
            return (_local4);
        }
        _local4 = _arg1.clone();
        _local4.colorTransform(_local4.rect, new ColorTransform(_arg2, _arg2, _arg2));
        _local3[_arg1] = _local4;
        return (_local4);
    }

    private static function getTexture(_arg1:int, _arg2:BitmapData):BitmapData {
        var _local3:BitmapData;
        var _local4 = ((_arg1 >> 24) & 0xFF);
        var _local5 = (_arg1 & 0xFFFFFF);
        switch (_local4) {
            case 0:
                _local3 = _arg2;
                break;
            case 1:
                _arg2.setPixel(0, 0, _local5);
                _local3 = _arg2;
                break;
            case 4:
                _local3 = AssetLibrary.getImageFromSet("textile4x4", _local5);
                break;
            case 5:
                _local3 = AssetLibrary.getImageFromSet("textile5x5", _local5);
                break;
            case 9:
                _local3 = AssetLibrary.getImageFromSet("textile9x9", _local5);
                break;
            case 10:
                _local3 = AssetLibrary.getImageFromSet("textile10x10", _local5);
                break;
            case 0xFF:
                _local3 = sharedTexture_;
                break;
            default:
                _local3 = _arg2;
        }
        return (_local3);
    }

    private static function retexture(_arg1:BitmapData, _arg2:BitmapData, _arg3:int, _arg4:int):BitmapData {
        var _local5:Matrix = new Matrix();
        _local5.scale(5, 5);
        var _local6:BitmapData = new BitmapDataSpy((_arg1.width * 5), (_arg1.height * 5), true, 0);
        _local6.draw(_arg1, _local5);
        var _local7:BitmapData = getTexture(_arg3, colorTexture1);
        var _local8:BitmapData = getTexture(_arg4, colorTexture2);
        var _local9:Shader = new Shader(textureShaderData_);
        _local9.data.src.input = _local6;
        _local9.data.mask.input = _arg2;
        _local9.data.texture1.input = _local7;
        _local9.data.texture2.input = _local8;
        _local9.data.texture1Size.value = [(((_arg3 == 0)) ? 0 : _local7.width)];
        _local9.data.texture2Size.value = [(((_arg4 == 0)) ? 0 : _local8.width)];
        _local6.applyFilter(_local6, _local6.rect, PointUtil.ORIGIN, new ShaderFilter(_local9));
        return (_local6);
    }

    private static function getDrawMatrix():Matrix {
        var _local1:Matrix = new Matrix();
        _local1.scale(8, 8);
        _local1.translate(BORDER, BORDER);
        return (_local1);
    }


}
}
