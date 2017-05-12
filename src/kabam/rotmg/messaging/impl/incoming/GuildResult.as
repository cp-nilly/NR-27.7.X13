package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class GuildResult extends IncomingMessage {

    public var success_:Boolean;
    public var lineBuilderJSON:String;

    public function GuildResult(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.success_ = _arg1.readBoolean();
        this.lineBuilderJSON = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("CREATEGUILDRESULT", "success_", "lineBuilderJSON"));
    }


}
}
