package kabam.rotmg.account.securityQuestions.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SecurityQuestionsDialog extends Frame {

    private const minQuestionLength:int = 3;
    private const maxQuestionLength:int = 50;
    private const inputPattern:RegExp = /^[a-zA-Z0-9 ]+$/;

    private var errors:Array;
    private var fields:Array;
    private var questionsList:Array;

    public function SecurityQuestionsDialog(_arg1:Array, _arg2:Array) {
        this.errors = [];
        this.questionsList = _arg1;
        super(TextKey.SECURITY_QUESTIONS_DIALOG_TITLE, "", TextKey.SECURITY_QUESTIONS_DIALOG_SAVE);
        this.createAssets();
        if (_arg1.length == _arg2.length) {
            this.updateAnswers(_arg2);
        }
    }

    public function updateAnswers(_arg1:Array) {
        var _local3:TextInputField;
        var _local2:int = 1;
        for each (_local3 in this.fields) {
            _local3.inputText_.text = _arg1[(_local2 - 1)];
            _local2++;
        }
    }

    private function createAssets():void {
        var _local2:String;
        var _local3:TextInputField;
        var _local1:int = 1;
        this.fields = [];
        for each (_local2 in this.questionsList) {
            _local3 = new TextInputField(_local2, false, 240);
            addTextInputField(_local3);
            _local3.inputText_.tabEnabled = true;
            _local3.inputText_.tabIndex = _local1;
            _local3.inputText_.maxChars = this.maxQuestionLength;
            _local1++;
            this.fields.push(_local3);
        }
        rightButton_.tabIndex = (_local1 + 1);
        rightButton_.tabEnabled = true;
    }

    public function clearErrors():void {
        var _local1:TextInputField;
        titleText_.setStringBuilder(new LineBuilder().setParams(TextKey.SECURITY_QUESTIONS_DIALOG_TITLE));
        titleText_.setColor(0xB3B3B3);
        this.errors = [];
        for each (_local1 in this.fields) {
            _local1.setErrorHighlight(false);
        }
    }

    public function areQuestionsValid():Boolean {
        var _local1:TextInputField;
        for each (_local1 in this.fields) {
            if (_local1.inputText_.length < this.minQuestionLength) {
                this.errors.push(TextKey.SECURITY_QUESTIONS_TOO_SHORT);
                _local1.setErrorHighlight(true);
                return (false);
            }
            if (_local1.inputText_.length > this.maxQuestionLength) {
                this.errors.push(TextKey.SECURITY_QUESTIONS_TOO_LONG);
                _local1.setErrorHighlight(true);
                return (false);
            }
        }
        return (true);
    }

    public function displayErrorText():void {
        var _local1:String = (((this.errors.length == 1)) ? this.errors[0] : TextKey.MULTIPLE_ERRORS_MESSAGE);
        this.setError(_local1);
    }

    public function dispose():void {
        this.errors = null;
        this.fields = null;
        this.questionsList = null;
    }

    public function getAnswers():Array {
        var _local2:TextInputField;
        var _local1:Array = [];
        for each (_local2 in this.fields) {
            _local1.push(_local2.inputText_.text);
        }
        return (_local1);
    }

    override public function disable():void {
        super.disable();
        titleText_.setStringBuilder(new LineBuilder().setParams(TextKey.SECURITY_QUESTIONS_SAVING_IN_PROGRESS));
    }

    public function setError(_arg1:String) {
        titleText_.setStringBuilder(new LineBuilder().setParams(_arg1, {"min": this.minQuestionLength}));
        titleText_.setColor(16549442);
    }


}
}
