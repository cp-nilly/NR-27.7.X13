package kabam.rotmg.dialogs.model {
import org.osflash.signals.Signal;

public class PopupQueueEntry {

    private var _name:String;
    private var _signal:Signal;
    private var _showingPerDay:int;
    private var _paramObject:Object;

    public function PopupQueueEntry(_arg1:String, _arg2:Signal, _arg3:int, _arg4:Object) {
        this._name = _arg1;
        this._signal = _arg2;
        this._showingPerDay = _arg3;
        this._paramObject = _arg4;
    }

    public function get name():String {
        return (this._name);
    }

    public function set name(_arg1:String):void {
        this._name = _arg1;
    }

    public function get signal():Signal {
        return (this._signal);
    }

    public function set signal(_arg1:Signal):void {
        this._signal = _arg1;
    }

    public function get showingPerDay():int {
        return (this._showingPerDay);
    }

    public function set showingPerDay(_arg1:int):void {
        this._showingPerDay = _arg1;
    }

    public function get paramObject():Object {
        return (this._paramObject);
    }

    public function set paramObject(_arg1:Object):void {
        this._paramObject = _arg1;
    }


}
}
