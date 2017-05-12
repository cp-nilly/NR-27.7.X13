package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Pong extends OutgoingMessage {

    public var serial_:int;
    public var time_:int;

    public function Pong(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.serial_);
        _arg1.writeInt(this.time_);
    }

    override public function toString():String {
        return (formatToString("PONG", "serial_", "time_"));
    }


}
}
