package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.GameObject;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class PortraitToolTip extends ToolTip {

    private var portrait_:Bitmap;

    public function PortraitToolTip(_arg1:GameObject) {
        super(6036765, 1, 16549442, 1, false);
        this.portrait_ = new Bitmap();
        this.portrait_.x = 0;
        this.portrait_.y = 0;
        var _local2:BitmapData = _arg1.getPortrait();
        _local2 = BitmapUtil.cropToBitmapData(_local2, 10, 10, (_local2.width - 20), (_local2.height - 20));
        this.portrait_.bitmapData = _local2;
        addChild(this.portrait_);
        filters = [];
    }

}
}
