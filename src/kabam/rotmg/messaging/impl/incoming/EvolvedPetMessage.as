package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class EvolvedPetMessage extends IncomingMessage {

    public var petID:int;
    public var initialSkin:int;
    public var finalSkin:int;

    public function EvolvedPetMessage(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.petID = _arg1.readInt();
        this.initialSkin = _arg1.readInt();
        this.finalSkin = _arg1.readInt();
    }


}
}
