package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.ByteArray;
import flash.utils.IDataOutput;

public class Hello extends OutgoingMessage {

    public var buildVersion_:String;
    public var gameId_:int = 0;
    public var guid_:String;
    public var password_:String;
    public var secret_:String;
    public var keyTime_:int = 0;
    public var key_:ByteArray;
    public var mapJSON_:String;

    public function Hello(_arg1:uint, _arg2:Function) {
        this.buildVersion_ = new String();
        this.guid_ = new String();
        this.password_ = new String();
        this.secret_ = new String();
        this.key_ = new ByteArray();
        this.mapJSON_ = new String();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeUTF(this.buildVersion_);
        _arg1.writeInt(this.gameId_);
        _arg1.writeUTF(this.guid_);
        _arg1.writeUTF(this.password_);
        _arg1.writeUTF(this.secret_);
        _arg1.writeInt(this.keyTime_);
        _arg1.writeShort(this.key_.length);
        _arg1.writeBytes(this.key_);
        _arg1.writeInt(this.mapJSON_.length);
        _arg1.writeUTFBytes(this.mapJSON_);
    }

    override public function toString():String {
        return (formatToString("HELLO", "buildVersion_", "gameId_", "guid_", "password_", "secret_"));
    }


}
}
