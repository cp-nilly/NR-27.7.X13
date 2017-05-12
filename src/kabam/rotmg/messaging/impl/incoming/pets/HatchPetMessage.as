package kabam.rotmg.messaging.impl.incoming.pets {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class HatchPetMessage extends IncomingMessage {

    public var petName:String;
    public var petSkin:int;

    public function HatchPetMessage(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.petName = _arg1.readUTF();
        this.petSkin = _arg1.readInt();
    }


}
}
