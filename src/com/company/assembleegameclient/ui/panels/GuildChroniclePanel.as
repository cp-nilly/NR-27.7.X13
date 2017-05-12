package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.guild.GuildChronicleScreen;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

public class GuildChroniclePanel extends ButtonPanel {

    public function GuildChroniclePanel(_arg1:GameSprite) {
        super(_arg1, TextKey.GUILD_CHRONICLE_TITLE, TextKey.PANEL_VIEW_BUTTON);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function openWindow():void {
        gs_.mui_.clearInput();
        gs_.addChild(new GuildChronicleScreen(gs_));
    }

    override protected function onButtonClick(_arg1:MouseEvent):void {
        this.openWindow();
    }

    private function onAddedToStage(_arg1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if ((((_arg1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.openWindow();
        }
    }


}
}
