package kabam.rotmg.game.logging {
import kabam.lib.console.signals.ConsoleWatchSignal;

public class RollingMeanLoopMonitor implements LoopMonitor {

    [Inject]
    public var watch:ConsoleWatchSignal;
    private var watchMap:Object;

    public function RollingMeanLoopMonitor() {
        this.watchMap = {};
    }

    public function recordTime(_arg1:String, _arg2:int):void {
        var _local3:GameSpriteLoopWatch = (this.watchMap[_arg1] = ((this.watchMap[_arg1]) || (new GameSpriteLoopWatch(_arg1))));
        _local3.logTime(_arg2);
        this.watch.dispatch(_local3);
    }


}
}
