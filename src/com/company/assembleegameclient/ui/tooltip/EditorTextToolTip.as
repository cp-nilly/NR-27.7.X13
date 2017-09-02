package com.company.assembleegameclient.ui.tooltip {
import com.company.ui.BaseSimpleText;
import flash.filters.DropShadowFilter;

public class EditorTextToolTip extends ToolTip{

    public var titleText_:BaseSimpleText;
    public var tipText_:BaseSimpleText;

    public function EditorTextToolTip(_arg1:uint, _arg2:uint, _arg3:String, _arg4:String, _arg5:int) {
        super(_arg1, 1, _arg2, 1);
        if (_arg3 != null) {
            this.titleText_ = new BaseSimpleText(20, 0xFFFFFF, false, _arg5, 0);
            this.titleText_.setBold(true);
            this.titleText_.wordWrap = true;
            this.titleText_.text = _arg3;
            this.titleText_.updateMetrics();
            this.titleText_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.titleText_);
        }
        if (_arg4 != null) {
            this.tipText_ = new BaseSimpleText(14, 0xB3B3B3, false, _arg5, 0);
            this.tipText_.wordWrap = true;
            this.tipText_.y = (((this.titleText_) != null) ? (this.titleText_.height + 8) : 0);
            this.tipText_.text = _arg4;
            this.tipText_.useTextDimensions();
            this.tipText_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.tipText_);
        }
    }

}
}
