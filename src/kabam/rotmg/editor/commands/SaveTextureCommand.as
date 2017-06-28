package kabam.rotmg.editor.commands {
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.editor.services.SaveTextureTask;

public class SaveTextureCommand {

    [Inject]
    public var task:SaveTextureTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var closeDialog:CloseDialogsSignal;


    public function execute():void {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(this.task);
        _local_1.add(new DispatchSignalTask(this.closeDialog));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}
