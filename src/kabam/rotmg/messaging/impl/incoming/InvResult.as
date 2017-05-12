package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class InvResult extends IncomingMessage {

    public var result_:int;

    public function InvResult(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.result_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("INVRESULT", "result_"));
    }


}
}
