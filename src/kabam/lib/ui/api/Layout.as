package kabam.lib.ui.api {
import flash.display.DisplayObject;

public interface Layout {

    function getPadding():int;

    function setPadding(_arg1:int):void;

    function layout(_arg1:Vector.<DisplayObject>, _arg2:int = 0):void;

}
}
