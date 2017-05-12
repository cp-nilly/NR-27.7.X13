package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class QuestRedeemResponse extends IncomingMessage {

    public var ok:Boolean;
    public var message:String;

    public function QuestRedeemResponse(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.ok = _arg1.readBoolean();
        this.message = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("QUESTREDEEMRESPONSE", "ok", "message"));
    }


}
}
