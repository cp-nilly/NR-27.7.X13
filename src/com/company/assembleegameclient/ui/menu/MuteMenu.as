package com.company.assembleegameclient.ui.menu {
import flash.events.MouseEvent;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.GameServerConnection;

import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.game.AGameSprite;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class MuteMenu extends Frame {
    public var gs_:AGameSprite;
    private var player:Player;
    private var muteDuration:TextInputField;

    function MuteMenu(plr:Player) {
        this.player = plr;

        super("Mute options for player " + plr.name_, TextKey.FRAME_CANCEL, "Mute");
        this.muteDuration = new TextInputField("Mute Duration",false);
        this.muteDuration.inputText_.restrict = "0-9\\-";
        addTextInputField(this.muteDuration);
        addPlainText("input amount in minutes");
        addPlainText("-1 for permanent mute");
        leftButton_.addEventListener(MouseEvent.CLICK, onCancel);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onAction);
    }

    private static function onCancel(me:MouseEvent):void {
        StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
    }

    private function onAction(me:MouseEvent):void {
        if(this.muteDuration.text() == "") {
            this.muteDuration.setError("Specify a duration for the mute.");
            return;
        }
        var duration:Number = Number(this.muteDuration.text());
        GameServerConnection.instance.playerText("/mute " + this.player.name_ + (duration > 0?" " + duration:""));
        StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
    }
}
}
