package kabam.rotmg.ui.view {
import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.ui.dialogs.ConfirmDialog;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.servers.api.ServerModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapEditorMediator extends Mediator {

    [Inject]
    public var view:MapEditor;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var gameClosed:GameClosedSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var setScreen:SetScreenSignal;


    override public function initialize():void {
        this.view.initialize(this.model, this.servers.getServer());
        this.view.editingScreen_.gotoTitleDialog.add(this.onReturnPhase1);
        this.view.editingScreen_.gotoTitle.add(this.onReturn);
    }

    override public function destroy():void {
        this.view.editingScreen_.gotoTitleDialog.remove(this.onReturnPhase1);
        this.view.editingScreen_.gotoTitle.remove(this.onReturn);
    }

    private function onReturnPhase1():void {
        var confirmDialog:ConfirmDialog = new ConfirmDialog("Go Back", "Are you sure you want to return to the title screen? This will erase your map data.", this.onReturn);
        this.openDialog.dispatch(confirmDialog);
    }

    private function onReturn():void {
        this.setScreen.dispatch(new TitleView());
    }


}
}
