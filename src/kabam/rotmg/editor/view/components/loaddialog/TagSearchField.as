package kabam.rotmg.editor.view.components.loaddialog {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.FocusEvent;
import flash.filters.DropShadowFilter;

public class TagSearchField extends Sprite {

    public static const WIDTH:int = 200;
    public static const HEIGHT:int = 30;

    public var inputText_:BaseSimpleText;
    public var instructionsText_:BaseSimpleText;

    public function TagSearchField() {
        this.inputText_ = new BaseSimpleText(16, 0xB3B3B3, true, WIDTH, 30);
        this.inputText_.border = false;
        this.inputText_.maxChars = 0x0100;
        this.inputText_.restrict = "a-z0-9 ,";
        this.inputText_.updateMetrics();
        this.inputText_.x = 2;
        addChild(this.inputText_);
        graphics.lineStyle(2, 0x454545, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(0x333333, 1);
        graphics.drawRect(0, -2, WIDTH, 30);
        graphics.endFill();
        graphics.lineStyle();
        this.inputText_.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        this.inputText_.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
        this.instructionsText_ = new BaseSimpleText(14, 0x939393, false, 200, 30);
        this.instructionsText_.htmlText = '<p align="center">tags (comma-separated)</p>';
        this.instructionsText_.updateMetrics();
        this.instructionsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 1)];
        this.instructionsText_.y = (((HEIGHT / 2) - (this.instructionsText_.height / 2)) + 2);
        addChild(this.instructionsText_);
    }

    public function setText(_arg_1:String):void {
        this.inputText_.text = _arg_1;
        removeChild(this.instructionsText_);
    }

    public function getText():String {
        return (this.inputText_.text);
    }

    private function onFocusIn(_arg_1:FocusEvent):void {
        if (contains(this.instructionsText_)) {
            removeChild(this.instructionsText_);
        }
    }

    private function onFocusOut(_arg_1:FocusEvent):void {
        if (((!(contains(this.instructionsText_))) && ((this.inputText_.text == "")))) {
            addChild(this.instructionsText_);
        }
    }


}
}
