package kabam.rotmg.editor.view.components.savedialog {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class TypeDropDown extends Sprite {

    public var items_:Vector.<TypeDropDownItem>;
    public var selected_:TypeDropDownItem;

    public function TypeDropDown(_arg_1:Vector.<int>) {
        var _local_2:int;
        this.items_ = new Vector.<TypeDropDownItem>();
        super();
        for each (_local_2 in _arg_1) {
            this.addItem(new TypeDropDownItem(_local_2));
        }
        this.setSelected(this.items_[0]);
    }

    public function setType(_arg_1:int):void {
        var _local_2:TypeDropDownItem;
        for each (_local_2 in this.items_) {
            if (_local_2.type_ == _arg_1) {
                this.setSelected(_local_2);
            }
        }
    }

    public function getType():int {
        return (this.selected_.type_);
    }

    private function addItem(_arg_1:TypeDropDownItem):void {
        this.items_.push(_arg_1);
    }

    private function removeSelected():void {
        if (this.selected_ != null) {
            if (contains(this.selected_)) {
                removeChild(this.selected_);
            }
            this.selected_.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
    }

    private function setSelected(_arg_1:TypeDropDownItem):void {
        this.removeSelected();
        this.selected_ = _arg_1;
        this.selected_.y = 0;
        addChild(this.selected_);
        this.selected_.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        if (this.items_.length == 1) {
            return;
        }
        this.removeSelected();
        this.showAll();
    }

    private function showAll():void {
        var _local_3:TypeDropDownItem;
        var _local_1:int;
        var _local_2:int;
        while (_local_2 < this.items_.length) {
            _local_3 = this.items_[_local_2];
            _local_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onSelect);
            _local_3.y = _local_1;
            addChild(_local_3);
            _local_1 = (_local_1 + TypeDropDownItem.HEIGHT);
            _local_2++;
        }
    }

    private function hideAll():void {
        var _local_2:TypeDropDownItem;
        var _local_1:int;
        while (_local_1 < this.items_.length) {
            _local_2 = this.items_[_local_1];
            _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onSelect);
            removeChild(_local_2);
            _local_1++;
        }
    }

    private function onSelect(_arg_1:MouseEvent):void {
        this.hideAll();
        this.setSelected((_arg_1.target as TypeDropDownItem));
        dispatchEvent(new Event(Event.CHANGE));
    }


}
}
