package kabam.rotmg.messaging.impl.incoming {
import com.company.assembleegameclient.util.FreeList;

import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.TradeItem;

public class TradeStart extends IncomingMessage {

    public var myItems_:Vector.<TradeItem>;
    public var yourName_:String;
    public var yourItems_:Vector.<TradeItem>;

    public function TradeStart(_arg1:uint, _arg2:Function) {
        this.myItems_ = new Vector.<TradeItem>();
        this.yourItems_ = new Vector.<TradeItem>();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        var _local2:int;
        var _local3:int = _arg1.readShort();
        _local2 = _local3;
        while (_local2 < this.myItems_.length) {
            FreeList.deleteObject(this.myItems_[_local2]);
            _local2++;
        }
        this.myItems_.length = Math.min(_local3, this.myItems_.length);
        while (this.myItems_.length < _local3) {
            this.myItems_.push((FreeList.newObject(TradeItem) as TradeItem));
        }
        _local2 = 0;
        while (_local2 < _local3) {
            this.myItems_[_local2].parseFromInput(_arg1);
            _local2++;
        }
        this.yourName_ = _arg1.readUTF();
        _local3 = _arg1.readShort();
        _local2 = _local3;
        while (_local2 < this.yourItems_.length) {
            FreeList.deleteObject(this.yourItems_[_local2]);
            _local2++;
        }
        this.yourItems_.length = Math.min(_local3, this.yourItems_.length);
        while (this.yourItems_.length < _local3) {
            this.yourItems_.push((FreeList.newObject(TradeItem) as TradeItem));
        }
        _local2 = 0;
        while (_local2 < _local3) {
            this.yourItems_[_local2].parseFromInput(_arg1);
            _local2++;
        }
    }

    override public function toString():String {
        return (formatToString("TRADESTART", "myItems_", "yourName_", "yourItems_"));
    }


}
}
