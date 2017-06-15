package kabam.rotmg.account.transfer.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.util.KeyCodes;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.account.transfer.model.TransferAccountData;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class KabamLoginView extends Frame {

    public var cancel:Signal;
    public var signIn:Signal;
    public var forgot:Signal;
    private var email:TextInputField;
    private var password:TextInputField;
    private var headerText:TextFieldDisplayConcrete;
    private var forgotText:DeprecatedClickableText;

    public function KabamLoginView() {
        super("Kabam.com account transfer", TextKey.WEB_LOGIN_DIALOG_LEFT, TextKey.WEB_LOGIN_DIALOG_RIGHT);
        this.makeUI();
        this.forgot = new NativeMappedSignal(this.forgotText, MouseEvent.CLICK);
        this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
        this.signIn = new Signal(TransferAccountData);
    }

    private function makeUI():void {
        this.headerText = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.headerText.setStringBuilder(new StaticStringBuilder("Please login to Kabam.com"));
        this.headerText.filters = [new DropShadowFilter(0, 0, 0)];
        this.headerText.x = 5;
        this.headerText.y = 3;
        this.headerText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.headerText);
        positionText(this.headerText);
        this.email = new TextInputField(TextKey.WEB_LOGIN_DIALOG_EMAIL, false);
        addTextInputField(this.email);
        this.password = new TextInputField(TextKey.WEB_LOGIN_DIALOG_PASSWORD, true);
        addTextInputField(this.password);
        this.forgotText = new DeprecatedClickableText(12, false, TextKey.WEB_LOGIN_DIALOG_FORGOT);
        addNavigationText(this.forgotText);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onSignIn);
        addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if (_arg1.keyCode == KeyCodes.ENTER) {
            this.onSignInSub();
        }
    }

    private function onCancel(_arg1:MouseEvent):void {
        this.cancel.dispatch();
    }

    private function onSignIn(_arg1:MouseEvent):void {
        this.onSignInSub();
    }

    private function onSignInSub():void {
        var _local1:TransferAccountData;
        if (((this.isEmailValid()) && (this.isPasswordValid()))) {
            _local1 = new TransferAccountData();
            _local1.currentEmail = this.email.text();
            _local1.currentPassword = this.password.text();
            this.signIn.dispatch(_local1);
        }
    }

    private function isPasswordValid():Boolean {
        var _local1 = !((this.password.text() == ""));
        if (!_local1) {
            this.password.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_ERROR);
        }
        return (_local1);
    }

    private function isEmailValid():Boolean {
        var _local1 = !((this.email.text() == ""));
        if (!_local1) {
            this.email.setError(TextKey.WEBLOGINDIALOG_EMAIL_ERROR);
        }
        return (_local1);
    }

    public function setError(_arg1:String):void {
        this.password.setError(_arg1);
    }

    public function setEmail(_arg1:String):void {
        this.email.inputText_.text = _arg1;
    }


}
}
