package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class GroundTypeToolTip extends ToolTip {

    private static const MAX_WIDTH:int = 180;

    private var titleText_:BaseSimpleText;
    private var descText_:BaseSimpleText;

    public function GroundTypeToolTip(_arg1:XML) {
        super(0x363636, 1, 0x9B9B9B, 1, true);
        this.titleText_ = new BaseSimpleText(16, 0xFFFFFF, false, (MAX_WIDTH - 4), 0);
        this.titleText_.setBold(true);
        this.titleText_.wordWrap = true;
        this.titleText_.text = String(_arg1.@id);
        this.titleText_.useTextDimensions();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.titleText_.x = 0;
        this.titleText_.y = 0;
        addChild(this.titleText_);
        var _local2 = "";
        if (_arg1.hasOwnProperty("Speed")) {
            _local2 = (_local2 + (("Speed: " + Number(_arg1.Speed).toFixed(2)) + "\n"));
        }
        else {
            _local2 = (_local2 + "Speed: 1.00\n");
        }
        if (_arg1.hasOwnProperty("NoWalk")) {
            _local2 = (_local2 + "Unwalkable\n");
        }
        if (_arg1.hasOwnProperty("Push")) {
            _local2 = (_local2 + "Push\n");
        }
        if (_arg1.hasOwnProperty("Sink")) {
            _local2 = (_local2 + "Sink\n");
        }
        if (_arg1.hasOwnProperty("Sinking")) {
            _local2 = (_local2 + "Sinking\n");
        }
        if (_arg1.hasOwnProperty("Animate")) {
            _local2 = (_local2 + "Animated\n");
        }
        if (_arg1.hasOwnProperty("RandomOffset")) {
            _local2 = (_local2 + "Randomized\n");
        }
        this.descText_ = new BaseSimpleText(14, 0xB3B3B3, false, MAX_WIDTH, 0);
        this.descText_.wordWrap = true;
        this.descText_.text = String(_local2);
        this.descText_.useTextDimensions();
        this.descText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.descText_.x = 0;
        this.descText_.y = (this.titleText_.height + 2);
        addChild(this.descText_);
    }

}
}
