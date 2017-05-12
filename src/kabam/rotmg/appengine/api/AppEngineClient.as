package kabam.rotmg.appengine.api {
import org.osflash.signals.OnceSignal;

public interface AppEngineClient {

    function get complete():OnceSignal;

    function setDataFormat(_arg1:String):void;

    function setSendEncrypted(_arg1:Boolean):void;

    function setMaxRetries(_arg1:int):void;

    function sendRequest(_arg1:String, _arg2:Object):void;

    function requestInProgress():Boolean;

}
}
