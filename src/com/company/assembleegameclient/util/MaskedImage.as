package com.company.assembleegameclient.util {
import com.company.util.BitmapUtil;

import flash.display.BitmapData;

public class MaskedImage {

    public var image_:BitmapData;
    public var mask_:BitmapData;

    public function MaskedImage(_arg1:BitmapData, _arg2:BitmapData) {
        this.image_ = _arg1;
        this.mask_ = _arg2;
    }

    public function width():int {
        return (this.image_.width);
    }

    public function height():int {
        return (this.image_.height);
    }

    public function mirror(_arg1:int = 0):MaskedImage {
        var _local2:BitmapData = BitmapUtil.mirror(this.image_, _arg1);
        var _local3:BitmapData = (((this.mask_ == null)) ? null : BitmapUtil.mirror(this.mask_, _arg1));
        return (new MaskedImage(_local2, _local3));
    }

    public function amountTransparent():Number {
        return (BitmapUtil.amountTransparent(this.image_));
    }


}
}
