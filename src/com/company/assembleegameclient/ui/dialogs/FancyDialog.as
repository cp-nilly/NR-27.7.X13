package com.company.assembleegameclient.ui.dialogs {

import kabam.rotmg.pets.view.dialogs.PetDialogStyler;

public class FancyDialog extends Dialog {

    private var DialogThing:PetDialogStyler;

    public function FancyDialog(_arg1:String, _arg2:String, _arg3:String, _arg4:String, _arg5:String) {
        this.DialogThing = new PetDialogStyler(this);
        super(_arg1, _arg2, _arg3, _arg4, _arg5);
        this.DialogThing.stylizePetDialog();
    }

    override protected function drawAdditionalUI():void {
        this.DialogThing.positionText();
    }

    override protected function drawGraphicsTemplate():void {
        this.DialogThing.drawGraphics();
    }
}
}