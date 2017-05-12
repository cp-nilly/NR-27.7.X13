package com.company.assembleegameclient.ui.tooltip {
public class TooltipHelper {

    public static const BETTER_COLOR:uint = 0xFF00;
    public static const WORSE_COLOR:uint = 0xFF0000;
    public static const NO_DIFF_COLOR:uint = 16777103;


    public static function wrapInFontTag(_arg1:String, _arg2:String):String {
        return ((((('<font color="' + _arg2) + '">') + _arg1) + "</font>"));
    }

    public static function getOpenTag(_arg1:uint):String {
        return ((('<font color="#' + _arg1.toString(16)) + '">'));
    }

    public static function getCloseTag():String {
        return ("</font>");
    }

    public static function getFormattedRangeString(_arg1:Number):String {
        var _local2:Number = (_arg1 - int(_arg1));
        return ((((int((_local2 * 10))) == 0) ? int(_arg1).toString() : _arg1.toFixed(1)));
    }

    public static function getTextColor(_arg1:Number):uint {
        if (_arg1 < 0) {
            return (WORSE_COLOR);
        }
        if (_arg1 > 0) {
            return (BETTER_COLOR);
        }
        return (NO_DIFF_COLOR);
    }


}
}
