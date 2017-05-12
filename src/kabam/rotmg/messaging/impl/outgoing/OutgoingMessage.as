package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataInput;

import kabam.lib.net.impl.Message;

public class OutgoingMessage extends Message {

    public function OutgoingMessage(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    final override public function parseFromInput(_arg1:IDataInput):void {
        throw (new Error((("Client should not receive " + id) + " messages")));
    }


}
}
