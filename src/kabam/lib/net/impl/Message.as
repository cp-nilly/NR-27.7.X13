package kabam.lib.net.impl {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class Message {

    public var pool:MessagePool;
    public var prev:Message;
    public var next:Message;
    private var isCallback:Boolean;
    public var id:uint;
    public var callback:Function;

    public function Message(_arg1:uint, _arg2:Function = null) {
        this.id = _arg1;
        this.isCallback = !((_arg2 == null));
        this.callback = _arg2;
    }

    public function parseFromInput(_arg1:IDataInput):void {
    }

    public function writeToOutput(_arg1:IDataOutput):void {
    }

    public function toString():String {
        return (this.formatToString("MESSAGE", "id"));
    }

    protected function formatToString(_arg1:String, ..._args):String {
        var _local3:String = ("[" + _arg1);
        var _local4:int;
        while (_local4 < _args.length) {
            _local3 = (_local3 + ((((" " + _args[_local4]) + '="') + this[_args[_local4]]) + '"'));
            _local4++;
        }
        return ((_local3 + "]"));
    }

    public function consume():void {
        ((this.isCallback) && (this.callback(this)));
        this.prev = null;
        this.next = null;
        this.pool.append(this);
    }


}
}
