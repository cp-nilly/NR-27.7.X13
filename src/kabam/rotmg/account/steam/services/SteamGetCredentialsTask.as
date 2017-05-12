package kabam.rotmg.account.steam.services {
import com.company.assembleegameclient.ui.dialogs.DebugDialog;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.steam.SteamApi;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class SteamGetCredentialsTask extends BaseTask {

    private static const ERROR_TEMPLATE:String = "Error: ${error}";

    [Inject]
    public var account:Account;
    [Inject]
    public var steam:SteamApi;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        var _local1:Object = this.steam.getSessionAuthentication();
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/steamworks/getcredentials", _local1);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onGetCredentialsDone(_arg2);
        }
        else {
            this.onGetCredentialsError(_arg2);
        }
        completeTask(_arg1, _arg2);
    }

    private function onGetCredentialsDone(_arg1:String):void {
        var _local2:XML = new XML(_arg1);
        this.account.updateUser(_local2.GUID, _local2.Secret, "");
        this.account.setPlatformToken(_local2.PlatformToken);
    }

    private function onGetCredentialsError(_arg1:String):void {
        var _local2:String = ERROR_TEMPLATE.replace("${error}", _arg1);
        var _local3:DebugDialog = new DebugDialog(_local2);
        this.openDialog.dispatch(_local3);
    }


}
}
