package com.company.assembleegameclient.ui {
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class StaticClickableText extends ClickableTextBase {

    public function StaticClickableText(_arg_1:int, _arg_2:Boolean, _arg_3:String) {
        super(_arg_1, _arg_2, _arg_3);
    }

    override protected function makeText():TextFieldDisplayConcrete {
        return (new StaticTextDisplay());
    }


}
}
