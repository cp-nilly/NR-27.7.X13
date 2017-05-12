package com.company.assembleegameclient.editor {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class CommandMenu extends Sprite {

    private var keyCodeDict_:Dictionary;
    private var yOffset_:int = 0;
    private var selected_:CommandMenuItem = null;

    public function CommandMenu() {
        this.keyCodeDict_ = new Dictionary();
        super();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function getCommand():int {
        return (this.selected_.command_);
    }

    public function setCommand(_arg1:int):void {
        var _local3:CommandMenuItem;
        var _local2:int;
        while (_local2 < numChildren) {
            _local3 = (getChildAt(_local2) as CommandMenuItem);
            if (_local3 != null) {
                if (_local3.command_ == _arg1) {
                    this.setSelected(_local3);
                    return;
                }
            }
            _local2++;
        }
    }

    protected function setSelected(_arg1:CommandMenuItem):void {
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg1;
        this.selected_.setSelected(true);
    }

    private function onAddedToStage(_arg1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if (stage.focus != null) {
            return;
        }
        var _local2:CommandMenuItem = this.keyCodeDict_[_arg1.keyCode];
        if (_local2 == null) {
            return;
        }
        _local2.callback_(_local2);
    }

    protected function addCommandMenuItem(_arg1:String, _arg2:int, _arg3:Function, _arg4:int):void {
        var _local5:CommandMenuItem = new CommandMenuItem(_arg1, _arg3, _arg4);
        _local5.y = this.yOffset_;
        addChild(_local5);
        if (_arg2 != -1) {
            this.keyCodeDict_[_arg2] = _local5;
        }
        if (this.selected_ == null) {
            this.setSelected(_local5);
        }
        this.yOffset_ = (this.yOffset_ + 30);
    }

    protected function addBreak():void {
        this.yOffset_ = (this.yOffset_ + 30);
    }


}
}
