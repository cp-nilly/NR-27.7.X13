package com.company.assembleegameclient.ui {
import flash.events.MouseEvent;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TextButtonBase extends BackgroundFilledText {

    public function TextButtonBase(_arg1:int) {
        super(_arg1);
    }

    protected function initText():void {
        centerTextAndDrawButton();
        this.draw();
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    public function setText(_arg1:String):void {
        text_.setStringBuilder(new LineBuilder().setParams(_arg1));
    }

    public function setEnabled(_arg1:Boolean):void {
        if (_arg1 == mouseEnabled) {
            return;
        }
        mouseEnabled = _arg1;
        graphicsData_[0] = ((_arg1) ? enabledFill_ : disabledFill_);
        this.draw();
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        enabledFill_.color = 16768133;
        this.draw();
    }

    private function onRollOut(_arg1:MouseEvent):void {
        enabledFill_.color = 0xFFFFFF;
        this.draw();
    }

    private function draw():void {
        graphics.clear();
        graphics.drawGraphicsData(graphicsData_);
    }


}
}
