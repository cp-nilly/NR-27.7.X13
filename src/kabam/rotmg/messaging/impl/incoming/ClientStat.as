package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class ClientStat extends IncomingMessage {

    public var name_:String;
    public var value_:int;

    public function ClientStat(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.name_ = _arg1.readUTF();
        this.value_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("CLIENTSTAT", "name_", "value_"));
    }


}
}
