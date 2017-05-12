package com.company.assembleegameclient.ui.tooltip {
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class TextToolTip extends ToolTip {

    public var titleText_:TextFieldDisplayConcrete;
    public var tipText_:TextFieldDisplayConcrete;

    public function TextToolTip(_arg1:uint, _arg2:uint, _arg3:String, _arg4:String, _arg5:int, _arg6:Object = null) {
        super(_arg1, 1, _arg2, 1);
        if (_arg3 != null) {
            this.titleText_ = new TextFieldDisplayConcrete().setSize(20).setColor(0xFFFFFF);
            this.configureTextFieldDisplayAndAddChild(this.titleText_, _arg5, _arg3);
        }
        if (_arg4 != null) {
            this.tipText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xB3B3B3);
            this.configureTextFieldDisplayAndAddChild(this.tipText_, _arg5, _arg4, _arg6);
        }
    }

    override protected function alignUI():void {
        this.tipText_.y = ((this.titleText_) ? (this.titleText_.height + 8) : 0);
    }

    public function configureTextFieldDisplayAndAddChild(_arg1:TextFieldDisplayConcrete, _arg2:int, _arg3:String, _arg4:Object = null):void {
        _arg1.setAutoSize(TextFieldAutoSize.LEFT);
        _arg1.setWordWrap(true).setTextWidth(_arg2);
        _arg1.setStringBuilder(new LineBuilder().setParams(_arg3, _arg4));
        _arg1.filters = [new DropShadowFilter(0, 0, 0)];
        waiter.push(_arg1.textChanged);
        addChild(_arg1);
    }

    public function setTitle(_arg1:StringBuilder):void {
        this.titleText_.setStringBuilder(_arg1);
        draw();
    }

    public function setText(_arg1:StringBuilder):void {
        this.tipText_.setStringBuilder(_arg1);
        draw();
    }


}
}
