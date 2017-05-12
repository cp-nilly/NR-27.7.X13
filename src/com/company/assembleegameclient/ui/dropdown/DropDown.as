package com.company.assembleegameclient.ui.dropdown {
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class DropDown extends Sprite {

    protected var strings_:Vector.<String>;
    protected var w_:int;
    protected var h_:int;
    protected var maxItems_:int;
    protected var labelText_:BaseSimpleText;
    protected var xOffset_:int = 0;
    protected var selected_:DropDownItem;
    protected var all_:Sprite;

    public function DropDown(_arg1:Vector.<String>, _arg2:int, _arg3:int, _arg4:String = null, _arg5:Number = 0, _arg6:int = 17) {
        this.all_ = new Sprite();
        super();
        this.strings_ = _arg1;
        this.w_ = _arg2;
        this.h_ = _arg3;
        this.maxItems_ = _arg6;
        if (_arg4 != null) {
            this.labelText_ = new BaseSimpleText(14, 0xFFFFFF, false, 0, 0);
            this.labelText_.setBold(true);
            this.labelText_.text = (_arg4 + ":");
            this.labelText_.updateMetrics();
            addChild(this.labelText_);
            this.xOffset_ = (this.labelText_.width + 5);
        }
        this.setIndex(_arg5);
    }

    public function getValue():String {
        return (this.selected_.getValue());
    }

    public function setListItems(_arg1:Vector.<String>):void {
        this.strings_ = _arg1;
    }

    public function setValue(_arg1:String):Boolean {
        var _local2:int;
        while (_local2 < this.strings_.length) {
            if (_arg1 == this.strings_[_local2]) {
                this.setIndex(_local2);
                return (true);
            }
            _local2++;
        }
        return (false);
    }

    public function setIndex(_arg1:int):void {
        if (_arg1 >= this.strings_.length) {
            _arg1 = 0;
        }
        this.setSelected(this.strings_[_arg1]);
    }

    public function getIndex():int {
        var _local1:int;
        while (_local1 < this.strings_.length) {
            if (this.selected_.getValue() == this.strings_[_local1]) {
                return (_local1);
            }
            _local1++;
        }
        return (-1);
    }

    private function setSelected(_arg1:String):void {
        var _local2:String = (((this.selected_) != null) ? this.selected_.getValue() : null);
        this.selected_ = new DropDownItem(_arg1, this.w_, this.h_);
        this.selected_.x = this.xOffset_;
        this.selected_.y = 0;
        addChild(this.selected_);
        this.selected_.addEventListener(MouseEvent.CLICK, this.onClick);
        if (_arg1 != _local2) {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    private function onClick(_arg1:MouseEvent):void {
        _arg1.stopImmediatePropagation();
        this.selected_.removeEventListener(MouseEvent.CLICK, this.onClick);
        if (contains(this.selected_)) {
            removeChild(this.selected_);
        }
        this.showAll();
    }

    private function showAll():void {
        var _local3:int;
        var _local4:int;
        var _local5:int;
        var _local1:Point = parent.localToGlobal(new Point(x, y));
        this.all_.x = _local1.x;
        this.all_.y = _local1.y;
        var _local2:int = Math.ceil((this.strings_.length / this.maxItems_));
        var _local6:int;
        while (_local6 < _local2) {
            _local3 = (_local6 * this.maxItems_);
            _local4 = Math.min((_local3 + this.maxItems_), this.strings_.length);
            _local5 = (this.xOffset_ - (this.w_ * _local6));
            this.listItems(_local3, _local4, _local5);
            _local6++;
        }
        this.all_.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
        stage.addChild(this.all_);
    }

    private function listItems(_arg1:int, _arg2:int, _arg3:int):void {
        var _local4:int;
        var _local5:DropDownItem;
        _local4 = 0;
        var _local6:int = _arg1;
        while (_local6 < _arg2) {
            _local5 = new DropDownItem(this.strings_[_local6], this.w_, this.h_);
            _local5.addEventListener(MouseEvent.CLICK, this.onSelect);
            _local5.x = _arg3;
            _local5.y = _local4;
            this.all_.addChild(_local5);
            _local4 = (_local4 + _local5.h_);
            _local6++;
        }
    }

    private function hideAll():void {
        this.all_.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
        stage.removeChild(this.all_);
    }

    private function onSelect(_arg1:MouseEvent):void {
        _arg1.stopImmediatePropagation();
        this.hideAll();
        var _local2:DropDownItem = (_arg1.target as DropDownItem);
        this.setSelected(_local2.getValue());
    }

    private function onOut(_arg1:MouseEvent):void {
        this.hideAll();
        this.setSelected(this.selected_.getValue());
    }


}
}
