package com.company.assembleegameclient.util {
import flash.display.DisplayObject;

public class DisplayHierarchy {


    public static function getParentWithType(_arg1:DisplayObject, _arg2:Class):DisplayObject {
        while (((_arg1) && (!((_arg1 is _arg2))))) {
            _arg1 = _arg1.parent;
        }
        return (_arg1);
    }

    public static function getParentWithTypeArray(_arg1:DisplayObject, ..._args):DisplayObject {
        var _local3:Class;
        while (_arg1) {
            for each (_local3 in _args) {
                if ((_arg1 is _local3)) {
                    return (_arg1);
                }
            }
            _arg1 = _arg1.parent;
        }
        return (_arg1);
    }


}
}
