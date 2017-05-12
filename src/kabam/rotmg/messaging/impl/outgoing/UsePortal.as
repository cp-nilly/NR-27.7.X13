package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class UsePortal extends OutgoingMessage {

    public var objectId_:int;

    public function UsePortal(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.objectId_);
    }

    override public function toString():String {
        return (formatToString("USEPORTAL", "objectId_"));
    }


}
}
