package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import org.osflash.signals.Signal;

public class CloseDialogComponent {

    private const closeSignal:Signal = new Signal();

    private var dialog:DialogCloser;
    private var types:Vector.<String>;

    public function CloseDialogComponent() {
        this.types = new Vector.<String>();
        super();
    }

    public function add(_arg1:DialogCloser, _arg2:String):void {
        this.dialog = _arg1;
        this.types.push(_arg2);
        _arg1.addEventListener(_arg2, this.onButtonType);
    }

    private function onButtonType(_arg1:Event):void {
        var _local2:String;
        for each (_local2 in this.types) {
            this.dialog.removeEventListener(_local2, this.onButtonType);
        }
        this.dialog.getCloseSignal().dispatch();
    }

    public function getCloseSignal():Signal {
        return (this.closeSignal);
    }


}
}
