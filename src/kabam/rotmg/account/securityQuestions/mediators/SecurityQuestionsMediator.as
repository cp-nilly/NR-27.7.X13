package kabam.rotmg.account.securityQuestions.mediators {
import com.hurlant.util.Base64;

import flash.events.MouseEvent;

import kabam.lib.tasks.Task;
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsData;
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.signals.SaveSecurityQuestionsSignal;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsConfirmDialog;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsDialog;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SecurityQuestionsMediator extends Mediator {

    [Inject]
    public var view:SecurityQuestionsDialog;
    [Inject]
    public var infoView:SecurityQuestionsInfoDialog;
    [Inject]
    public var confirmationView:SecurityQuestionsConfirmDialog;
    [Inject]
    public var saveQuestions:SaveSecurityQuestionsSignal;
    [Inject]
    public var taskError:TaskErrorSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var securityQuestionsModel:SecurityQuestionsModel;


    override public function initialize():void {
        this.view.rightButton_.addEventListener(MouseEvent.CLICK, this.onShowConfirmationClick);
        this.infoView.rightButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
        this.confirmationView.leftButton_.addEventListener(MouseEvent.CLICK, this.onBackClick);
        this.confirmationView.rightButton_.addEventListener(MouseEvent.CLICK, this.onSaveQuestions);
        this.taskError.add(this.onTaskError);
    }

    override public function destroy():void {
        this.taskError.remove(this.onTaskError);
        this.view.rightButton_.removeEventListener(MouseEvent.CLICK, this.onShowConfirmationClick);
        this.infoView.rightButton_.removeEventListener(MouseEvent.CLICK, this.onContinueClick);
        this.confirmationView.leftButton_.removeEventListener(MouseEvent.CLICK, this.onBackClick);
        this.confirmationView.rightButton_.removeEventListener(MouseEvent.CLICK, this.onSaveQuestions);
        this.view.dispose();
        this.infoView.dispose();
        this.confirmationView.dispose();
    }

    private function onTaskError(_arg1:Task):void {
        this.confirmationView.enable();
        this.confirmationView.setError(_arg1.error);
    }

    private function onShowConfirmationClick(_arg1:MouseEvent):void {
        this.view.clearErrors();
        if (!this.view.areQuestionsValid()) {
            this.view.displayErrorText();
        }
        else {
            this.securityQuestionsModel.securityQuestionsAnswers = this.view.getAnswers();
            this.closeDialogs.dispatch();
            this.openDialog.dispatch(new SecurityQuestionsConfirmDialog(this.securityQuestionsModel.securityQuestionsList, this.securityQuestionsModel.securityQuestionsAnswers));
        }
    }

    private function onBackClick(_arg1:MouseEvent):void {
        this.closeDialogs.dispatch();
        this.openDialog.dispatch(new SecurityQuestionsDialog(this.securityQuestionsModel.securityQuestionsList, this.securityQuestionsModel.securityQuestionsAnswers));
    }

    private function onContinueClick(_arg1:MouseEvent):void {
        this.closeDialogs.dispatch();
        this.openDialog.dispatch(new SecurityQuestionsDialog(this.securityQuestionsModel.securityQuestionsList, []));
    }

    private function onSaveQuestions(_arg1:MouseEvent):void {
        var _local3:String;
        this.confirmationView.disable();
        this.confirmationView.setInProgressMessage();
        var _local2:SecurityQuestionsData = new SecurityQuestionsData();
        _local2.answers = [];
        for each (_local3 in this.securityQuestionsModel.securityQuestionsAnswers) {
            _local2.answers.push(Base64.encode(_local3));
        }
        this.saveQuestions.dispatch(_local2);
    }


}
}
