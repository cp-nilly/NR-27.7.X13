package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class ConfirmDialog extends StaticDialog {

    private var _callback:Function;

    public function ConfirmDialog(_arg1:String, _arg2:String, _arg3:Function) {
        this._callback = _arg3;
        super(_arg1, _arg2, "Cancel", "OK");
        addEventListener(Dialog.LEFT_BUTTON, this.onCancel);
        addEventListener(Dialog.RIGHT_BUTTON, this.onConfirm);
    }

    private function onConfirm(_arg1:Event):void {
        this._callback();
        var _local2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        _local2.dispatch();
    }

    private function onCancel(_arg1:Event):void {
        var _local2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        _local2.dispatch();
    }


}
}
