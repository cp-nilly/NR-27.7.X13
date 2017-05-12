package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import flash.events.Event;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PurchaseConfirmationMediator extends Mediator {

    [Inject]
    public var view:PurchaseConfirmationDialog;
    [Inject]
    public var close:CloseDialogsSignal;


    override public function initialize():void {
        this.view.addEventListener(Dialog.LEFT_BUTTON, this.onYesClickHandler);
        this.view.addEventListener(Dialog.RIGHT_BUTTON, this.onNoClickHandler);
    }

    private function onYesClickHandler(_arg1:Event):void {
        this.close.dispatch();
        this.view.confirmedHandler();
    }

    private function onNoClickHandler(_arg1:Event):void {
        this.close.dispatch();
    }

    override public function destroy():void {
        this.view.removeEventListener(Dialog.LEFT_BUTTON, this.onYesClickHandler);
        this.view.removeEventListener(Dialog.RIGHT_BUTTON, this.onNoClickHandler);
    }


}
}
