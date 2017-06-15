package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class KongregateRegisterAccountTask extends BaseTask implements RegisterAccountTask {

    [Inject]
    public var data:AccountData;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kongregate/register", this.makeDataPacket());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.onInternalRegisterDone(_arg2)));
        completeTask(_arg1, _arg2);
    }

    private function makeDataPacket():Object {
        var _local1:Object = this.api.getAuthentication();
        _local1.newGUID = this.data.username;
        _local1.newPassword = this.data.password;
        _local1.entrytag = this.account.getEntryTag();
        return (_local1);
    }

    private function onInternalRegisterDone(_arg1:String):void {
        this.updateAccount(_arg1);
    }

    private function updateAccount(_arg1:String):void {
        var _local2:XML = new XML(_arg1);
        this.account.updateUser(_local2.GUID, _local2.Secret, "");
        this.account.setPlatformToken(_local2.PlatformToken);
    }


}
}
