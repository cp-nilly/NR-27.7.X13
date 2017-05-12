package kabam.lib.tasks {
public class TaskMonitor {

    private var tasks:Vector.<Task>;

    public function TaskMonitor() {
        this.tasks = new <Task>[];
    }

    public function add(_arg1:Task):void {
        this.tasks.push(_arg1);
        _arg1.finished.addOnce(this.onTaskFinished);
    }

    public function has(_arg1:Task):Boolean {
        return (!((this.tasks.indexOf(_arg1) == -1)));
    }

    private function onTaskFinished(_arg1:Task, _arg2:Boolean, _arg3:String = ""):void {
        this.tasks.splice(this.tasks.indexOf(_arg1), 1);
    }


}
}
