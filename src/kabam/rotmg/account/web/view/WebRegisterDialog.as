package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.EmailValidator;

import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.account.ui.components.DateField;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebRegisterDialog extends Frame {

    private const errors:Array = [];

    public var register:Signal;
    public var signIn:Signal;
    public var cancel:Signal;
    private var emailInput:LabeledField;
    private var passwordInput:LabeledField;
    private var retypePasswordInput:LabeledField;
    private var checkbox:CheckBoxField;
    private var ageVerificationInput:DateField;
    private var signInText:TextFieldDisplayConcrete;
    private var tosText:TextFieldDisplayConcrete;
    private var endLink:String = "</a></font>";

    public function WebRegisterDialog() {
        super(TextKey.REGISTER_IMPERATIVE, "RegisterWebAccountDialog.leftButton", "RegisterWebAccountDialog.rightButton", 326);
        this.makeUIElements();
        this.makeSignals();
    }

    private function makeUIElements():void {
        this.emailInput = new LabeledField(TextKey.REGISTER_WEB_ACCOUNT_EMAIL, false, 275);
        this.passwordInput = new LabeledField(TextKey.REGISTER_WEB_ACCOUNT_PASSWORD, true, 275);
        this.retypePasswordInput = new LabeledField(TextKey.RETYPE_PASSWORD, true, 275);
        this.ageVerificationInput = new DateField();
        this.ageVerificationInput.setTitle(TextKey.BIRTHDAY);
        addLabeledField(this.emailInput);
        addLabeledField(this.passwordInput);
        addLabeledField(this.retypePasswordInput);
        addComponent(this.ageVerificationInput, 17);
        addSpace(35);
        this.checkbox = new CheckBoxField(TextKey.CHECK_BOX_TEXT, false, 12);
        addCheckBox(this.checkbox);
        addSpace(17);
        this.makeTosText();
        addSpace((17 * 2));
        this.makeSignInText();
    }

    public function makeSignInText():void {
        this.signInText = new TextFieldDisplayConcrete();
        var _local1 = '<font color="#7777EE"><a href="event:flash.events.TextEvent">';
        this.signInText.setStringBuilder(new LineBuilder().setParams(TextKey.SIGN_IN_TEXT, {
            "signIn": _local1,
            "_signIn": this.endLink
        }));
        this.signInText.addEventListener(TextEvent.LINK, this.linkEvent);
        this.configureTextAndAdd(this.signInText);
    }

    public function makeTosText():void {
        this.tosText = new TextFieldDisplayConcrete();
        var _local1 = (('<font color="#7777EE"><a href="' + Parameters.TERMS_OF_USE_URL) + '" target="_blank">');
        var _local2 = (('<font color="#7777EE"><a href="' + Parameters.PRIVACY_POLICY_URL) + '" target="_blank">');
        this.tosText.setStringBuilder(new LineBuilder().setParams(TextKey.TOS_TEXT, {
            "tou": _local1,
            "_tou": this.endLink,
            "policy": _local2,
            "_policy": this.endLink
        }));
        this.configureTextAndAdd(this.tosText);
    }

    public function configureTextAndAdd(_arg1:TextFieldDisplayConcrete):void {
        _arg1.setSize(12).setColor(0xB3B3B3).setBold(true);
        _arg1.setTextWidth(275);
        _arg1.setMultiLine(true).setWordWrap(true).setHTML(true);
        _arg1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_arg1);
        positionText(_arg1);
    }

    private function linkEvent(_arg1:TextEvent):void {
        this.signIn.dispatch();
    }

    private function makeSignals():void {
        this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onRegister);
        this.register = new Signal(AccountData);
        this.signIn = new Signal();
    }

    private function onRegister(_arg1:MouseEvent):void {
        var _local2:Boolean = this.areInputsValid();
        this.displayErrors();
        if (_local2) {
            this.sendData();
        }
    }

    private function areInputsValid():Boolean {
        this.errors.length = 0;
        var _local1:Boolean = true;
        _local1 = ((this.isEmailValid()) && (_local1));
        _local1 = ((this.isPasswordValid()) && (_local1));
        _local1 = ((this.isPasswordVerified()) && (_local1));
        _local1 = ((this.isAgeVerified()) && (_local1));
        return (((this.isAgeValid()) && (_local1)));
    }

    private function isAgeVerified():Boolean {
        var _local1:uint = DateFieldValidator.getPlayerAge(this.ageVerificationInput);
        var _local2 = (_local1 >= 13);
        this.ageVerificationInput.setErrorHighlight(!(_local2));
        if (!_local2) {
            this.errors.push(TextKey.INELIGIBLE_AGE);
        }
        return (_local2);
    }

    private function isAgeValid():Boolean {
        var _local1:Boolean = this.ageVerificationInput.isValidDate();
        this.ageVerificationInput.setErrorHighlight(!(_local1));
        if (!_local1) {
            this.errors.push(TextKey.INVALID_BIRTHDATE);
        }
        return (_local1);
    }

    private function isEmailValid():Boolean {
        var _local1:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
        this.emailInput.setErrorHighlight(!(_local1));
        if (!_local1) {
            this.errors.push(TextKey.INVALID_EMAIL_ADDRESS);
        }
        return (_local1);
    }

    private function isPasswordValid():Boolean {
        var _local1 = (this.passwordInput.text().length >= 5);
        this.passwordInput.setErrorHighlight(!(_local1));
        if (!_local1) {
            this.errors.push(TextKey.PASSWORD_TOO_SHORT);
        }
        return (_local1);
    }

    private function isPasswordVerified():Boolean {
        var _local1 = (this.passwordInput.text() == this.retypePasswordInput.text());
        this.retypePasswordInput.setErrorHighlight(!(_local1));
        if (!_local1) {
            this.errors.push(TextKey.PASSWORDS_DONT_MATCH);
        }
        return (_local1);
    }

    public function displayErrors():void {
        if (this.errors.length == 0) {
            this.clearErrors();
        }
        else {
            this.displayErrorText((((this.errors.length == 1)) ? this.errors[0] : TextKey.MULTIPLE_ERRORS_MESSAGE));
        }
    }

    public function displayServerError(_arg1:String):void {
        this.displayErrorText(_arg1);
    }

    private function clearErrors():void {
        titleText_.setStringBuilder(new LineBuilder().setParams(TextKey.REGISTER_IMPERATIVE));
        titleText_.setColor(0xB3B3B3);
    }

    private function displayErrorText(_arg1:String):void {
        titleText_.setStringBuilder(new LineBuilder().setParams(_arg1));
        titleText_.setColor(16549442);
    }

    private function sendData():void {
        var _local1:AccountData = new AccountData();
        _local1.username = this.emailInput.text();
        _local1.password = this.passwordInput.text();
        _local1.signedUpKabamEmail = ((this.checkbox.isChecked()) ? 1 : 0);
        this.register.dispatch(_local1);
    }


}
}
