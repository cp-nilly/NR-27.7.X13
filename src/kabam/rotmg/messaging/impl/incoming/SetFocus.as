/**
 * Created by cp-nilly on 6/9/2017.
 */
package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class SetFocus extends IncomingMessage {
    public var objectId_:int;

    public function SetFocus(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.objectId_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("SET_FOCUS", "objectId_"));
    }


}
}

