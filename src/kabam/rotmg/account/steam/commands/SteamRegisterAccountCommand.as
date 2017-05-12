package kabam.rotmg.account.steam.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.RegisterAccountTask;
import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
import kabam.rotmg.account.steam.view.SteamAccountDetailDialog;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class SteamRegisterAccountCommand {

    [Inject]
    public var data:AccountData;
    [Inject]
    public var task:RegisterAccountTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var update:UpdateAccountInfoSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var taskError:TaskErrorSignal;


    public function execute():void {
        var _local1:BranchingTask = new BranchingTask(this.task, this.onSuccess(), this.onFailure());
        this.monitor.add(_local1);
        _local1.start();
    }

    private function onSuccess():TaskSequence {
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(new DispatchSignalTask(this.update));
        _local1.add(new DispatchSignalTask(this.openDialog, new SteamAccountDetailDialog()));
        return (_local1);
    }

    private function onFailure():Task {
        return (new DispatchSignalTask(this.taskError, this.task));
    }


}
}
