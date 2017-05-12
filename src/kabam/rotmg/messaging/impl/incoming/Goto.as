package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class Goto extends IncomingMessage {

    public var objectId_:int;
    public var pos_:WorldPosData;

    public function Goto(_arg1:uint, _arg2:Function) {
        this.pos_ = new WorldPosData();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.objectId_ = _arg1.readInt();
        this.pos_.parseFromInput(_arg1);
    }

    override public function toString():String {
        return (formatToString("GOTO", "objectId_", "pos_"));
    }


}
}
