package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.account.ui.CreateGuildFrame;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.panels.GuildRegisterPanel;

import flash.events.Event;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GuildRegisterPanelMediator extends Mediator {

    [Inject]
    public var view:GuildRegisterPanel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var hudModel:HUDModel;


    override public function initialize():void {
        this.view.openCreateGuildFrame.add(this.onDispatchCreateGuildFrame);
        this.view.renounce.add(this.onRenounceClick);
    }

    override public function destroy():void {
        this.view.openCreateGuildFrame.remove(this.onDispatchCreateGuildFrame);
        this.view.renounce.remove(this.onRenounceClick);
    }

    private function onDispatchCreateGuildFrame():void {
        this.openDialog.dispatch(new CreateGuildFrame(this.hudModel.gameSprite));
    }

    public function onRenounceClick():void {
        var _local1:GameSprite = this.hudModel.gameSprite;
        if ((((_local1.map == null)) || ((_local1.map.player_ == null)))) {
            return;
        }
        var _local2:Player = _local1.map.player_;
        var _local3:Dialog = new Dialog(TextKey.RENOUNCE_DIALOG_SUBTITLE, TextKey.RENOUNCE_DIALOG_TITLE, TextKey.RENOUNCE_DIALOG_CANCEL, TextKey.RENOUNCE_DIALOG_ACCEPT, "/renounceGuild");
        _local3.setTextParams(TextKey.RENOUNCE_DIALOG_TITLE, {"guildName": _local2.guildName_});
        _local3.addEventListener(Dialog.LEFT_BUTTON, this.onRenounce);
        _local3.addEventListener(Dialog.RIGHT_BUTTON, this.onCancel);
        this.openDialog.dispatch(_local3);
    }

    private function onCancel(_arg1:Event):void {
        this.closeDialog.dispatch();
    }

    private function onRenounce(_arg1:Event):void {
        var _local2:GameSprite = this.hudModel.gameSprite;
        if ((((_local2.map == null)) || ((_local2.map.player_ == null)))) {
            return;
        }
        var _local3:Player = _local2.map.player_;
        _local2.gsc_.guildRemove(_local3.name_);
        this.closeDialog.dispatch();
    }


}
}
