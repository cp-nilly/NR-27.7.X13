package kabam.rotmg.account.web.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoginTask;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class WebLoginTask extends BaseTask implements LoginTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var data:AccountData;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/verify", {
            "guid": this.data.username,
            "password": this.data.password
        });
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.updateUser(_arg2);
        }
        completeTask(_arg1, _arg2);
    }

    private function updateUser(_arg1:String):void {
        this.account.updateUser(this.data.username, this.data.password, "");
    }


}
}
