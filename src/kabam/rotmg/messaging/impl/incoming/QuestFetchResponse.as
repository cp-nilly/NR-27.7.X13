package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class QuestFetchResponse extends IncomingMessage {

    public var tier:int;
    public var goal:String;
    public var description:String;
    public var image:String;

    public function QuestFetchResponse(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.tier = _arg1.readInt();
        this.goal = _arg1.readUTF();
        this.description = _arg1.readUTF();
        this.image = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("QUESTFETCHRESPONSE", "tier", "goal", "description", "image"));
    }


}
}
