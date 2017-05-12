package kabam.lib.console.model {
import kabam.lib.console.vo.ConsoleAction;

import org.osflash.signals.Signal;

public final class Console {

    private var hash:ActionHash;
    private var history:ActionHistory;

    public function Console() {
        this.hash = new ActionHash();
        this.history = new ActionHistory();
    }

    public function register(_arg1:ConsoleAction, _arg2:Signal):void {
        this.hash.register(_arg1.name, _arg1.description, _arg2);
    }

    public function hasAction(_arg1:String):Boolean {
        return (this.hash.has(_arg1));
    }

    public function execute(_arg1:String):void {
        this.history.add(_arg1);
        this.hash.execute(_arg1);
    }

    public function getNames():Vector.<String> {
        return (this.hash.getNames());
    }

    public function getPreviousAction():String {
        return (this.history.getPrevious());
    }

    public function getNextAction():String {
        return (this.history.getNext());
    }


}
}
