package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class GlobalNotification extends IncomingMessage {

    public var type:int;
    public var text:String;

    public function GlobalNotification(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.type = _arg1.readInt();
        this.text = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("GLOBAL_NOTIFICATION", "type", "text"));
    }


}
}
