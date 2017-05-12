package kabam.rotmg.account.securityQuestions.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.tasks.SaveSecurityQuestionsTask;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class SaveSecurityQuestionsCommand {

    [Inject]
    public var task:SaveSecurityQuestionsTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var taskError:TaskErrorSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var track:TrackEventSignal;
    [Inject]
    public var securityQuestionsModel:SecurityQuestionsModel;


    public function execute():void {
        var _local1:BranchingTask = new BranchingTask(this.task, this.makeSuccess(), this.makeFailure());
        this.monitor.add(_local1);
        _local1.start();
    }

    private function makeSuccess():Task {
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(new DispatchSignalTask(this.track, this.getTrackingData()));
        _local1.add(new DispatchSignalTask(this.closeDialogs));
        this.securityQuestionsModel.showSecurityQuestionsOnStartup = false;
        return (_local1);
    }

    private function makeFailure():DispatchSignalTask {
        return (new DispatchSignalTask(this.taskError, this.task));
    }

    private function getTrackingData():TrackingData {
        var _local1:TrackingData = new TrackingData();
        _local1.category = "account";
        _local1.action = "saveSecurityQuestions";
        return (_local1);
    }


}
}
