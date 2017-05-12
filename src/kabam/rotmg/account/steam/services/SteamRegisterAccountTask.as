package kabam.rotmg.account.steam.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.steam.SteamApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

import robotlegs.bender.framework.api.ILogger;

public class SteamRegisterAccountTask extends BaseTask implements RegisterAccountTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var api:SteamApi;
    [Inject]
    public var data:AccountData;
    [Inject]
    public var logger:ILogger;
    [Inject]
    private var client:AppEngineClient;


    override protected function startTask():void {
        this.logger.debug("startTask");
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/steamworks/register", this.makeDataPacket());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onRegisterDone(_arg2);
        }
        else {
            this.onRegisterError(_arg2);
        }
    }

    private function makeDataPacket():Object {
        var _local1:Object = this.api.getSessionAuthentication();
        _local1.newGUID = this.data.username;
        _local1.newPassword = this.data.password;
        _local1.entrytag = this.account.getEntryTag();
        return (_local1);
    }

    private function onRegisterDone(_arg1:String):void {
        var _local2:XML = new XML(_arg1);
        this.logger.debug("done - {0}", [_local2.GUID]);
        this.account.updateUser(_local2.GUID, _local2.Secret, "");
        this.account.setPlatformToken(_local2.PlatformToken);
        completeTask(true);
    }

    private function onRegisterError(_arg1:String):void {
        this.logger.debug("error - {0}", [_arg1]);
        completeTask(false, _arg1);
    }


}
}
