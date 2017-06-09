package kabam.rotmg.messaging.impl.incoming.arena {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

public class ImminentArenaWave extends IncomingMessage {

    public var currentRuntime:int;
    public var wave:int;

    public function ImminentArenaWave(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.currentRuntime = _arg1.readInt();
        this.wave = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("IMMINENTARENAWAVE", "currentRuntime"));
    }


}
}
