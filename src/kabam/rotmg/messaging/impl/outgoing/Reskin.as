package kabam.rotmg.messaging.impl.outgoing {
import com.company.assembleegameclient.objects.Player;

import flash.utils.IDataOutput;

public class Reskin extends OutgoingMessage {

    public var skinID:int;
    public var player:Player;

    public function Reskin(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.skinID);
    }

    override public function consume():void {
        super.consume();
        this.player = null;
    }

    override public function toString():String {
        return (formatToString("RESKIN", "skinID"));
    }


}
}
