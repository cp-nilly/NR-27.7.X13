package com.company.util {
import flash.display.CapsStyle;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.geom.Matrix;

public class GraphicsUtil {

    public static const END_FILL:GraphicsEndFill = new GraphicsEndFill();
    public static const QUAD_COMMANDS:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO];
    public static const DEBUG_STROKE:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFF0000));
    public static const END_STROKE:GraphicsStroke = new GraphicsStroke();
    private static const TWO_PI:Number = (2 * Math.PI);//6.28318530717959
    public static const ALL_CUTS:Array = [true, true, true, true];


    public static function clearPath(_arg1:GraphicsPath):void {
        _arg1.commands.length = 0;
        _arg1.data.length = 0;
    }

    public static function getRectPath(_arg1:int, _arg2:int, _arg3:int, _arg4:int):GraphicsPath {
        return (new GraphicsPath(QUAD_COMMANDS, new <Number>[_arg1, _arg2, (_arg1 + _arg3), _arg2, (_arg1 + _arg3), (_arg2 + _arg4), _arg1, (_arg2 + _arg4)]));
    }

    public static function getGradientMatrix(_arg1:Number, _arg2:Number, _arg3:Number = 0, _arg4:Number = 0, _arg5:Number = 0):Matrix {
        var _local6:Matrix = new Matrix();
        _local6.createGradientBox(_arg1, _arg2, _arg3, _arg4, _arg5);
        return (_local6);
    }

    public static function drawRect(_arg1:int, _arg2:int, _arg3:int, _arg4:int, _arg5:GraphicsPath):void {
        _arg5.moveTo(_arg1, _arg2);
        _arg5.lineTo((_arg1 + _arg3), _arg2);
        _arg5.lineTo((_arg1 + _arg3), (_arg2 + _arg4));
        _arg5.lineTo(_arg1, (_arg2 + _arg4));
    }

    public static function drawCircle(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:GraphicsPath, _arg5:int = 8):void {
        var _local8:Number;
        var _local9:Number;
        var _local10:Number;
        var _local11:Number;
        var _local12:Number;
        var _local13:Number;
        var _local6:Number = (1 + (1 / (_arg5 * 1.75)));
        _arg4.moveTo((_arg1 + _arg3), _arg2);
        var _local7:int = 1;
        while (_local7 <= _arg5) {
            _local8 = ((TWO_PI * _local7) / _arg5);
            _local9 = ((TWO_PI * (_local7 - 0.5)) / _arg5);
            _local10 = (_arg1 + (_arg3 * Math.cos(_local8)));
            _local11 = (_arg2 + (_arg3 * Math.sin(_local8)));
            _local12 = (_arg1 + ((_arg3 * _local6) * Math.cos(_local9)));
            _local13 = (_arg2 + ((_arg3 * _local6) * Math.sin(_local9)));
            _arg4.curveTo(_local12, _local13, _local10, _local11);
            _local7++;
        }
    }

    public static function drawCutEdgeRect(_arg1:int, _arg2:int, _arg3:int, _arg4:int, _arg5:int, _arg6:Array, _arg7:GraphicsPath):void {
        if (_arg6[0] != 0) {
            _arg7.moveTo(_arg1, (_arg2 + _arg5));
            _arg7.lineTo((_arg1 + _arg5), _arg2);
        }
        else {
            _arg7.moveTo(_arg1, _arg2);
        }
        if (_arg6[1] != 0) {
            _arg7.lineTo(((_arg1 + _arg3) - _arg5), _arg2);
            _arg7.lineTo((_arg1 + _arg3), (_arg2 + _arg5));
        }
        else {
            _arg7.lineTo((_arg1 + _arg3), _arg2);
        }
        if (_arg6[2] != 0) {
            _arg7.lineTo((_arg1 + _arg3), ((_arg2 + _arg4) - _arg5));
            _arg7.lineTo(((_arg1 + _arg3) - _arg5), (_arg2 + _arg4));
        }
        else {
            _arg7.lineTo((_arg1 + _arg3), (_arg2 + _arg4));
        }
        if (_arg6[3] != 0) {
            _arg7.lineTo((_arg1 + _arg5), (_arg2 + _arg4));
            _arg7.lineTo(_arg1, ((_arg2 + _arg4) - _arg5));
        }
        else {
            _arg7.lineTo(_arg1, (_arg2 + _arg4));
        }
        if (_arg6[0] != 0) {
            _arg7.lineTo(_arg1, (_arg2 + _arg5));
        }
        else {
            _arg7.lineTo(_arg1, _arg2);
        }
    }

    public static function drawDiamond(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:GraphicsPath):void {
        _arg4.moveTo(_arg1, (_arg2 - _arg3));
        _arg4.lineTo((_arg1 + _arg3), _arg2);
        _arg4.lineTo(_arg1, (_arg2 + _arg3));
        _arg4.lineTo((_arg1 - _arg3), _arg2);
    }


}
}
