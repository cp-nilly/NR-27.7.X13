package com.company.assembleegameclient.game {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.AddTextLineSignal;

public class IdleWatcher {

    private static const MINUTE_IN_MS:int = (60 * 1000);//60000
    private static const FIRST_WARNING_MINUTES:int = 10;
    private static const SECOND_WARNING_MINUTES:int = 15;
    private static const KICK_MINUTES:int = 20;

    public var gs_:GameSprite = null;
    public var idleTime_:int = 0;
    private var addTextLine:AddTextLineSignal;

    public function IdleWatcher() {
        this.addTextLine = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
    }

    public function start(_arg1:GameSprite):void {
        this.gs_ = _arg1;
        this.idleTime_ = 0;
        this.gs_.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        this.gs_.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    public function update(_arg1:int):Boolean {
        var _local2:int = this.idleTime_;
        this.idleTime_ = (this.idleTime_ + _arg1);
        if (this.idleTime_ < (FIRST_WARNING_MINUTES * MINUTE_IN_MS)) {
            return (false);
        }
        if ((((this.idleTime_ >= (FIRST_WARNING_MINUTES * MINUTE_IN_MS))) && ((_local2 < (FIRST_WARNING_MINUTES * MINUTE_IN_MS))))) {
            this.addTextLine.dispatch(this.makeFirstWarning());
            return (false);
        }
        if ((((this.idleTime_ >= (SECOND_WARNING_MINUTES * MINUTE_IN_MS))) && ((_local2 < (SECOND_WARNING_MINUTES * MINUTE_IN_MS))))) {
            this.addTextLine.dispatch(this.makeSecondWarning());
            return (false);
        }
        if ((((this.idleTime_ >= (KICK_MINUTES * MINUTE_IN_MS))) && ((_local2 < (KICK_MINUTES * MINUTE_IN_MS))))) {
            this.addTextLine.dispatch(this.makeThirdWarning());
            return (true);
        }
        return (false);
    }

    private function makeFirstWarning():ChatMessage {
        var _local1:ChatMessage = new ChatMessage();
        _local1.name = Parameters.ERROR_CHAT_NAME;
        _local1.text = ((((("You have been idle for " + FIRST_WARNING_MINUTES) + " minutes, you will be disconnected if you are idle for ") + "more than ") + KICK_MINUTES) + " minutes.");
        return (_local1);
    }

    private function makeSecondWarning():ChatMessage {
        var _local1:ChatMessage = new ChatMessage();
        _local1.name = Parameters.ERROR_CHAT_NAME;
        _local1.text = ((((("You have been idle for " + SECOND_WARNING_MINUTES) + " minutes, you will be disconnected if you are idle for ") + "more than ") + KICK_MINUTES) + " minutes.");
        return (_local1);
    }

    private function makeThirdWarning():ChatMessage {
        var _local1:ChatMessage = new ChatMessage();
        _local1.name = Parameters.ERROR_CHAT_NAME;
        _local1.text = (("You have been idle for " + KICK_MINUTES) + " minutes, disconnecting.");
        return (_local1);
    }

    public function stop():void {
        this.gs_.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        this.gs_.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.gs_ = null;
    }

    private function onMouseMove(_arg1:MouseEvent):void {
        this.idleTime_ = 0;
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        this.idleTime_ = 0;
    }


}
}
