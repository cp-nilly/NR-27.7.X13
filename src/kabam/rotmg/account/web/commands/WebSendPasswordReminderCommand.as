package kabam.rotmg.account.web.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskGroup;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.services.SendPasswordReminderTask;
import kabam.rotmg.account.web.view.WebLoginDialog;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class WebSendPasswordReminderCommand {

    [Inject]
    public var email:String;
    [Inject]
    public var task:SendPasswordReminderTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var taskError:TaskErrorSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        var _local1:TaskGroup = new TaskGroup();
        _local1.add(new DispatchSignalTask(this.openDialog, new WebLoginDialog()));
        var _local2:TaskGroup = new TaskGroup();
        _local2.add(new DispatchSignalTask(this.taskError, this.task));
        var _local3:BranchingTask = new BranchingTask(this.task, _local1, _local2);
        this.monitor.add(_local3);
        _local3.start();
    }


}
}
