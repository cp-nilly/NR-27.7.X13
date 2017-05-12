package kabam.rotmg.account.web.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.SendConfirmEmailSignal;
import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebAccountDetailMediator extends Mediator {

    [Inject]
    public var view:WebAccountDetailDialog;
    [Inject]
    public var account:Account;
    [Inject]
    public var track:TrackEventSignal;
    [Inject]
    public var verify:SendConfirmEmailSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var updateAccount:UpdateAccountInfoSignal;


    override public function initialize():void {
        this.view.setUserInfo(this.account.getUserName(), this.account.isVerified());
        this.view.change.add(this.onChange);
        this.view.logout.add(this.onLogout);
        this.view.cancel.add(this.onDone);
        this.view.verify.add(this.onVerify);
    }

    override public function destroy():void {
        this.view.change.remove(this.onChange);
        this.view.logout.remove(this.onLogout);
        this.view.cancel.remove(this.onDone);
        this.view.verify.remove(this.onVerify);
    }

    private function onChange():void {
        this.openDialog.dispatch(new WebChangePasswordDialog());
    }

    private function onLogout():void {
        this.trackLoggedOut();
        this.account.clear();
        this.updateAccount.dispatch();
        this.openDialog.dispatch(new WebLoginDialog());
    }

    private function trackLoggedOut():void {
        var _local1:TrackingData = new TrackingData();
        _local1.category = "account";
        _local1.action = "loggedOut";
        this.track.dispatch(_local1);
    }

    private function onDone():void {
        this.closeDialog.dispatch();
    }

    private function onVerify():void {
        var _local1:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        _local1.complete.addOnce(this.onComplete);
        _local1.sendRequest("/account/sendVerifyEmail", this.account.getCredentials());
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
    }

    private function trackEmailSent():void {
        var _local1:TrackingData = new TrackingData();
        _local1.category = "account";
        _local1.action = "verifyEmailSent";
        this.track.dispatch(_local1);
    }

    private function onError(_arg1:String):void {
        this.account.clear();
    }


}
}
