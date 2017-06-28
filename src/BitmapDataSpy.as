package {
import flash.display.BitmapData;

public class BitmapDataSpy extends BitmapData {

    public function BitmapDataSpy(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0) {
        super(width, height, transparent, fillColor);
    }

    override public function clone():BitmapData {
        return super.clone();
    }


}
}
