package kabam.rotmg.editor.view.components.savedialog {
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.editor.view.components.PictureType;

public class TypeDropDownItem extends Sprite {

    public static const WIDTH:int = 260;
    public static const HEIGHT:int = 44;

    private var nameText_:BaseSimpleText;
    private var examplesText_:BaseSimpleText;
    public var type_:int = -1;

    public function TypeDropDownItem(_arg_1:int) {
        this.type_ = _arg_1;
        this.nameText_ = new BaseSimpleText(16, 0xB3B3B3, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.text = (((_arg_1) == PictureType.INVALID) ? "Select Type" : PictureType.TYPES[_arg_1].name_);
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.nameText_.x = ((WIDTH / 2) - (this.nameText_.width / 2));
        this.nameText_.y = 2;
        addChild(this.nameText_);
        var _local_2:String = (((_arg_1) == PictureType.INVALID) ? null : PictureType.TYPES[_arg_1].name_);
        if (_local_2 != null) {
            this.examplesText_ = new BaseSimpleText(14, 0xB3B3B3, false, 0, 0);
            this.examplesText_.text = PictureType.TYPES[_arg_1].examples_;
            this.examplesText_.updateMetrics();
            this.examplesText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.examplesText_.x = ((WIDTH / 2) - (this.examplesText_.width / 2));
            this.examplesText_.y = 20;
            addChild(this.examplesText_);
        }
        else {
            this.nameText_.y = ((HEIGHT / 2) - (this.nameText_.height / 2));
        }
        this.drawBackground(0x363636);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.drawBackground(0x565656);
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.drawBackground(0x363636);
    }

    private function drawBackground(_arg_1:uint):void {
        graphics.clear();
        graphics.lineStyle(1, 0xB3B3B3);
        graphics.beginFill(_arg_1, 1);
        graphics.drawRect(0, 0, WIDTH, HEIGHT);
        graphics.endFill();
        graphics.lineStyle();
    }


}
}
