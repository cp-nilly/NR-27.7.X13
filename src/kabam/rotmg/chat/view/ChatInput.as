package kabam.rotmg.chat.view {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.ui.Keyboard;

import kabam.rotmg.chat.model.ChatModel;

import org.osflash.signals.Signal;

public class ChatInput extends Sprite {

    public const message:Signal = new Signal(String);
    public const close:Signal = new Signal();

    private var input:TextField;
    private var enteredText:Boolean;

    public function ChatInput() {
        visible = false;
        this.enteredText = false;
    }

    public function setup(_arg1:ChatModel, _arg2:TextField):void {
        addChild((this.input = _arg2));
        _arg2.width = (_arg1.bounds.width - 2);
        _arg2.height = _arg1.lineHeight;
        _arg2.y = (_arg1.bounds.height - _arg1.lineHeight);
    }

    public function activate(_arg1:String, _arg2:Boolean):void {
        this.enteredText = false;
        if (_arg1 != null) {
            this.input.text = _arg1;
        }
        var _local3:int = ((_arg1) ? _arg1.length : 0);
        this.input.setSelection(_local3, _local3);
        if (_arg2) {
            this.activateEnabled();
        }
        else {
            this.activateDisabled();
        }
        visible = true;
    }

    public function deactivate():void {
        this.enteredText = false;
        removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
        visible = false;
        ((stage) && ((stage.focus = null)));
    }

    public function hasEnteredText():Boolean {
        return (this.enteredText);
    }

    private function activateEnabled():void {
        this.input.type = TextFieldType.INPUT;
        this.input.border = true;
        this.input.selectable = true;
        this.input.maxChars = 128;
        this.input.borderColor = 0xFFFFFF;
        this.input.height = 18;
        this.input.filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
        addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
        ((stage) && ((stage.focus = this.input)));
    }

    private function onTextChange(_arg1:Event):void {
        this.enteredText = true;
    }

    private function activateDisabled():void {
        this.input.type = TextFieldType.DYNAMIC;
        this.input.border = false;
        this.input.selectable = false;
        this.input.filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
        this.input.height = 18;
        removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onTextChange);
    }

    private function onKeyUp(_arg1:KeyboardEvent):void {
        if (_arg1.keyCode == Keyboard.ENTER) {
            if (this.input.text != "") {
                this.message.dispatch(this.input.text);
            }
            else {
                this.close.dispatch();
            }
            _arg1.stopImmediatePropagation();
        }
    }


}
}
