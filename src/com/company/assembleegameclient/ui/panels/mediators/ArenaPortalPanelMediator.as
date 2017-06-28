package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
import com.company.assembleegameclient.util.Currency;

import flash.events.Event;

import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.arena.service.GetBestArenaRunTask;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.outgoing.EnterArena;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ArenaPortalPanelMediator extends Mediator {

    public static const TEXT:String = "SellableObjectPanelMediator.text";

    [Inject]
    public var view:ArenaPortalPanel;
    [Inject]
    public var socketServer:SocketServer;
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var gameModel:GameModel;
    [Inject]
    public var currentRunModel:CurrentArenaRunModel;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var exitSignal:ExitGameSignal;
    [Inject]
    public var account:Account;
    private var dialog:Dialog;


    override public function initialize():void {
        this.view.purchase.add(this.onPurchase);
    }

    private function onPurchase(_arg1:int):void {
        if ((_arg1 == Currency.GOLD)) {
            this.purchaseWithGold();
        }
        else {
            this.purchaseWithFame();
        }
    }

    private function purchaseWithFame():void {
        var _local1:GetBestArenaRunTask;
        var _local2:EnterArena;
        if (this.gameModel.player.nameChosen_) {
            this.currentRunModel.saveCurrentUserInfo();
            _local1 = this.injector.getInstance(GetBestArenaRunTask);
            _local1.start();
            _local2 = (this.messages.require(GameServerConnection.ENTER_ARENA) as EnterArena);
            _local2.currency = Currency.FAME;
            this.socketServer.queueMessage(_local2);
            this.exitSignal.dispatch();
        }
        else {
            this.dialog = new Dialog(TextKey.MUST_BE_NAMED_TITLE, TextKey.MUST_BE_NAMED_DESC, TextKey.ERRORDIALOG_OK, null, null);
            this.dialog.addEventListener(Dialog.LEFT_BUTTON, this.onNoNameDialogClose);
            this.openDialog.dispatch(this.dialog);
        }
    }

    private function purchaseWithGold():void {
        var _local1:GetBestArenaRunTask;
        var _local2:EnterArena;
        if (!this.account.isRegistered()) {
            this.openDialog.dispatch(new RegisterPromptDialog(TEXT, {"type": Currency.typeToName(Currency.GOLD)}));
        }
        else {
            if (!this.gameModel.player.nameChosen_) {
                this.dialog = new Dialog(TextKey.MUST_BE_NAMED_TITLE, TextKey.MUST_BE_NAMED_DESC, TextKey.ERRORDIALOG_OK, null, null);
                this.dialog.addEventListener(Dialog.LEFT_BUTTON, this.onNoNameDialogClose);
                this.openDialog.dispatch(this.dialog);
            }
            else {
                if (this.gameModel.player.credits_ < 50) {
                    this.openDialog.dispatch(new NotEnoughGoldDialog());
                }
                else {
                    this.currentRunModel.saveCurrentUserInfo();
                    _local1 = this.injector.getInstance(GetBestArenaRunTask);
                    _local1.start();
                    _local2 = (this.messages.require(GameServerConnection.ENTER_ARENA) as EnterArena);
                    _local2.currency = Currency.GOLD;
                    this.socketServer.queueMessage(_local2);
                    this.exitSignal.dispatch();
                }
            }
        }
    }

    private function onNoNameDialogClose(_arg1:Event):void {
        if (((this.dialog) && (this.dialog.hasEventListener(Dialog.LEFT_BUTTON)))) {
            this.dialog.removeEventListener(Dialog.LEFT_BUTTON, this.onNoNameDialogClose);
        }
        this.dialog = null;
        this.closeDialog.dispatch();
    }


}
}
