package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class ChooseName extends OutgoingMessage {

    public var name_:String;

    public function ChooseName(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeUTF(this.name_);
    }

    override public function toString():String {
        return (formatToString("CHOOSENAME", "name_"));
    }


}
}
