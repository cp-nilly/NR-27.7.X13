package kabam.lib.ui.api {
import org.osflash.signals.Signal;

public interface Scrollbar {

    function get positionChanged():Signal;

    function setSize(_arg1:int, _arg2:int):void;

    function getBarSize():int;

    function getGrooveSize():int;

    function getPosition():Number;

    function setPosition(_arg1:Number):void;

}
}
