package kabam.rotmg.account.steam {
import com.company.util.EmailValidator;

import kabam.rotmg.account.core.Account;

public class SteamAccount implements Account {

    public static const NETWORK_NAME:String = "steam";

    [Inject]
    public var api:SteamApi;
    private var userId:String = "";
    private var password:String = null;
    private var isVerifiedEmail:Boolean;
    private var platformToken:String;


    public function updateUser(_arg1:String, _arg2:String, _arg3:String):void {
        this.userId = _arg1;
        this.password = _arg2;
    }

    public function getUserName():String {
        return (this.api.getPersonaName());
    }

    public function getUserId():String {
        return ((this.userId = ((this.userId) || (""))));
    }

    public function getPassword():String {
        return ("");
    }

    public function getSecret():String {
        return ((this.password = ((this.password) || (""))));
    }

    public function getCredentials():Object {
        var _local1:Object = {};
        _local1.guid = this.getUserId();
        _local1.secret = this.getSecret();
        _local1.steamid = this.api.getSteamId();
        return (_local1);
    }

    public function isRegistered():Boolean {
        return (!((this.getSecret() == "")));
    }

    public function isLinked():Boolean {
        return (EmailValidator.isValidEmail(this.userId));
    }

    public function gameNetworkUserId():String {
        return (this.api.getSteamId());
    }

    public function gameNetwork():String {
        return (NETWORK_NAME);
    }

    public function playPlatform():String {
        return ("steam");
    }

    public function reportIntStat(_arg1:String, _arg2:int):void {
        this.api.reportStatistic(_arg1, _arg2);
    }

    public function getRequestPrefix():String {
        return ("/steamworks");
    }

    public function getEntryTag():String {
        return ("steamworks");
    }

    public function clear():void {
    }

    public function verify(_arg1:Boolean):void {
        this.isVerifiedEmail = _arg1;
    }

    public function isVerified():Boolean {
        return (this.isVerifiedEmail);
    }

    public function getPlatformToken():String {
        return (((this.platformToken) || ("")));
    }

    public function setPlatformToken(_arg1:String):void {
        this.platformToken = _arg1;
    }

    public function getMoneyAccessToken():String {
        throw (new Error("No current support for new Kabam offer wall on Steam."));
    }

    public function getMoneyUserId():String {
        throw (new Error("No current support for new Kabam offer wall on Steam."));
    }

    public function getToken():String {
        return ("");
    }


}
}
