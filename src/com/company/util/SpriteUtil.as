package com.company.util {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class SpriteUtil {


    public static function safeAddChild(_arg1:DisplayObjectContainer, _arg2:DisplayObject):void {
        if (((((!((_arg1 == null))) && (!((_arg2 == null))))) && (!(_arg1.contains(_arg2))))) {
            _arg1.addChild(_arg2);
        }
    }

    public static function safeRemoveChild(_arg1:DisplayObjectContainer, _arg2:DisplayObject):void {
        if (((((!((_arg1 == null))) && (!((_arg2 == null))))) && (_arg1.contains(_arg2)))) {
            _arg1.removeChild(_arg2);
        }
    }


}
}
