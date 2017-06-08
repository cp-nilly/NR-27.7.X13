package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class EnterArena extends OutgoingMessage {

    public var currency:int;

    public function EnterArena(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.currency);
    }

    override public function toString():String {
        return (formatToString("ENTER_ARENA", "currency"));
    }


}
}
