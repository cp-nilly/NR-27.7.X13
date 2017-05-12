package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class EnemyHit extends OutgoingMessage {

    public var time_:int;
    public var bulletId_:uint;
    public var targetId_:int;
    public var kill_:Boolean;

    public function EnemyHit(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.time_);
        _arg1.writeByte(this.bulletId_);
        _arg1.writeInt(this.targetId_);
        _arg1.writeBoolean(this.kill_);
    }

    override public function toString():String {
        return (formatToString("ENEMYHIT", "time_", "bulletId_", "targetId_", "kill_"));
    }


}
}
