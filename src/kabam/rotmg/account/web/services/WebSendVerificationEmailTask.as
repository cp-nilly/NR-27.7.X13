package kabam.rotmg.account.web.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.SendConfirmEmailAddressTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;

public class WebSendVerificationEmailTask extends BaseTask implements SendConfirmEmailAddressTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var track:TrackEventSignal;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onSent();
        }
        else {
            this.onError(_arg2);
        }
    }

    private function onSent():void {
        this.trackEmailSent();
        completeTask(true);
    }

    private function trackEmailSent():void {
        var _local1:TrackingData = new TrackingData();
        _local1.category = "account";
        _local1.action = "verifyEmailSent";
        this.track.dispatch(_local1);
    }

    private function onError(_arg1:String):void {
        this.account.clear();
        completeTask(false);
    }


}
}
