package kabam.rotmg.dailyLogin.commands {
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.dailyLogin.view.DailyLoginModal;
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class ShowDailyCalendarPopupCommand {

    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var flushStartupQueue:FlushPopupStartupQueueSignal;
    [Inject]
    public var dailyLoginModel:DailyLoginModel;


    public function execute():void {
        if (((this.dailyLoginModel.shouldDisplayCalendarAtStartup) && (this.dailyLoginModel.initialized))) {
            this.openDialog.dispatch(new DailyLoginModal());
        }
        else {
            this.flushStartupQueue.dispatch();
        }
    }


}
}
