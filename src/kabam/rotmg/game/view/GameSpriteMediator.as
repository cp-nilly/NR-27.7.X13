package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.objects.Player;

import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.InvalidateDataSignal;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.model.DialogsModel;
import kabam.rotmg.game.logging.LoopMonitor;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.game.signals.SetWorldInteractionSignal;
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
import kabam.rotmg.maploading.signals.ShowLoadingViewSignal;
import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
import kabam.rotmg.packages.control.InitPackagesSignal;
import kabam.rotmg.packages.control.OpenPackageSignal;
import kabam.rotmg.packages.control.PackageAvailableSignal;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.packages.services.PackageModel;
import kabam.rotmg.pets.controller.ShowPetTooltip;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
import kabam.rotmg.ui.signals.HUDModelInitialized;
import kabam.rotmg.ui.signals.HUDSetupStarted;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class GameSpriteMediator extends Mediator {

    [Inject]
    public var view:GameSprite;
    [Inject]
    public var setWorldInteraction:SetWorldInteractionSignal;
    [Inject]
    public var invalidate:InvalidateDataSignal;
    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var playGame:PlayGameSignal;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var gameClosed:GameClosedSignal;
    [Inject]
    public var mapModel:MapModel;
    [Inject]
    public var beginnersPackageModel:BeginnersPackageModel;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var monitor:LoopMonitor;
    [Inject]
    public var hudSetupStarted:HUDSetupStarted;
    [Inject]
    public var updateHUDSignal:UpdateHUDSignal;
    [Inject]
    public var hudModelInitialized:HUDModelInitialized;
    [Inject]
    public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
    [Inject]
    public var packageAvailable:PackageAvailableSignal;
    [Inject]
    public var initPackages:InitPackagesSignal;
    [Inject]
    public var showBeginnersPackage:ShowBeginnersPackageSignal;
    [Inject]
    public var packageModel:PackageModel;
    [Inject]
    public var openPackageSignal:OpenPackageSignal;
    [Inject]
    public var showPetTooltip:ShowPetTooltip;
    [Inject]
    public var showLoadingViewSignal:ShowLoadingViewSignal;
    [Inject]
    public var newsButtonRefreshSignal:NewsButtonRefreshSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var dialogsModel:DialogsModel;
    [Inject]
    public var showDailyCalendarSignal:ShowDailyCalendarPopupSignal;
    [Inject]
    public var addToQueueSignal:AddPopupToStartupQueueSignal;
    [Inject]
    public var flushQueueSignal:FlushPopupStartupQueueSignal;


    public static function sleepForMs(_arg1:int):void {
        var _local2:int = getTimer();
        while (true) {
            if ((getTimer() - _local2) >= _arg1) break;
        }
    }


    override public function initialize():void {
        this.showLoadingViewSignal.dispatch();
        this.view.packageModel = this.packageModel;
        this.setWorldInteraction.add(this.onSetWorldInteraction);
        addViewListener(ReconnectEvent.RECONNECT, this.onReconnect);
        this.view.modelInitialized.add(this.onGameSpriteModelInitialized);
        this.view.drawCharacterWindow.add(this.onStatusPanelDraw);
        this.hudModelInitialized.add(this.onHUDModelInitialized);
        this.showPetTooltip.add(this.onShowPetTooltip);
        this.view.monitor.add(this.onMonitor);
        this.view.closed.add(this.onClosed);
        this.view.mapModel = this.mapModel;
        this.view.dialogsModel = this.dialogsModel;
        this.view.beginnersPackageModel = this.beginnersPackageModel;
        this.view.openDialog = this.openDialog;
        this.view.addToQueueSignal = this.addToQueueSignal;
        this.view.flushQueueSignal = this.flushQueueSignal;
        this.view.connect();
        this.view.showBeginnersPackage = this.showBeginnersPackage;
        this.view.openDailyCalendarPopupSignal = this.showDailyCalendarSignal;
        this.view.showPackage.add(this.onShowPackage);
        this.newsButtonRefreshSignal.add(this.onNewsButtonRefreshSignal);
    }

    private function onShowPackage():void {
        var _local1:PackageInfo = this.packageModel.getPriorityPackage();
        if (_local1) {
            this.openPackageSignal.dispatch(_local1.packageID);
        }
        else {
            this.flushQueueSignal.dispatch();
        }
    }

    override public function destroy():void {
        this.view.showPackage.remove(this.onShowPackage);
        this.setWorldInteraction.remove(this.onSetWorldInteraction);
        removeViewListener(ReconnectEvent.RECONNECT, this.onReconnect);
        this.view.modelInitialized.remove(this.onGameSpriteModelInitialized);
        this.view.drawCharacterWindow.remove(this.onStatusPanelDraw);
        this.hudModelInitialized.remove(this.onHUDModelInitialized);
        this.beginnersPackageAvailable.remove(this.onBeginner);
        this.packageAvailable.remove(this.onPackage);
        this.view.closed.remove(this.onClosed);
        this.view.monitor.remove(this.onMonitor);
        this.newsButtonRefreshSignal.remove(this.onNewsButtonRefreshSignal);
        this.view.disconnect();
    }

    private function onMonitor(_arg1:String, _arg2:int):void {
        this.monitor.recordTime(_arg1, _arg2);
    }

    public function onSetWorldInteraction(_arg1:Boolean):void {
        this.view.mui_.setEnablePlayerInput(_arg1);
    }

    private function onBeginner():void {
        this.view.showBeginnersButtonIfSafe();
    }

    private function onPackage():void {
        this.view.showPackageButtonIfSafe();
    }

    private function onClosed():void {
        if (!this.view.isEditor) {
            this.gameClosed.dispatch();
        }
        this.closeDialogs.dispatch();
        var _local1:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
        _local1.dispatch();
        sleepForMs(100);
    }

    private function onReconnect(_arg1:ReconnectEvent):void {
        if (this.view.isEditor) {
            return;
        }
        var _local2:GameInitData = new GameInitData();
        _local2.server = _arg1.server_;
        _local2.gameId = _arg1.gameId_;
        _local2.createCharacter = _arg1.createCharacter_;
        _local2.charId = _arg1.charId_;
        _local2.keyTime = _arg1.keyTime_;
        _local2.key = _arg1.key_;
        _local2.isFromArena = _arg1.isFromArena_;
        this.playGame.dispatch(_local2);
    }

    private function onGameSpriteModelInitialized():void {
        this.hudSetupStarted.dispatch(this.view);
        this.beginnersPackageAvailable.add(this.onBeginner);
        this.packageAvailable.add(this.onPackage);
        this.initPackages.dispatch();
    }

    private function onStatusPanelDraw(_arg1:Player):void {
        this.updateHUDSignal.dispatch(_arg1);
    }

    private function onHUDModelInitialized():void {
        this.view.hudModelInitialized();
    }

    private function onShowPetTooltip(_arg1:Boolean):void {
        this.view.showPetToolTip(_arg1);
    }

    private function onNewsButtonRefreshSignal():void {
        this.view.refreshNewsUpdateButton();
    }


}
}
