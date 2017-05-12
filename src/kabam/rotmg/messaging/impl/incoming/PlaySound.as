package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class PlaySound extends IncomingMessage {

    public var ownerId_:int;
    public var soundId_:int;

    public function PlaySound(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.ownerId_ = _arg1.readInt();
        this.soundId_ = _arg1.readUnsignedByte();
    }

    override public function toString():String {
        return (formatToString("PLAYSOUND", "ownerId_", "soundId_"));
    }


}
}
