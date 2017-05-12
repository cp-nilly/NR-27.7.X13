package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class Notification extends IncomingMessage {

    public var objectId_:int;
    public var message:String;
    public var color_:int;

    public function Notification(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.objectId_ = _arg1.readInt();
        this.message = _arg1.readUTF();
        this.color_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("NOTIFICATION", "objectId_", "message", "color_"));
    }


}
}
