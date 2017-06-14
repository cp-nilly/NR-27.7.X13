package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class DebugDialog extends StaticDialog {

    private var f:Function;

    public function DebugDialog(_arg1:String, _arg2:String = "Debug", _arg3:Function = null) {
        super(_arg2, _arg1, "OK", null);
        this.f = _arg3;
        addEventListener(Dialog.LEFT_BUTTON, this.onDialogComplete);
    }

    private function onDialogComplete(_arg1:Event):void {
        var _local2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        _local2.dispatch();
        if (((!((this.parent == null))) && (this.parent.contains(this)))) {
            this.parent.removeChild(this);
        }
        if (this.f != null) {
            this.f();
        }
    }


}
}
