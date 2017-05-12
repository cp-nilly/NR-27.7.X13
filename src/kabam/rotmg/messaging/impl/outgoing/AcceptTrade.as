package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class AcceptTrade extends OutgoingMessage {

    public var myOffer_:Vector.<Boolean>;
    public var yourOffer_:Vector.<Boolean>;

    public function AcceptTrade(_arg1:uint, _arg2:Function) {
        this.myOffer_ = new Vector.<Boolean>();
        this.yourOffer_ = new Vector.<Boolean>();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        var _local2:int;
        _arg1.writeShort(this.myOffer_.length);
        _local2 = 0;
        while (_local2 < this.myOffer_.length) {
            _arg1.writeBoolean(this.myOffer_[_local2]);
            _local2++;
        }
        _arg1.writeShort(this.yourOffer_.length);
        _local2 = 0;
        while (_local2 < this.yourOffer_.length) {
            _arg1.writeBoolean(this.yourOffer_[_local2]);
            _local2++;
        }
    }

    override public function toString():String {
        return (formatToString("ACCEPTTRADE", "myOffer_", "yourOffer_"));
    }


}
}
