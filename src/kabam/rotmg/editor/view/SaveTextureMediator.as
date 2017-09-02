package kabam.rotmg.editor.view {
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.editor.model.TextureData;
import kabam.rotmg.editor.signals.SaveTextureSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SaveTextureMediator extends Mediator {

    [Inject]
    public var view:SaveTextureDialog;
    [Inject]
    public var saveTexture:SaveTextureSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;


    override public function initialize():void {
        this.view.saveTexture.add(this.onSaveTexture);
        this.view.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.view.saveTexture.remove(this.onSaveTexture);
        this.view.cancel.remove(this.onCancel);
    }

    private function onSaveTexture(_arg_1:TextureData):void {
        this.saveTexture.dispatch(_arg_1);
    }

    private function onCancel():void {
        this.closeDialogs.dispatch();
    }


}
}
