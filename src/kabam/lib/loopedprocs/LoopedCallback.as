package kabam.lib.loopedprocs {
public class LoopedCallback extends LoopedProcess {

    public var callback:Function;
    public var parameters:Array;

    public function LoopedCallback(_arg1:int, _arg2:Function, ..._args) {
        super(_arg1);
        this.callback = _arg2;
        this.parameters = _args;
    }

    override protected function run():void {
        this.callback.apply(this.parameters);
    }

    override protected function onDestroyed():void {
        this.callback = null;
        this.parameters = null;
    }


}
}
