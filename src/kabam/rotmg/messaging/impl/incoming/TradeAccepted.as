package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class TradeAccepted extends IncomingMessage {

    public var myOffer_:Vector.<Boolean>;
    public var yourOffer_:Vector.<Boolean>;

    public function TradeAccepted(_arg1:uint, _arg2:Function) {
        this.myOffer_ = new Vector.<Boolean>();
        this.yourOffer_ = new Vector.<Boolean>();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        var _local2:int;
        this.myOffer_.length = 0;
        var _local3:int = _arg1.readShort();
        _local2 = 0;
        while (_local2 < _local3) {
            this.myOffer_.push(_arg1.readBoolean());
            _local2++;
        }
        this.yourOffer_.length = 0;
        _local3 = _arg1.readShort();
        _local2 = 0;
        while (_local2 < _local3) {
            this.yourOffer_.push(_arg1.readBoolean());
            _local2++;
        }
    }

    override public function toString():String {
        return (formatToString("TRADEACCEPTED", "myOffer_", "yourOffer_"));
    }


}
}
