package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class KeyInfoRequest extends OutgoingMessage {

    public var itemType_:int;

    public function KeyInfoRequest(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.itemType_);
    }

    override public function toString():String {
        return (formatToString("ITEMTYPE", "itemType_"));
    }


}
}
