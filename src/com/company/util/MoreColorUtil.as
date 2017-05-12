package com.company.util {
import flash.geom.ColorTransform;

public class MoreColorUtil {

    public static const greyscaleFilterMatrix:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
    public static const redFilterMatrix:Array = [0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
    public static const identity:ColorTransform = new ColorTransform();
    public static const invisible:ColorTransform = new ColorTransform(1, 1, 1, 0, 0, 0, 0, 0);
    public static const transparentCT:ColorTransform = new ColorTransform(1, 1, 1, 0.3, 0, 0, 0, 0);
    public static const slightlyTransparentCT:ColorTransform = new ColorTransform(1, 1, 1, 0.7, 0, 0, 0, 0);
    public static const greenCT:ColorTransform = new ColorTransform(0.6, 1, 0.6, 1, 0, 0, 0, 0);
    public static const lightGreenCT:ColorTransform = new ColorTransform(0.8, 1, 0.8, 1, 0, 0, 0, 0);
    public static const veryGreenCT:ColorTransform = new ColorTransform(0.2, 1, 0.2, 1, 0, 100, 0, 0);
    public static const transparentGreenCT:ColorTransform = new ColorTransform(0.5, 1, 0.5, 0.3, 0, 0, 0, 0);
    public static const transparentVeryGreenCT:ColorTransform = new ColorTransform(0.3, 1, 0.3, 0.5, 0, 0, 0, 0);
    public static const redCT:ColorTransform = new ColorTransform(1, 0.5, 0.5, 1, 0, 0, 0, 0);
    public static const lightRedCT:ColorTransform = new ColorTransform(1, 0.7, 0.7, 1, 0, 0, 0, 0);
    public static const veryRedCT:ColorTransform = new ColorTransform(1, 0.2, 0.2, 1, 100, 0, 0, 0);
    public static const transparentRedCT:ColorTransform = new ColorTransform(1, 0.5, 0.5, 0.3, 0, 0, 0, 0);
    public static const transparentVeryRedCT:ColorTransform = new ColorTransform(1, 0.3, 0.3, 0.5, 0, 0, 0, 0);
    public static const blueCT:ColorTransform = new ColorTransform(0.5, 0.5, 1, 1, 0, 0, 0, 0);
    public static const lightBlueCT:ColorTransform = new ColorTransform(0.7, 0.7, 1, 1, 0, 0, 100, 0);
    public static const veryBlueCT:ColorTransform = new ColorTransform(0.3, 0.3, 1, 1, 0, 0, 100, 0);
    public static const transparentBlueCT:ColorTransform = new ColorTransform(0.5, 0.5, 1, 0.3, 0, 0, 0, 0);
    public static const transparentVeryBlueCT:ColorTransform = new ColorTransform(0.3, 0.3, 1, 0.5, 0, 0, 0, 0);
    public static const purpleCT:ColorTransform = new ColorTransform(1, 0.5, 1, 1, 0, 0, 0, 0);
    public static const veryPurpleCT:ColorTransform = new ColorTransform(1, 0.2, 1, 1, 100, 0, 100, 0);
    public static const darkCT:ColorTransform = new ColorTransform(0.6, 0.6, 0.6, 1, 0, 0, 0, 0);
    public static const veryDarkCT:ColorTransform = new ColorTransform(0.4, 0.4, 0.4, 1, 0, 0, 0, 0);
    public static const makeWhiteCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);

    public function MoreColorUtil(_arg1:StaticEnforcer) {
    }

    public static function hsvToRgb(_arg1:Number, _arg2:Number, _arg3:Number):int {
        var _local9:Number;
        var _local10:Number;
        var _local11:Number;
        var _local4:int = (int((_arg1 / 60)) % 6);
        var _local5:Number = ((_arg1 / 60) - Math.floor((_arg1 / 60)));
        var _local6:Number = (_arg3 * (1 - _arg2));
        var _local7:Number = (_arg3 * (1 - (_local5 * _arg2)));
        var _local8:Number = (_arg3 * (1 - ((1 - _local5) * _arg2)));
        switch (_local4) {
            case 0:
                _local9 = _arg3;
                _local10 = _local8;
                _local11 = _local6;
                break;
            case 1:
                _local9 = _local7;
                _local10 = _arg3;
                _local11 = _local6;
                break;
            case 2:
                _local9 = _local6;
                _local10 = _arg3;
                _local11 = _local8;
                break;
            case 3:
                _local9 = _local6;
                _local10 = _local7;
                _local11 = _arg3;
                break;
            case 4:
                _local9 = _local8;
                _local10 = _local6;
                _local11 = _arg3;
                break;
            case 5:
                _local9 = _arg3;
                _local10 = _local6;
                _local11 = _local7;
                break;
        }
        return ((((int(Math.min(0xFF, Math.floor((_local9 * 0xFF)))) << 16) | (int(Math.min(0xFF, Math.floor((_local10 * 0xFF)))) << 8)) | int(Math.min(0xFF, Math.floor((_local11 * 0xFF))))));
    }

    public static function randomColor():uint {
        return (uint((0xFFFFFF * Math.random())));
    }

    public static function randomColor32():uint {
        return ((uint((0xFFFFFF * Math.random())) | 0xFF000000));
    }

    public static function transformColor(_arg1:ColorTransform, _arg2:uint):uint {
        var _local3:int = ((((_arg2 & 0xFF0000) >> 16) * _arg1.redMultiplier) + _arg1.redOffset);
        _local3 = (((_local3 < 0)) ? 0 : (((_local3 > 0xFF)) ? 0xFF : _local3));
        var _local4:int = ((((_arg2 & 0xFF00) >> 8) * _arg1.greenMultiplier) + _arg1.greenOffset);
        _local4 = (((_local4 < 0)) ? 0 : (((_local4 > 0xFF)) ? 0xFF : _local4));
        var _local5:int = (((_arg2 & 0xFF) * _arg1.blueMultiplier) + _arg1.blueOffset);
        _local5 = (((_local5 < 0)) ? 0 : (((_local5 > 0xFF)) ? 0xFF : _local5));
        return ((((_local3 << 16) | (_local4 << 8)) | _local5));
    }

    public static function copyColorTransform(_arg1:ColorTransform):ColorTransform {
        return (new ColorTransform(_arg1.redMultiplier, _arg1.greenMultiplier, _arg1.blueMultiplier, _arg1.alphaMultiplier, _arg1.redOffset, _arg1.greenOffset, _arg1.blueOffset, _arg1.alphaOffset));
    }

    public static function lerpColorTransform(_arg1:ColorTransform, _arg2:ColorTransform, _arg3:Number):ColorTransform {
        if (_arg1 == null) {
            _arg1 = identity;
        }
        if (_arg2 == null) {
            _arg2 = identity;
        }
        var _local4:Number = (1 - _arg3);
        var _local5:ColorTransform = new ColorTransform(((_arg1.redMultiplier * _local4) + (_arg2.redMultiplier * _arg3)), ((_arg1.greenMultiplier * _local4) + (_arg2.greenMultiplier * _arg3)), ((_arg1.blueMultiplier * _local4) + (_arg2.blueMultiplier * _arg3)), ((_arg1.alphaMultiplier * _local4) + (_arg2.alphaMultiplier * _arg3)), ((_arg1.redOffset * _local4) + (_arg2.redOffset * _arg3)), ((_arg1.greenOffset * _local4) + (_arg2.greenOffset * _arg3)), ((_arg1.blueOffset * _local4) + (_arg2.blueOffset * _arg3)), ((_arg1.alphaOffset * _local4) + (_arg2.alphaOffset * _arg3)));
        return (_local5);
    }

    public static function lerpColor(_arg1:uint, _arg2:uint, _arg3:Number):uint {
        var _local4:Number = (1 - _arg3);
        var _local5:uint = ((_arg1 >> 24) & 0xFF);
        var _local6:uint = ((_arg1 >> 16) & 0xFF);
        var _local7:uint = ((_arg1 >> 8) & 0xFF);
        var _local8:uint = (_arg1 & 0xFF);
        var _local9:uint = ((_arg2 >> 24) & 0xFF);
        var _local10:uint = ((_arg2 >> 16) & 0xFF);
        var _local11:uint = ((_arg2 >> 8) & 0xFF);
        var _local12:uint = (_arg2 & 0xFF);
        var _local13:uint = ((_local5 * _local4) + (_local9 * _arg3));
        var _local14:uint = ((_local6 * _local4) + (_local10 * _arg3));
        var _local15:uint = ((_local7 * _local4) + (_local11 * _arg3));
        var _local16:uint = ((_local8 * _local4) + (_local12 * _arg3));
        var _local17:uint = ((((_local13 << 24) | (_local14 << 16)) | (_local15 << 8)) | _local16);
        return (_local17);
    }

    public static function transformAlpha(_arg1:ColorTransform, _arg2:Number):Number {
        var _local3:uint = (_arg2 * 0xFF);
        var _local4:uint = ((_local3 * _arg1.alphaMultiplier) + _arg1.alphaOffset);
        _local4 = (((_local4 < 0)) ? 0 : (((_local4 > 0xFF)) ? 0xFF : _local4));
        return ((_local4 / 0xFF));
    }

    public static function multiplyColor(_arg1:uint, _arg2:Number):uint {
        var _local3:int = (((_arg1 & 0xFF0000) >> 16) * _arg2);
        _local3 = (((_local3 < 0)) ? 0 : (((_local3 > 0xFF)) ? 0xFF : _local3));
        var _local4:int = (((_arg1 & 0xFF00) >> 8) * _arg2);
        _local4 = (((_local4 < 0)) ? 0 : (((_local4 > 0xFF)) ? 0xFF : _local4));
        var _local5:int = ((_arg1 & 0xFF) * _arg2);
        _local5 = (((_local5 < 0)) ? 0 : (((_local5 > 0xFF)) ? 0xFF : _local5));
        return ((((_local3 << 16) | (_local4 << 8)) | _local5));
    }

    public static function adjustBrightness(_arg1:uint, _arg2:Number):uint {
        var _local3:uint = (_arg1 & 0xFF000000);
        var _local4:int = (((_arg1 & 0xFF0000) >> 16) + (_arg2 * 0xFF));
        _local4 = (((_local4 < 0)) ? 0 : (((_local4 > 0xFF)) ? 0xFF : _local4));
        var _local5:int = (((_arg1 & 0xFF00) >> 8) + (_arg2 * 0xFF));
        _local5 = (((_local5 < 0)) ? 0 : (((_local5 > 0xFF)) ? 0xFF : _local5));
        var _local6:int = ((_arg1 & 0xFF) + (_arg2 * 0xFF));
        _local6 = (((_local6 < 0)) ? 0 : (((_local6 > 0xFF)) ? 0xFF : _local6));
        return ((((_local3 | (_local4 << 16)) | (_local5 << 8)) | _local6));
    }

    public static function colorToShaderParameter(_arg1:uint):Array {
        var _local2:Number = (((_arg1 >> 24) & 0xFF) / 0x0100);
        return ([(_local2 * (((_arg1 >> 16) & 0xFF) / 0x0100)), (_local2 * (((_arg1 >> 8) & 0xFF) / 0x0100)), (_local2 * ((_arg1 & 0xFF) / 0x0100)), _local2]);
    }

    public static function rgbToGreyscale(_arg1:uint):uint {
        var _local2:uint = (((((_arg1 & 0xFF0000) >> 16) * 0.3) + (((_arg1 & 0xFF00) >> 8) * 0.59)) + ((_arg1 & 0xFF) * 0.11));
        return ((((((_arg1) && (0xFF000000)) | (_local2 << 16)) | (_local2 << 8)) | _local2));
    }

    public static function singleColorFilterMatrix(_arg1:uint):Array {
        return ([0, 0, 0, 0, ((_arg1 & 0xFF0000) >> 16), 0, 0, 0, 0, ((_arg1 & 0xFF00) >> 8), 0, 0, 0, 0, (_arg1 & 0xFF), 0, 0, 0, 1, 0]);
    }


}
}
class StaticEnforcer {


}

