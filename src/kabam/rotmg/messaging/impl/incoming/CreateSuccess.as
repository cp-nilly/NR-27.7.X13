package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class CreateSuccess extends IncomingMessage {

    public var objectId_:int;
    public var charId_:int;

    public function CreateSuccess(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.objectId_ = _arg1.readInt();
        this.charId_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("CREATE_SUCCESS", "objectId_", "charId_"));
    }


}
}
