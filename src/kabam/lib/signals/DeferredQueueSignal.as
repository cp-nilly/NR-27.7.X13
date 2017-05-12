package kabam.lib.signals {
import org.osflash.signals.ISlot;
import org.osflash.signals.Signal;

public class DeferredQueueSignal extends Signal {

    private var data:Array;
    private var log:Boolean = true;

    public function DeferredQueueSignal(..._args) {
        this.data = [];
        super(_args);
    }

    override public function dispatch(..._args):void {
        if (this.log) {
            this.data.push(_args);
        }
        super.dispatch.apply(this, _args);
    }

    override public function add(_arg1:Function):ISlot {
        var _local2:ISlot = super.add(_arg1);
        while (this.data.length > 0) {
            _arg1.apply(this, this.data.shift());
        }
        this.log = false;
        return (_local2);
    }

    override public function addOnce(_arg1:Function):ISlot {
        var _local2:ISlot;
        if (this.data.length > 0) {
            _arg1.apply(this, this.data.shift());
        }
        else {
            _local2 = super.addOnce(_arg1);
            this.log = false;
        }
        while (this.data.length > 0) {
            this.data.shift();
        }
        return (_local2);
    }

    public function getNumData():int {
        return (this.data.length);
    }


}
}
