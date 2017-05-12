package kabam.rotmg.account.transfer.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.transfer.model.TransferAccountData;
import kabam.rotmg.account.transfer.view.KabamLoginView;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;

public class CheckKabamAccountTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var data:TransferAccountData;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var view:KabamLoginView;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kabam/verify", this.makeDataPacket());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (!_arg1) {
            this.view.setError(_arg2);
            this.view.enable();
        }
        else {
            this.onChangeDone();
        }
        completeTask(_arg1, _arg2);
    }

    private function makeDataPacket():Object {
        var _local1:Object = {};
        _local1.kabamemail = this.data.currentEmail;
        _local1.kabampassword = this.data.currentPassword;
        return (_local1);
    }

    private function onChangeDone():void {
        this.account.updateUser(this.data.newEmail, this.data.newPassword, "");
        completeTask(true);
    }


}
}
