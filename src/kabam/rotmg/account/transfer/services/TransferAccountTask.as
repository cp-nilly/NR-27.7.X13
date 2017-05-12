package kabam.rotmg.account.transfer.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.MigrateAccountTask;
import kabam.rotmg.account.transfer.model.TransferAccountData;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.model.PlatformModel;
import kabam.rotmg.application.model.PlatformType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

public class TransferAccountTask extends BaseTask implements MigrateAccountTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var transferData:TransferAccountData;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kabam/link", this.makeDataPacket());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.onLinkDone(_arg2)));
        completeTask(_arg1, _arg2);
    }

    private function makeDataPacket():Object {
        var _local1:Object = {};
        _local1.kabamemail = this.transferData.currentEmail;
        _local1.kabampassword = this.transferData.currentPassword;
        _local1.email = this.transferData.newEmail;
        _local1.password = this.transferData.newPassword;
        return (_local1);
    }

    private function onLinkDone(_arg1:String):void {
        var _local3:XML;
        var _local2:PlatformModel = StaticInjectorContext.getInjector().getInstance(PlatformModel);
        if (_local2.getPlatform() == PlatformType.WEB) {
            this.account.updateUser(this.transferData.newEmail, this.transferData.newPassword, "");
        }
        else {
            _local3 = new XML(_arg1);
            this.account.updateUser(_local3.GUID, _local3.Secret, "");
            this.account.setPlatformToken(_local3.PlatformToken);
        }
    }


}
}
