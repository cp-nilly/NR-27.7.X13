package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class Create extends OutgoingMessage {

    public var classType:int;
    public var skinType:int;

    public function Create(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeShort(this.classType);
        _arg1.writeShort(this.skinType);
    }

    override public function toString():String {
        return (formatToString("CREATE", "classType"));
    }


}
}
