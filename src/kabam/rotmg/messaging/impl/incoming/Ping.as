package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Ping extends IncomingMessage {

    public var serial_:int;

    public function Ping(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.serial_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("PING", "serial_"));
    }


}
}
