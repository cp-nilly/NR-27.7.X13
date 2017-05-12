package {
import flash.display.BitmapData;

public class BitmapDataSpy extends BitmapData {

    public function BitmapDataSpy(_arg1:int, _arg2:int, _arg3:Boolean = true, _arg4:uint = 0) {
        super(_arg1, _arg2, _arg3, _arg4);
    }

    override public function clone():BitmapData {
        return (super.clone());
    }


}
}
