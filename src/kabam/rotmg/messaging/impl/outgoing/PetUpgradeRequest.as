package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class PetUpgradeRequest extends OutgoingMessage {

    public static const GOLD_PAYMENT_TYPE:int = 0;
    public static const FAME_PAYMENT_TYPE:int = 1;

    public var petTransType:int;
    public var PIDOne:int;
    public var PIDTwo:int;
    public var objectId:int;
    public var slotObject:SlotObjectData;
    public var paymentTransType:int;

    public function PetUpgradeRequest(_arg1:uint, _arg2:Function) {
        this.slotObject = new SlotObjectData();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeByte(this.petTransType);
        _arg1.writeInt(this.PIDOne);
        _arg1.writeInt(this.PIDTwo);
        _arg1.writeInt(this.objectId);
        this.slotObject.writeToOutput(_arg1);
        _arg1.writeByte(this.paymentTransType);
    }


}
}
