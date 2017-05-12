package kabam.lib.net.impl {
public class MessagePool {

    public var type:Class;
    public var callback:Function;
    public var id:int;
    private var tail:Message;
    private var count:int = 0;

    public function MessagePool(_arg1:int, _arg2:Class, _arg3:Function) {
        this.type = _arg2;
        this.id = _arg1;
        this.callback = _arg3;
    }

    public function populate(_arg1:int):MessagePool {
        var _local2:Message;
        this.count = (this.count + _arg1);
        while (_arg1--) {
            _local2 = new this.type(this.id, this.callback);
            _local2.pool = this;
            ((this.tail) && ((this.tail.next = _local2)));
            _local2.prev = this.tail;
            this.tail = _local2;
        }
        return (this);
    }

    public function require():Message {
        var _local1:Message = this.tail;
        if (_local1) {
            this.tail = this.tail.prev;
            _local1.prev = null;
            _local1.next = null;
        }
        else {
            _local1 = new this.type(this.id, this.callback);
            _local1.pool = this;
            this.count++;
        }
        return (_local1);
    }

    public function getCount():int {
        return (this.count);
    }

    function append(_arg1:Message):void {
        ((this.tail) && ((this.tail.next = _arg1)));
        _arg1.prev = this.tail;
        this.tail = _arg1;
    }

    public function dispose():void {
        this.tail = null;
    }


}
}
