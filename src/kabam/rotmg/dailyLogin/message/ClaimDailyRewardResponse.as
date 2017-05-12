package kabam.rotmg.dailyLogin.message {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class ClaimDailyRewardResponse extends IncomingMessage {

    public var itemId:int;
    public var quantity:int;
    public var gold:int;

    public function ClaimDailyRewardResponse(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.itemId = _arg1.readInt();
        this.quantity = _arg1.readInt();
        this.gold = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("CLAIMDAILYREWARDRESPONSE", "itemId", "quantity", "gold"));
    }


}
}
