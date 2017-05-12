package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class AoeAck extends OutgoingMessage {

    public var time_:int;
    public var position_:WorldPosData;

    public function AoeAck(_arg1:uint, _arg2:Function) {
        this.position_ = new WorldPosData();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.time_);
        this.position_.writeToOutput(_arg1);
    }

    override public function toString():String {
        return (formatToString("AOEACK", "time_", "position_"));
    }


}
}
