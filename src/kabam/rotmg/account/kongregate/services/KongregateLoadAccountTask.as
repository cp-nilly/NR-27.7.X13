package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.LoadAccountTask;

public class KongregateLoadAccountTask extends BaseTask implements LoadAccountTask {

    [Inject]
    public var loadApi:KongregateLoadApiTask;
    [Inject]
    public var getCredentials:KongregateGetCredentialsTask;
    [Inject]
    public var monitor:TaskMonitor;


    override protected function startTask():void {
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(this.loadApi);
        _local1.add(this.getCredentials);
        _local1.lastly.add(this.onTasksComplete);
        this.monitor.add(_local1);
        _local1.start();
    }

    private function onTasksComplete(_arg1:Task, _arg2:Boolean, _arg3:String):void {
        completeTask(true);
    }


}
}
