package kabam.rotmg.editor.view {
import com.company.assembleegameclient.ui.TextButtonBase;

import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class StaticTextButton extends TextButtonBase {

    public function StaticTextButton(_arg1:int, _arg2:String, _arg3:int = 0) {
        super(_arg3);
        addText(_arg1);
        text_.setStringBuilder(new LineBuilder().setParams(_arg2));
        initText();
    }

    override protected function makeText():TextFieldDisplayConcrete {
        return (new StaticTextDisplay());
    }


}
}
