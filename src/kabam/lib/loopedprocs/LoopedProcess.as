package kabam.lib.loopedprocs {
import flash.utils.Dictionary;
import flash.utils.getTimer;

public class LoopedProcess {

    private static var maxId:uint;
    private static var loopProcs:Dictionary = new Dictionary();

    public var id:uint;
    public var paused:Boolean;
    public var interval:uint;
    public var lastRun:int;

    public function LoopedProcess(_arg1:uint) {
        this.interval = _arg1;
    }

    public static function addProcess(_arg1:LoopedProcess):uint {
        if (loopProcs[_arg1.id] == _arg1) {
            return (_arg1.id);
        }
        var _local2 = ++maxId;
        loopProcs[_local2] = _arg1;
        _arg1.lastRun = getTimer();
        return (maxId);
    }

    public static function runProcesses(_arg1:int):void {
        var _local2:LoopedProcess;
        var _local3:int;
        for each (_local2 in loopProcs) {
            if (!_local2.paused) {
                _local3 = (_arg1 - _local2.lastRun);
                if (_local3 >= _local2.interval) {
                    _local2.lastRun = _arg1;
                    _local2.run();
                }
            }
        }
    }

    public static function destroyProcess(_arg1:LoopedProcess):void {
        delete loopProcs[_arg1.id];
        _arg1.onDestroyed();
    }

    public static function destroyAll():void {
        var _local1:LoopedProcess;
        for each (_local1 in loopProcs) {
            _local1.destroy();
        }
        loopProcs = new Dictionary();
    }


    final public function add():void {
        addProcess(this);
    }

    final public function destroy():void {
        destroyProcess(this);
    }

    protected function run():void {
    }

    protected function onDestroyed():void {
    }


}
}
