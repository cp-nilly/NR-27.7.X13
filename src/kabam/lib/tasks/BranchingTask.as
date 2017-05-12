package kabam.lib.tasks {
public class BranchingTask extends BaseTask {

    private var task:Task;
    private var success:Task;
    private var failure:Task;

    public function BranchingTask(_arg1:Task, _arg2:Task = null, _arg3:Task = null) {
        this.task = _arg1;
        this.success = _arg2;
        this.failure = _arg3;
    }

    public function addSuccessTask(_arg1:Task):void {
        this.success = _arg1;
    }

    public function addFailureTask(_arg1:Task):void {
        this.failure = _arg1;
    }

    override protected function startTask():void {
        this.task.finished.addOnce(this.onTaskFinished);
        this.task.start();
    }

    private function onTaskFinished(_arg1:Task, _arg2:Boolean, _arg3:String = ""):void {
        if (_arg2) {
            this.handleBranchTask(this.success);
        }
        else {
            this.handleBranchTask(this.failure);
        }
    }

    private function handleBranchTask(_arg1:Task):void {
        if (_arg1) {
            _arg1.finished.addOnce(this.onBranchComplete);
            _arg1.start();
        }
        else {
            completeTask(true);
        }
    }

    private function onBranchComplete(_arg1:Task, _arg2:Boolean, _arg3:String = ""):void {
        completeTask(_arg2, _arg3);
    }


}
}
