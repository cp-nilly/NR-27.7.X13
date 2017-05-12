package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class TradeDone extends IncomingMessage {

    public static const TRADE_SUCCESSFUL:int = 0;
    public static const PLAYER_CANCELED:int = 1;

    public var code_:int;
    public var description_:String;

    public function TradeDone(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.code_ = _arg1.readInt();
        this.description_ = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("TRADEDONE", "code_", "description_"));
    }


}
}
