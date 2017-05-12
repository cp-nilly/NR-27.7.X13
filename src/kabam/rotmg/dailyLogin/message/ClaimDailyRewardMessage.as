package kabam.rotmg.dailyLogin.message {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class ClaimDailyRewardMessage extends OutgoingMessage {

    public var claimKey:String;
    public var type:String;

    public function ClaimDailyRewardMessage(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeUTF(this.claimKey);
        _arg1.writeUTF(this.type);
    }

    override public function toString():String {
        return ("type");
    }


}
}
