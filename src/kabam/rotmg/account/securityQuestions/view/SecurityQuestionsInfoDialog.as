package kabam.rotmg.account.securityQuestions.view {
import com.company.assembleegameclient.account.ui.Frame;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SecurityQuestionsInfoDialog extends Frame {

    private var infoText:TextFieldDisplayConcrete;

    public function SecurityQuestionsInfoDialog() {
        super(TextKey.SECURITY_QUESTIONS_INFO_DIALOG_TITLE, "", TextKey.SECURITY_QUESTIONS_INFO_DIALOG_RIGHT_BUTTON);
        this.displayPopupText();
    }

    private function displayPopupText():void {
        this.infoText = new TextFieldDisplayConcrete();
        this.infoText.setStringBuilder(new LineBuilder().setParams(TextKey.SECURITY_QUESTIONS_INFO_DIALOG_TEXT));
        this.infoText.setSize(12).setColor(0xB3B3B3).setBold(true);
        this.infoText.setTextWidth(250);
        this.infoText.setMultiLine(true).setWordWrap(true).setHTML(true);
        this.infoText.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.infoText);
        this.infoText.y = 40;
        this.infoText.x = 17;
        h_ = 260;
    }

    public function dispose():void {
    }


}
}
