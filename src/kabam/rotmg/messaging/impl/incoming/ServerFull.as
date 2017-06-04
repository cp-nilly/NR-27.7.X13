package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class ServerFull extends IncomingMessage {
    
    public var position_:int;
    public var count_:int;
    
    public function ServerFull(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }
    
    override public function parseFromInput(_arg1:IDataInput):void {
        this.position_ = _arg1.readInt();
        this.count_ = _arg1.readInt();
    }
    
    override public function toString():String {
        return (formatToString("SERVERFULL", "position_", "count_"));
    }
    
    
}
}

