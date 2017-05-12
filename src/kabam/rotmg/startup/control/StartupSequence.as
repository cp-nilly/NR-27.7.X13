package kabam.rotmg.startup.control {
import kabam.lib.tasks.BaseTask;
import kabam.lib.tasks.Task;
import kabam.rotmg.startup.model.api.StartupDelegate;
import kabam.rotmg.startup.model.impl.SignalTaskDelegate;
import kabam.rotmg.startup.model.impl.TaskDelegate;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.ILogger;

public class StartupSequence extends BaseTask {

    public static const LAST:int = int.MAX_VALUE;//2147483647

    private const list:Vector.<StartupDelegate> = new <StartupDelegate>[];

    [Inject]
    public var injector:Injector;
    [Inject]
    public var logger:ILogger;
    private var index:int = 0;


    public function addSignal(_arg1:Class, _arg2:int = 0):void {
        var _local3:SignalTaskDelegate = new SignalTaskDelegate();
        _local3.injector = this.injector;
        _local3.signalClass = _arg1;
        _local3.priority = _arg2;
        this.list.push(_local3);
    }

    public function addTask(_arg1:Class, _arg2:int = 0):void {
        var _local3:TaskDelegate = new TaskDelegate();
        _local3.injector = this.injector;
        _local3.taskClass = _arg1;
        _local3.priority = _arg2;
        this.list.push(_local3);
    }

    override protected function startTask():void {
        this.list.sort(this.priorityComparison);
        this.index = 0;
        this.doNextTaskOrComplete();
    }

    private function priorityComparison(_arg1:StartupDelegate, _arg2:StartupDelegate):int {
        return ((_arg1.getPriority() - _arg2.getPriority()));
    }

    private function doNextTaskOrComplete():void {
        if (this.isAnotherTask()) {
            this.doNextTask();
        }
        else {
            completeTask(true);
        }
    }

    private function isAnotherTask():Boolean {
        return ((this.index < this.list.length));
    }

    private function doNextTask():void {
        var _local1:Task = this.list[this.index++].make();
        _local1.lastly.addOnce(this.onTaskFinished);
        this.logger.info("StartupSequence start:{0}", [_local1]);
        _local1.start();
    }

    private function onTaskFinished(_arg1:Task, _arg2:Boolean, _arg3:String):void {
        this.logger.info("StartupSequence finish:{0} (isOK: {1})", [_arg1, _arg2]);
        if (_arg2) {
            this.doNextTaskOrComplete();
        }
        else {
            completeTask(false, _arg3);
        }
    }


}
}
