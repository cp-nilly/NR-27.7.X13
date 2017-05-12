package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class ServerPlayerShoot extends IncomingMessage {

    public var bulletId_:uint;
    public var ownerId_:int;
    public var containerType_:int;
    public var startingPos_:WorldPosData;
    public var angle_:Number;
    public var damage_:int;

    public function ServerPlayerShoot(_arg1:uint, _arg2:Function) {
        this.startingPos_ = new WorldPosData();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.bulletId_ = _arg1.readUnsignedByte();
        this.ownerId_ = _arg1.readInt();
        this.containerType_ = _arg1.readInt();
        this.startingPos_.parseFromInput(_arg1);
        this.angle_ = _arg1.readFloat();
        this.damage_ = _arg1.readShort();
    }

    override public function toString():String {
        return (formatToString("SHOOT", "bulletId_", "ownerId_", "containerType_", "startingPos_", "angle_", "damage_"));
    }


}
}
