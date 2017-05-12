package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class InvDrop extends OutgoingMessage {

    public var slotObject_:SlotObjectData;

    public function InvDrop(_arg1:uint, _arg2:Function) {
        this.slotObject_ = new SlotObjectData();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        this.slotObject_.writeToOutput(_arg1);
    }

    override public function toString():String {
        return (formatToString("INVDROP", "slotObject_"));
    }


}
}
