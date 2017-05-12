package kabam.rotmg.account.securityQuestions.view {
import com.company.assembleegameclient.account.ui.Frame;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SecurityQuestionsConfirmDialog extends Frame {

    private var infoText:TextFieldDisplayConcrete;
    private var questionsList:Array;
    private var answerList:Array;

    public function SecurityQuestionsConfirmDialog(_arg1:Array, _arg2:Array) {
        this.questionsList = _arg1;
        this.answerList = _arg2;
        super(TextKey.SECURITY_QUESTIONS_CONFIRM_TITLE, TextKey.SECURITY_QUESTIONS_CONFIRM_LEFT_BUTTON, TextKey.SECURITY_QUESTIONS_CONFIRM_RIGHT_BUTTON);
        this.createAssets();
    }

    private function createAssets():void {
        var _local3:String;
        var _local1 = "";
        var _local2:int;
        for each (_local3 in this.questionsList) {
            _local1 = (_local1 + (('<font color="#7777EE">' + LineBuilder.getLocalizedStringFromKey(_local3)) + "</font>\n"));
            _local1 = (_local1 + (this.answerList[_local2] + "\n\n"));
            _local2++;
        }
        _local1 = (_local1 + LineBuilder.getLocalizedStringFromKey(TextKey.SECURITY_QUESTIONS_CONFIRM_TEXT));
        this.infoText = new TextFieldDisplayConcrete();
        this.infoText.setStringBuilder(new LineBuilder().setParams(_local1));
        this.infoText.setSize(12).setColor(0xB3B3B3).setBold(true);
        this.infoText.setTextWidth(250);
        this.infoText.setMultiLine(true).setWordWrap(true).setHTML(true);
        this.infoText.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.infoText);
        this.infoText.y = 40;
        this.infoText.x = 17;
        h_ = 280;
    }

    public function dispose():void {
    }

    public function setInProgressMessage():void {
        titleText_.setStringBuilder(new LineBuilder().setParams(TextKey.SECURITY_QUESTIONS_SAVING_IN_PROGRESS));
        titleText_.setColor(0xB3B3B3);
    }

    public function setError(_arg1:String) {
        titleText_.setStringBuilder(new LineBuilder().setParams(_arg1));
        titleText_.setColor(16549442);
    }


}
}
