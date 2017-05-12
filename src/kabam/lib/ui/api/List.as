package kabam.lib.ui.api {
import flash.display.DisplayObject;

public interface List {

    function addItem(_arg1:DisplayObject):void;

    function setItems(_arg1:Vector.<DisplayObject>):void;

    function getItemAt(_arg1:int):DisplayObject;

    function getItemCount():int;

}
}
