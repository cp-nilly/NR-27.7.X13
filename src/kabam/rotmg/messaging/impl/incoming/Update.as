package kabam.rotmg.messaging.impl.incoming {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.GroundTileData;
import kabam.rotmg.messaging.impl.data.ObjectData;

public class Update extends IncomingMessage {

    public var tiles_:Vector.<GroundTileData>;
    public var newObjs_:Vector.<ObjectData>;
    public var drops_:Vector.<int>;

    public function Update(_arg1:uint, _arg2:Function) {
        this.tiles_ = new Vector.<GroundTileData>();
        this.newObjs_ = new Vector.<ObjectData>();
        this.drops_ = new Vector.<int>();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        var _local2:int;
        var _local3:int = _arg1.readShort();
        _local2 = _local3;
        while (_local2 < this.tiles_.length) {
            FreeList.deleteObject(this.tiles_[_local2]);
            _local2++;
        }
        this.tiles_.length = Math.min(_local3, this.tiles_.length);
        while (this.tiles_.length < _local3) {
            this.tiles_.push((FreeList.newObject(GroundTileData) as GroundTileData));
        }
        _local2 = 0;
        while (_local2 < _local3) {
            this.tiles_[_local2].parseFromInput(_arg1);
            _local2++;
        }
        this.newObjs_.length = 0;
        _local3 = _arg1.readShort();
        _local2 = _local3;
        while (_local2 < this.newObjs_.length) {
            FreeList.deleteObject(this.newObjs_[_local2]);
            _local2++;
        }
        this.newObjs_.length = Math.min(_local3, this.newObjs_.length);
        while (this.newObjs_.length < _local3) {
            this.newObjs_.push((FreeList.newObject(ObjectData) as ObjectData));
        }
        _local2 = 0;
        while (_local2 < _local3) {
            this.newObjs_[_local2].parseFromInput(_arg1);
            _local2++;
        }
        this.drops_.length = 0;
        var _local4:int = _arg1.readShort();
        _local2 = 0;
        while (_local2 < _local4) {
            this.drops_.push(_arg1.readInt());
            _local2++;
        }
    }

    override public function toString():String {
        return (formatToString("UPDATE", "tiles_", "newObjs_", "drops_"));
    }


}
}
