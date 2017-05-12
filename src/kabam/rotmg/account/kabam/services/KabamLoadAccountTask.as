package kabam.rotmg.account.kabam.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.kabam.KabamAccount;
import kabam.rotmg.account.kabam.model.KabamParameters;
import kabam.rotmg.account.kabam.view.AccountLoadErrorDialog;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class KabamLoadAccountTask extends BaseTask implements LoadAccountTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var parameters:KabamParameters;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var client:AppEngineClient;
    private var kabam:KabamAccount;


    override protected function startTask():void {
        this.kabam = (this.account as KabamAccount);
        this.kabam.signedRequest = this.parameters.getSignedRequest();
        this.kabam.userSession = this.parameters.getUserSession();
        if (this.kabam.userSession == null) {
            this.openDialog.dispatch(new AccountLoadErrorDialog());
            completeTask(false);
        }
        else {
            this.sendRequest();
        }
    }

    private function sendRequest():void {
        var _local1:Object = {
            "signedRequest": this.kabam.signedRequest,
            "entrytag": this.account.getEntryTag()
        };
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kabam/getcredentials", _local1);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.onGetCredentialsDone(_arg2)));
        completeTask(_arg1, _arg2);
    }

    private function onGetCredentialsDone(_arg1:String):void {
        var _local2:XML = new XML(_arg1);
        this.account.updateUser(_local2.GUID, _local2.Secret, "");
        this.account.setPlatformToken(_local2.PlatformToken);
    }


}
}
