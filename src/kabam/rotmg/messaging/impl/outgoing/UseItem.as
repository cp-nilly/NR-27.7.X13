package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.data.WorldPosData;

public class UseItem extends OutgoingMessage {

    public var time_:int;
    public var slotObject_:SlotObjectData;
    public var itemUsePos_:WorldPosData;
    public var useType_:int;

    public function UseItem(_arg1:uint, _arg2:Function) {
        this.slotObject_ = new SlotObjectData();
        this.itemUsePos_ = new WorldPosData();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.time_);
        this.slotObject_.writeToOutput(_arg1);
        this.itemUsePos_.writeToOutput(_arg1);
        _arg1.writeByte(this.useType_);
    }

    override public function toString():String {
        return (formatToString("USEITEM", "slotObject_", "itemUsePos_", "useType_"));
    }


}
}
