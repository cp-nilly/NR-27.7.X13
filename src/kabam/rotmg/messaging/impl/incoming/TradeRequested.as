package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class TradeRequested extends IncomingMessage {

    public var name_:String;

    public function TradeRequested(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.name_ = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("TRADEREQUESTED", "name_"));
    }


}
}
