package kabam.rotmg.servers.api {
public interface ServerModel {

    function setServers(_arg1:Vector.<Server>):void;

    function getServer():Server;

    function isServerAvailable():Boolean;

    function getServers():Vector.<Server>;

}
}
