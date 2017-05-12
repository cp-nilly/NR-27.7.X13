package kabam.rotmg.messaging.impl.data {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class ObjectStatusData {

    public var objectId_:int;
    public var pos_:WorldPosData;
    public var stats_:Vector.<StatData>;

    public function ObjectStatusData() {
        this.pos_ = new WorldPosData();
        this.stats_ = new Vector.<StatData>();
        super();
    }

    public function parseFromInput(_arg1:IDataInput):void {
        var _local3:int;
        this.objectId_ = _arg1.readInt();
        this.pos_.parseFromInput(_arg1);
        var _local2:int = _arg1.readShort();
        _local3 = _local2;
        while (_local3 < this.stats_.length) {
            FreeList.deleteObject(this.stats_[_local3]);
            _local3++;
        }
        this.stats_.length = Math.min(_local2, this.stats_.length);
        while (this.stats_.length < _local2) {
            this.stats_.push((FreeList.newObject(StatData) as StatData));
        }
        _local3 = 0;
        while (_local3 < _local2) {
            this.stats_[_local3].parseFromInput(_arg1);
            _local3++;
        }
    }

    public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.objectId_);
        this.pos_.writeToOutput(_arg1);
        _arg1.writeShort(this.stats_.length);
        var _local2:int;
        while (_local2 < this.stats_.length) {
            this.stats_[_local2].writeToOutput(_arg1);
            _local2++;
        }
    }

    public function toString():String {
        return (((((("objectId_: " + this.objectId_) + " pos_: ") + this.pos_) + " stats_: ") + this.stats_));
    }


}
}
