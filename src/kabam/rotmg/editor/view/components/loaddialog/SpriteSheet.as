package kabam.rotmg.editor.view.components.loaddialog {
import com.adobe.images.PNGEncoder;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.utils.ByteArray;

public class SpriteSheet {

    private static const WIDTH:int = 128;
    private static const HEIGHT:int = 0x0100;

    public var bitmapDatas_:Vector.<BitmapData>;

    public function SpriteSheet() {
        this.bitmapDatas_ = new Vector.<BitmapData>();
        super();
    }

    public function addBitmapData(_arg_1:BitmapData):void {
        this.bitmapDatas_.push(_arg_1);
    }

    public function generatePNG():ByteArray {
        var _local_4:BitmapData;
        var _local_1:BitmapData = new BitmapDataSpy(WIDTH, HEIGHT, true, 0);
        var _local_2:Point = new Point(0, 0);
        var _local_3:int;
        for each (_local_4 in this.bitmapDatas_) {
            if ((_local_2.x + _local_4.width) > WIDTH) {
                _local_2.y = (_local_2.y + _local_3);
                _local_2.x = 0;
                _local_3 = 0;
            }
            if ((_local_2.y + _local_4.height) > HEIGHT) break;
            _local_1.copyPixels(_local_4, _local_4.rect, _local_2);
            _local_2.x = (_local_2.x + _local_4.width);
            if (_local_4.height > _local_3) {
                _local_3 = _local_4.height;
            }
        }
        return (PNGEncoder.encode(_local_1));
    }


}
}
