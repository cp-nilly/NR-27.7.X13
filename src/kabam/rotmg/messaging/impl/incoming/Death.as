package kabam.rotmg.messaging.impl.incoming {
import flash.display.BitmapData;
import flash.utils.IDataInput;

public class Death extends IncomingMessage {

    public var accountId_:String;
    public var charId_:int;
    public var killedBy_:String;
    public var zombieId:int;
    public var zombieType:int;
    public var isZombie:Boolean;
    public var background:BitmapData;

    public function Death(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    public function disposeBackground():void {
        ((this.background) && (this.background.dispose()));
        this.background = null;
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.accountId_ = _arg1.readUTF();
        this.charId_ = _arg1.readInt();
        this.killedBy_ = _arg1.readUTF();
        this.zombieType = _arg1.readInt();
        this.zombieId = _arg1.readInt();
        this.isZombie = !((this.zombieId == -1));
    }

    override public function toString():String {
        return (formatToString("DEATH", "accountId_", "charId_", "killedBy_"));
    }


}
}
