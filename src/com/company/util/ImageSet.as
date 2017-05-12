package com.company.util {
import flash.display.BitmapData;

public class ImageSet {

    public var images_:Vector.<BitmapData>;

    public function ImageSet() {
        this.images_ = new Vector.<BitmapData>();
    }

    public function add(_arg1:BitmapData):void {
        this.images_.push(_arg1);
    }

    public function random():BitmapData {
        return (this.images_[int((Math.random() * this.images_.length))]);
    }

    public function addFromBitmapData(_arg1:BitmapData, _arg2:int, _arg3:int):void {
        var _local7:int;
        var _local4:int = (_arg1.width / _arg2);
        var _local5:int = (_arg1.height / _arg3);
        var _local6:int;
        while (_local6 < _local5) {
            _local7 = 0;
            while (_local7 < _local4) {
                this.images_.push(BitmapUtil.cropToBitmapData(_arg1, (_local7 * _arg2), (_local6 * _arg3), _arg2, _arg3));
                _local7++;
            }
            _local6++;
        }
    }


}
}
