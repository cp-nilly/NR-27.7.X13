package com.company.assembleegameclient.util {
import com.company.util.ImageSet;

import flash.display.BitmapData;

public class MaskedImageSet {

    public var images_:Vector.<MaskedImage>;

    public function MaskedImageSet() {
        this.images_ = new Vector.<MaskedImage>();
        super();
    }

    public function addFromBitmapData(_arg1:BitmapData, _arg2:BitmapData, _arg3:int, _arg4:int):void {
        var _local5:ImageSet = new ImageSet();
        _local5.addFromBitmapData(_arg1, _arg3, _arg4);
        var _local6:ImageSet;
        if (_arg2 != null) {
            _local6 = new ImageSet();
            _local6.addFromBitmapData(_arg2, _arg3, _arg4);
            if (_local5.images_.length > _local6.images_.length) {
            }
        }
        var _local7:int;
        while (_local7 < _local5.images_.length) {
            this.images_.push(new MaskedImage(_local5.images_[_local7], (((_local6 == null)) ? null : (((_local7 >= _local6.images_.length)) ? null : _local6.images_[_local7]))));
            _local7++;
        }
    }

    public function addFromMaskedImage(_arg1:MaskedImage, _arg2:int, _arg3:int):void {
        this.addFromBitmapData(_arg1.image_, _arg1.mask_, _arg2, _arg3);
    }


}
}
