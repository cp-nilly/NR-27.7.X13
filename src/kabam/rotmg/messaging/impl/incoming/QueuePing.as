package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class QueuePing extends IncomingMessage {
    
    public var serial_:int;
    public var position_:int;
    public var count_:int;
    
    public function QueuePing(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }
    
    override public function parseFromInput(_arg1:IDataInput):void {
        this.serial_ = _arg1.readInt();
        this.position_ = _arg1.readInt();
        this.count_ = _arg1.readInt();
    }
    
    override public function toString():String {
        return (formatToString("QUEUEPING", "serial_", "position_", "count_"));
    }
    
    
}
}

