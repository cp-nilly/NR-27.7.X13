package kabam.rotmg.ui.view.components.dropdown {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class LocalizedDropDownItem extends Sprite {

    public var w_:int;
    public var h_:int;
    private var name_:String;
    private var nameText_:TextFieldDisplayConcrete;
    private var nameLineBuilder_:LineBuilder;

    public function LocalizedDropDownItem(_arg1:String, _arg2:int, _arg3:int) {
        this.nameLineBuilder_ = new LineBuilder();
        super();
        this.w_ = _arg2;
        this.h_ = _arg3;
        this.name_ = _arg1;
        mouseChildren = false;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
        this.nameText_.setStringBuilder(this.nameLineBuilder_.setParams(_arg1));
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.drawBackground(0x363636);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    public function getTextChanged():Signal {
        return (this.nameText_.textChanged);
    }

    public function getValue():String {
        return (this.name_);
    }

    public function setValue(_arg1:String):void {
        this.name_ = _arg1;
        this.nameText_.setStringBuilder(this.nameLineBuilder_.setParams(_arg1));
    }

    public function setWidth(_arg1:int):void {
        this.w_ = _arg1;
        this.nameText_.x = ((this.w_ / 2) - (this.nameText_.width / 2));
        this.nameText_.y = ((this.h_ / 2) - (this.nameText_.height / 2));
        this.drawBackground(0x363636);
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        this.drawBackground(0x565656);
    }

    private function onMouseOut(_arg1:MouseEvent):void {
        this.drawBackground(0x363636);
    }

    private function drawBackground(_arg1:uint):void {
        graphics.clear();
        graphics.lineStyle(2, 0x545454);
        graphics.beginFill(_arg1, 1);
        graphics.drawRect(0, 0, this.w_, this.h_);
        graphics.endFill();
        graphics.lineStyle();
    }


}
}
