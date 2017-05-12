package kabam.rotmg.messaging.impl.data {
import flash.utils.IDataOutput;

public class MoveRecord {

    public var time_:int;
    public var x_:Number;
    public var y_:Number;

    public function MoveRecord(_arg1:int, _arg2:Number, _arg3:Number) {
        this.time_ = _arg1;
        this.x_ = _arg2;
        this.y_ = _arg3;
    }

    public function writeToOutput(_arg1:IDataOutput):void {
        _arg1.writeInt(this.time_);
        _arg1.writeFloat(this.x_);
        _arg1.writeFloat(this.y_);
    }

    public function toString():String {
        return (((((("time_: " + this.time_) + " x_: ") + this.x_) + " y_: ") + this.y_));
    }


}
}
