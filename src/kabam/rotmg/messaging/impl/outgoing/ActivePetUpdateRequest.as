package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class ActivePetUpdateRequest extends OutgoingMessage {

    public var commandtype:uint;
    public var instanceid:uint;

    public function ActivePetUpdateRequest(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeByte(this.commandtype);
        _arg1.writeInt(this.instanceid);
    }


}
}
