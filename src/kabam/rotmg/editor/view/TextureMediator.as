package kabam.rotmg.editor.view {
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.editor.model.SearchModel;
import kabam.rotmg.editor.model.TextureData;
import kabam.rotmg.editor.signals.SetTextureSignal;
import kabam.rotmg.ui.view.TitleView;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TextureMediator extends Mediator {

    [Inject]
    public var view:TextureView;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var setTexture:SetTextureSignal;
    [Inject]
    public var searchModel:SearchModel;
    [Inject]
    public var setScreen:SetScreenSignal;


    override public function initialize():void {
        this.view.saveDialog.add(this.onSave);
        this.view.loadDialog.add(this.onLoad);
        this.view.gotoTitle.add(this.onGotoTitle);
        this.setTexture.add(this.onSetTexture);
    }

    override public function destroy():void {
        this.view.loadDialog.remove(this.onLoad);
        this.view.saveDialog.remove(this.onSave);
        this.view.gotoTitle.remove(this.onGotoTitle);
        this.setTexture.remove(this.onSetTexture);
    }

    private function onSetTexture(_arg_1:TextureData):void {
        this.view.setTexture(_arg_1);
    }

    private function onLoad():void {
        this.openDialog.dispatch(new LoadTextureDialog(this.searchModel));
    }

    private function onSave(_arg_1:TextureData):void {
        this.openDialog.dispatch(new SaveTextureDialog(_arg_1));
    }

    private function onGotoTitle():void {
        this.setScreen.dispatch(new TitleView());
    }


}
}
