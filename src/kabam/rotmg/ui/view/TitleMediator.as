package kabam.rotmg.ui.view {
import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.screens.ServersScreen;
import com.company.assembleegameclient.ui.language.LanguageOptionOverlay;

import flash.events.Event;
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;
import flash.system.Capabilities;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.editor.view.SpriteView;
import kabam.rotmg.legends.view.LegendsView;
import kabam.rotmg.ui.model.EnvironmentData;
import kabam.rotmg.ui.signals.EnterGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

public class TitleMediator extends Mediator {

    private static var supportCalledBefore:Boolean = false;

    [Inject]
    public var view:TitleView;
    [Inject]
    public var account:Account;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;
    [Inject]
    public var enterGame:EnterGameSignal;
    [Inject]
    public var openAccountInfo:OpenAccountInfoSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var layers:Layers;
    [Inject]
    public var securityQuestionsModel:SecurityQuestionsModel;
    [Inject]
    public var logger:ILogger;


    override public function initialize():void {
        this.view.optionalButtonsAdded.add(this.onOptionalButtonsAdded);
        this.view.initialize(this.makeEnvironmentData());
        this.view.playClicked.add(this.handleIntentionToPlay);
        this.view.serversClicked.add(this.showServersScreen);
        this.view.accountClicked.add(this.handleIntentionToReviewAccount);
        this.view.legendsClicked.add(this.showLegendsScreen);
        this.view.supportClicked.add(this.openSupportPage);
        if (this.securityQuestionsModel.showSecurityQuestionsOnStartup) {
            this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
        }
    }

    private function openSupportPage():void {
        var urlRequest:URLRequest = new URLRequest();
        urlRequest.method = URLRequestMethod.GET;
        urlRequest.url = this.setup.getSupportLink();
        navigateToURL(urlRequest, "_blank");
    }

    private function onOptionalButtonsAdded():void {
        this.view.mapClicked && this.view.mapClicked.add(this.showMapEditor);
        this.view.spriteClicked && this.view.spriteClicked.add(this.showSpriteEditor);
        this.view.quitClicked && this.view.quitClicked.add(this.attemptToCloseClient);
    }

    private function showLanguagesScreen():void {
        this.setScreen.dispatch(new LanguageOptionOverlay());
    }

    private function makeEnvironmentData():EnvironmentData {
        var ed:EnvironmentData = new EnvironmentData();
        var rank:int = this.playerModel.getRank();
        ed.isDesktop = Capabilities.playerType == "Desktop";
        ed.canMapEdit = rank >= this.playerModel.getMapMinRank();
        ed.canSprite = rank >= this.playerModel.getSpriteMinRank();
        ed.buildLabel = this.setup.getBuildLabel();
        ed.copyrightLabel = this.setup.getCopyrightLabel();
        return ed;
    }

    override public function destroy():void {
        this.view.playClicked.remove(this.handleIntentionToPlay);
        this.view.serversClicked.remove(this.showServersScreen);
        this.view.accountClicked.remove(this.handleIntentionToReviewAccount);
        this.view.legendsClicked.remove(this.showLegendsScreen);
        this.view.supportClicked.remove(this.openSupportPage);
        this.view.optionalButtonsAdded.remove(this.onOptionalButtonsAdded);
        this.view.mapClicked && this.view.mapClicked.remove(this.showMapEditor);
        this.view.spriteClicked && this.view.spriteClicked.remove(this.showSpriteEditor);
        this.view.quitClicked && this.view.quitClicked.remove(this.attemptToCloseClient);
    }

    private function openKabamTransferView():void {
        this.view.openKabamTransferView();
    }

    private function handleIntentionToPlay():void {
        this.enterGame.dispatch();
    }

    private function showServersScreen():void {
        this.setScreen.dispatch(new ServersScreen());
    }

    private function handleIntentionToReviewAccount():void {
        this.openAccountInfo.dispatch(false);
    }

    private function showLegendsScreen():void {
        this.setScreen.dispatch(new LegendsView());
    }

    private function showMapEditor():void {
        this.setScreen.dispatch(new MapEditor());
    }

    private function showSpriteEditor():void {
        this.setScreen.dispatch(new SpriteView());
    }

    private function attemptToCloseClient():void {
        dispatch(new Event("APP_CLOSE_EVENT"));
    }


}
}
