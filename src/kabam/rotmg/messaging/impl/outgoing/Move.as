package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.MoveRecord;
import kabam.rotmg.messaging.impl.data.WorldPosData;

public class Move extends OutgoingMessage {

    public var objectId_:int;
    public var tickId_:int;
    public var time_:int;
    public var newPosition_:WorldPosData;
    public var records_:Vector.<MoveRecord>;

    public function Move(_arg1:uint, _arg2:Function) {
        this.newPosition_ = new WorldPosData();
        this.records_ = new Vector.<MoveRecord>();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.objectId_);
        _arg1.writeInt(this.tickId_);
        _arg1.writeInt(this.time_);
        this.newPosition_.writeToOutput(_arg1);
        _arg1.writeShort(this.records_.length);
        var _local2:int;
        while (_local2 < this.records_.length) {
            this.records_[_local2].writeToOutput(_arg1);
            _local2++;
        }
    }

    override public function toString():String {
        return (formatToString("MOVE", "objectId_", "tickId_", "time_", "newPosition_", "records_"));
    }


}
}
