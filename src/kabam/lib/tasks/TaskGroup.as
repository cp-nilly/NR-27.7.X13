package kabam.lib.tasks {
public class TaskGroup extends BaseTask {

    private var tasks:Vector.<BaseTask>;
    private var pending:int;

    public function TaskGroup() {
        this.tasks = new Vector.<BaseTask>();
    }

    public function add(_arg1:BaseTask):void {
        this.tasks.push(_arg1);
    }

    override protected function startTask():void {
        this.pending = this.tasks.length;
        if (this.pending > 0) {
            this.startAllTasks();
        }
        else {
            completeTask(true);
        }
    }

    override protected function onReset():void {
        var _local1:BaseTask;
        for each (_local1 in this.tasks) {
            _local1.reset();
        }
    }

    private function startAllTasks():void {
        var _local1:int = this.pending;
        while (_local1--) {
            this.tasks[_local1].lastly.addOnce(this.onTaskFinished);
            this.tasks[_local1].start();
        }
    }

    private function onTaskFinished(_arg1:BaseTask, _arg2:Boolean, _arg3:String):void {
        if (_arg2) {
            if (--this.pending == 0) {
                completeTask(true);
            }
        }
        else {
            completeTask(false, _arg3);
        }
    }

    public function toString():String {
        return ((("[TaskGroup(" + this.tasks.join(",")) + ")]"));
    }


}
}
