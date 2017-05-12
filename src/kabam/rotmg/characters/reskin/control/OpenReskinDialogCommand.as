package kabam.rotmg.characters.reskin.control {
import flash.display.DisplayObject;

import kabam.lib.console.signals.HideConsoleSignal;
import kabam.rotmg.characters.reskin.view.ReskinCharacterView;
import kabam.rotmg.classes.model.CharacterSkins;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.classes.view.CharacterSkinListItemFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class OpenReskinDialogCommand {

    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var hideConsole:HideConsoleSignal;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var model:ClassesModel;
    [Inject]
    public var factory:CharacterSkinListItemFactory;


    public function execute():void {
        this.hideConsole.dispatch();
        this.openDialog.dispatch(this.makeView());
    }

    private function makeView():ReskinCharacterView {
        var _local1:ReskinCharacterView = new ReskinCharacterView();
        _local1.setList(this.makeList());
        _local1.x = int(((800 - _local1.width) * 0.5));
        _local1.y = int(((600 - _local1.viewHeight) * 0.5));
        return (_local1);
    }

    private function makeList():Vector.<DisplayObject> {
        var _local1:CharacterSkins = this.getCharacterSkins();
        return (this.factory.make(_local1));
    }

    private function getCharacterSkins():CharacterSkins {
        return (this.model.getSelected().skins);
    }


}
}
