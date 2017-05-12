package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class VerifyEmail extends IncomingMessage {

    public function VerifyEmail(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
    }

    override public function toString():String {
        return (formatToString("VERIFYEMAIL", "asdf", "asdf"));
    }


}
}
