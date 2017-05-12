package kabam.rotmg.chat.view {
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.text.TextField;

import kabam.rotmg.chat.control.ParseChatMessageSignal;
import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.chat.model.ChatShortcutModel;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChatInputMediator extends Mediator {

    [Inject]
    public var view:ChatInput;
    [Inject]
    public var model:ChatModel;
    [Inject]
    public var textAndMapProvider:TextAndMapProvider;
    [Inject]
    public var fontModel:FontModel;
    [Inject]
    public var parseChatMessage:ParseChatMessageSignal;
    [Inject]
    public var showChatInput:ShowChatInputSignal;
    [Inject]
    public var tellModel:TellModel;
    [Inject]
    public var chatShortcutModel:ChatShortcutModel;
    public var stage:Stage;


    override public function initialize():void {
        this.stage = this.view.stage;
        this.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        this.view.setup(this.model, this.makeTextfield());
        this.view.message.add(this.onMessage);
        this.view.close.add(this.onDeactivate);
        this.showChatInput.add(this.onShowChatInput);
    }

    override public function destroy():void {
        this.view.message.remove(this.onMessage);
        this.view.close.remove(this.onDeactivate);
        this.showChatInput.remove(this.onShowChatInput);
        this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onDeactivate():void {
        this.showChatInput.dispatch(false, "");
        this.tellModel.resetRecipients();
    }

    private function onMessage(_arg1:String):void {
        this.parseChatMessage.dispatch(_arg1);
        this.showChatInput.dispatch(false, "");
    }

    private function onShowChatInput(_arg1:Boolean, _arg2:String):void {
        if (_arg1) {
            this.view.activate(_arg2, true);
        }
        else {
            this.view.deactivate();
        }
        if (!_arg1) {
            this.tellModel.resetRecipients();
        }
    }

    private function makeTextfield():TextField {
        var _local1:TextField = this.textAndMapProvider.getTextField();
        this.fontModel.apply(_local1, 14, 0xFFFFFF, true);
        return (_local1);
    }

    private function onKeyUp(_arg1:KeyboardEvent):void {
        if (((this.view.visible) && ((((_arg1.keyCode == this.chatShortcutModel.getTellShortcut())) || ((((this.stage.focus == null)) || (this.viewDoesntHaveFocus()))))))) {
            this.processKeyUp(_arg1);
        }
    }

    private function viewDoesntHaveFocus():Boolean {
        return (((!((this.stage.focus.parent == this.view))) && (!((this.stage.focus == this.view)))));
    }

    private function processKeyUp(_arg1:KeyboardEvent):void {
        _arg1.stopImmediatePropagation();
        var _local2:uint = _arg1.keyCode;
        if (_local2 == this.chatShortcutModel.getCommandShortcut()) {
            this.view.activate("/", true);
        }
        else {
            if (_local2 == this.chatShortcutModel.getChatShortcut()) {
                this.view.activate(null, true);
            }
            else {
                if (_local2 == this.chatShortcutModel.getGuildShortcut()) {
                    this.view.activate("/g ", true);
                }
                else {
                    if (_local2 == this.chatShortcutModel.getTellShortcut()) {
                        this.handleTell();
                    }
                }
            }
        }
    }

    private function handleTell():void {
        if (!this.view.hasEnteredText()) {
            this.view.activate((("/tell " + this.tellModel.getNext()) + " "), true);
        }
    }


}
}
