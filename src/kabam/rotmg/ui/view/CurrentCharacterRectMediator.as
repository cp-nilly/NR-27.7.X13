package kabam.rotmg.ui.view {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;

import flash.display.Sprite;

import kabam.rotmg.characters.deletion.view.ConfirmDeleteCharacterDialog;
import kabam.rotmg.characters.model.CharacterModel;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CurrentCharacterRectMediator extends Mediator {

    [Inject]
    public var view:CurrentCharacterRect;
    [Inject]
    public var playGame:PlayGameSignal;
    [Inject]
    public var model:CharacterModel;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var showTooltip:ShowTooltipSignal;
    [Inject]
    public var hideTooltips:HideTooltipsSignal;


    override public function initialize():void {
        this.view.selected.add(this.onSelected);
        this.view.deleteCharacter.add(this.onDeleteCharacter);
        this.view.showToolTip.add(this.onShow);
        this.view.hideTooltip.add(this.onHide);
    }

    private function onShow(_arg1:Sprite):void {
        this.showTooltip.dispatch(_arg1);
    }

    private function onHide():void {
        this.hideTooltips.dispatch();
    }

    override public function destroy():void {
        this.view.hideTooltip.remove(this.onHide);
        this.view.showToolTip.remove(this.onShow);
        this.view.selected.remove(this.onSelected);
        this.view.deleteCharacter.remove(this.onDeleteCharacter);
    }

    private function onSelected(_arg1:SavedCharacter):void {
        var _local2:CharacterClass = this.classesModel.getCharacterClass(_arg1.objectType());
        _local2.setIsSelected(true);
        _local2.skins.getSkin(_arg1.skinType()).setIsSelected(true);
        this.launchGame(_arg1);
    }

    private function launchGame(_arg1:SavedCharacter):void {
        var _local2:GameInitData = new GameInitData();
        _local2.createCharacter = false;
        _local2.charId = _arg1.charId();
        _local2.isNewGame = true;
        this.playGame.dispatch(_local2);
    }

    private function onDeleteCharacter(_arg1:SavedCharacter):void {
        this.model.select(_arg1);
        this.openDialog.dispatch(new ConfirmDeleteCharacterDialog());
    }


}
}
