package kabam.rotmg.appengine.api {
import org.osflash.signals.OnceSignal;

public interface RetryLoader {

    function get complete():OnceSignal;

    function setMaxRetries(_arg1:int):void;

    function setDataFormat(_arg1:String):void;

    function sendRequest(_arg1:String, _arg2:Object):void;

    function isInProgress():Boolean;

}
}
