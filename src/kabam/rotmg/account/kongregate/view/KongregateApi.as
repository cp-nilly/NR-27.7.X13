package kabam.rotmg.account.kongregate.view {
import org.osflash.signals.Signal;

public interface KongregateApi {

    function load(_arg1:String):void;

    function get loaded():Signal;

    function isGuest():Boolean;

    function showRegistrationDialog():void;

    function getAuthentication():Object;

    function reportStatistic(_arg1:String, _arg2:int):void;

    function getUserName():String;

    function getUserId():String;

    function purchaseItems(_arg1:Object):void;

    function get purchaseResponse():Signal;

}
}
