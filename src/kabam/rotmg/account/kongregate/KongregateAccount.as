package kabam.rotmg.account.kongregate {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.kongregate.view.KongregateApi;

public class KongregateAccount implements Account {

    public static const NETWORK_NAME:String = "kongregate";

    [Inject]
    public var api:KongregateApi;
    private var userId:String = "";
    private var password:String;
    private var isVerifiedEmail:Boolean;
    private var platformToken:String;
    private var _rememberMe:Boolean;


    public function updateUser(_arg1:String, _arg2:String, _arg3:String):void {
        this.userId = _arg1;
        this.password = _arg2;
    }

    public function getUserName():String {
        return (this.api.getUserName());
    }

    public function getUserId():String {
        return (this.userId);
    }

    public function getPassword():String {
        return ("");
    }

    public function getSecret():String {
        return (((this.password) || ("")));
    }

    public function getCredentials():Object {
        return ({
            "guid": this.getUserId(),
            "secret": this.getSecret()
        });
    }

    public function isRegistered():Boolean {
        return (!((this.getSecret() == "")));
    }

    public function gameNetworkUserId():String {
        return (this.api.getUserId());
    }

    public function gameNetwork():String {
        return (NETWORK_NAME);
    }

    public function playPlatform():String {
        return ("kongregate");
    }

    public function reportIntStat(_arg1:String, _arg2:int):void {
        this.api.reportStatistic(_arg1, _arg2);
    }

    public function getRequestPrefix():String {
        return ("/kongregate");
    }

    public function getEntryTag():String {
        return ("kongregate");
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
        throw (new Error("No current support for new Kabam offer wall on Kongregate."));
    }

    public function getMoneyUserId():String {
        throw (new Error("No current support for new Kabam offer wall on Kongregate."));
    }

    public function set rememberMe(_arg1:Boolean):void {
        this._rememberMe = _arg1;
    }

    public function get rememberMe():Boolean {
        return (this._rememberMe);
    }

    public function getToken():String {
        return ("");
    }


}
}
