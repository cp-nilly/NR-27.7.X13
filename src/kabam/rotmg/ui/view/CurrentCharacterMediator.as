package kabam.rotmg.ui.view {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;

import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
import kabam.rotmg.packages.control.InitPackagesSignal;
import kabam.rotmg.packages.control.PackageAvailableSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.ui.signals.ChooseNameSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CurrentCharacterMediator extends Mediator {

    [Inject]
    public var view:CharacterSelectionAndNewsScreen;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var playGame:PlayGameSignal;
    [Inject]
    public var chooseName:ChooseNameSignal;
    [Inject]
    public var nameChanged:NameChangedSignal;
    [Inject]
    public var initPackages:InitPackagesSignal;
    [Inject]
    public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
    [Inject]
    public var packageAvailable:PackageAvailableSignal;
    [Inject]
    public var beginnerModel:BeginnersPackageModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var securityQuestionsModel:SecurityQuestionsModel;


    override public function initialize():void {
        this.view.initialize(this.playerModel);
        this.view.close.add(this.onClose);
        this.view.newCharacter.add(this.onNewCharacter);
        this.view.showClasses.add(this.onNewCharacter);
        this.view.chooseName.add(this.onChooseName);
        this.view.playGame.add(this.onPlayGame);
        this.nameChanged.add(this.onNameChanged);
        this.beginnersPackageAvailable.add(this.onBeginner);
        this.packageAvailable.add(this.onPackage);
        this.initPackages.dispatch();
        if (this.securityQuestionsModel.showSecurityQuestionsOnStartup) {
            this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
        }
    }

    private function onPackage():void {
        this.view.showPackageButton();
    }

    private function onBeginner():void {
        this.view.showBeginnersOfferButton();
    }

    override public function destroy():void {
        this.nameChanged.remove(this.onNameChanged);
        this.beginnersPackageAvailable.remove(this.onBeginner);
        this.view.close.remove(this.onClose);
        this.view.newCharacter.remove(this.onNewCharacter);
        this.view.chooseName.remove(this.onChooseName);
        this.view.showClasses.remove(this.onNewCharacter);
        this.view.playGame.remove(this.onPlayGame);
    }

    private function onNameChanged(_arg1:String):void {
        this.view.setName(_arg1);
    }

    private function onNewCharacter():void {
        this.setScreen.dispatch(new NewCharacterScreen());
    }

    private function onClose():void {
        this.setScreen.dispatch(new TitleView());
    }

    private function onChooseName():void {
        this.chooseName.dispatch();
    }

    private function onPlayGame():void {
        var _local1:SavedCharacter = this.playerModel.getCharacterByIndex(0);
        this.playerModel.currentCharId = _local1.charId();
        var _local2:CharacterClass = this.classesModel.getCharacterClass(_local1.objectType());
        _local2.setIsSelected(true);
        _local2.skins.getSkin(_local1.skinType()).setIsSelected(true);
        var _local4:GameInitData = new GameInitData();
        _local4.createCharacter = false;
        _local4.charId = _local1.charId();
        _local4.isNewGame = true;
        this.playGame.dispatch(_local4);
    }


}
}
