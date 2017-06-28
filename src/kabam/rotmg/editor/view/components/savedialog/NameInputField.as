package kabam.rotmg.editor.view.components.savedialog {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;

public class NameInputField extends Sprite {

    public static const HEIGHT:int = 88;

    public var nameText_:BaseSimpleText;
    public var inputText_:BaseSimpleText;
    public var errorText_:BaseSimpleText;

    public function NameInputField(_arg_1:String) {
        this.nameText_ = new BaseSimpleText(18, 0xB3B3B3, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.text = "Name: ";
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.inputText_ = new BaseSimpleText(20, 0xB3B3B3, true, 260, 30);
        this.inputText_.x = 80;
        this.inputText_.border = false;
        this.inputText_.maxChars = 32;
        this.inputText_.restrict = "a-zA-Z0-9 ";
        this.inputText_.updateMetrics();
        this.inputText_.text = _arg_1;
        addChild(this.inputText_);
        graphics.lineStyle(2, 0x454545, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(0x333333, 1);
        graphics.drawRect(78, -2, 260, 30);
        graphics.endFill();
        graphics.lineStyle();
    }

    public function text():String {
        return (this.inputText_.text);
    }


}
}
