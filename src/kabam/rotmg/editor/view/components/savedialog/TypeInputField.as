package kabam.rotmg.editor.view.components.savedialog {
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;

public class TypeInputField extends Sprite {

    public static const HEIGHT:int = 88;

    public var nameText_:BaseSimpleText;
    public var typeDropDown_:TypeDropDown;

    public function TypeInputField(_arg_1:Vector.<int>, _arg_2:int) {
        this.typeDropDown_ = new TypeDropDown(_arg_1);
        this.typeDropDown_.setType(_arg_2);
        this.typeDropDown_.x = 80;
        addChild(this.typeDropDown_);
        this.nameText_ = new BaseSimpleText(18, 0xB3B3B3, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.text = "Type: ";
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.nameText_.y = ((this.typeDropDown_.height / 2) - (this.nameText_.height / 2));
        addChild(this.nameText_);
    }

    public function getType():int {
        return (this.typeDropDown_.getType());
    }


}
}
