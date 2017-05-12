package kabam.lib.ui.impl {
import flash.display.DisplayObject;

import kabam.lib.ui.api.Layout;

public class NullLayout implements Layout {


    public function getPadding():int {
        return (0);
    }

    public function setPadding(_arg1:int):void {
    }

    public function layout(_arg1:Vector.<DisplayObject>, _arg2:int = 0):void {
    }


}
}
