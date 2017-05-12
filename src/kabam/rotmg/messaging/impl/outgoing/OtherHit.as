package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class OtherHit extends OutgoingMessage {

    public var time_:int;
    public var bulletId_:uint;
    public var objectId_:int;
    public var targetId_:int;

    public function OtherHit(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.time_);
        _arg1.writeByte(this.bulletId_);
        _arg1.writeInt(this.objectId_);
        _arg1.writeInt(this.targetId_);
    }

    override public function toString():String {
        return (formatToString("OTHERHIT", "time_", "bulletId_", "objectId_", "targetId_"));
    }


}
}
