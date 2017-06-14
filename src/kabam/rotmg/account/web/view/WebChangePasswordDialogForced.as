package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebChangePasswordDialogForced extends Frame {

    public var cancel:Signal;
    public var change:Signal;
    public var password_:TextInputField;
    public var newPassword_:TextInputField;
    public var retypeNewPassword_:TextInputField;

    public function WebChangePasswordDialogForced() {
        super(TextKey.WEB_CHANGE_PASSWORD_TITLE, "", TextKey.WEB_CHANGE_PASSWORD_RIGHT);
        this.password_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_PASSWORD, true);
        addTextInputField(this.password_);
        this.newPassword_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_NEW_PASSWORD, true);
        addTextInputField(this.newPassword_);
        this.retypeNewPassword_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_RETYPE_PASSWORD, true);
        addTextInputField(this.retypeNewPassword_);
        this.change = new NativeMappedSignal(rightButton_, MouseEvent.CLICK);
    }

    private function isCurrentPasswordValid():Boolean {
        var _local1 = (this.password_.text().length >= 5);
        if (!_local1) {
            this.password_.setError(TextKey.WEB_CHANGE_PASSWORD_INCORRECT);
        }
        return (_local1);
    }

    private function isNewPasswordValid():Boolean {
        var _local2:String;
        var _local3:int;
        var _local1 = (this.newPassword_.text().length >= 10);
        if (!_local1) {
            this.newPassword_.setError(TextKey.LINK_WEB_ACCOUNT_SHORT);
        }
        else {
            _local2 = this.newPassword_.text();
            _local3 = 0;
            while (_local3 < (_local2.length - 2)) {
                if ((((_local2.charAt(_local3) == _local2.charAt((_local3 + 1)))) && ((_local2.charAt((_local3 + 1)) == _local2.charAt((_local3 + 2)))))) {
                    this.newPassword_.setError(TextKey.LINK_WEB_ACCOUNT_SHORT);
                    _local1 = false;
                }
                _local3++;
            }
        }
        return (_local1);
    }

    private function isNewPasswordVerified():Boolean {
        var _local1 = (this.newPassword_.text() == this.retypeNewPassword_.text());
        if (!_local1) {
            this.retypeNewPassword_.setError(TextKey.PASSWORD_DOES_NOT_MATCH);
        }
        return (_local1);
    }

    public function setError(_arg1:String):void {
        this.password_.setError(_arg1);
    }

    public function clearError():void {
        this.password_.clearError();
        this.retypeNewPassword_.clearError();
        this.newPassword_.clearError();
    }


}
}
