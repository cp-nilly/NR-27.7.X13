package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

public class SetCondition extends OutgoingMessage {

    public var conditionEffect_:uint;
    public var conditionDuration_:Number;

    public function SetCondition(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeByte(this.conditionEffect_);
        _arg1.writeFloat(this.conditionDuration_);
    }

    override public function toString():String {
        return (formatToString("SETCONDITION", "conditionEffect_", "conditionDuration_"));
    }


}
}
