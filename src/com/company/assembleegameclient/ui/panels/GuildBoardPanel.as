package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.board.GuildBoardWindow;
import com.company.assembleegameclient.util.GuildUtil;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

public class GuildBoardPanel extends ButtonPanel {

    public function GuildBoardPanel(_arg1:GameSprite) {
        super(_arg1, TextKey.GUILD_BOARD_TITLE, TextKey.PANEL_VIEW_BUTTON);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    override protected function onButtonClick(_arg1:MouseEvent):void {
        this.openWindow();
    }

    private function openWindow():void {
        var _local1:Player = gs_.map.player_;
        if (_local1 == null) {
            return;
        }
        gs_.addChild(new GuildBoardWindow((_local1.guildRank_ >= GuildUtil.OFFICER)));
    }

    private function onAddedToStage(_arg1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if ((((_arg1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.openWindow();
        }
    }


}
}
