package kabam.lib.net.api {
import kabam.lib.net.impl.MessagePool;

public interface MessageMapping {

    function setID(_arg1:int):MessageMapping;

    function toMessage(_arg1:Class):MessageMapping;

    function toHandler(_arg1:Class):MessageMapping;

    function toMethod(_arg1:Function):MessageMapping;

    function setPopulation(_arg1:int):MessageMapping;

    function makePool():MessagePool;

}
}
