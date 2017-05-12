package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebAccountInfoView extends Sprite implements AccountInfoView {

    private static const FONT_SIZE:int = 18;

    private var _login:Signal;
    private var _register:Signal;
    private var _reset:Signal;
    private var userName:String = "";
    private var isRegistered:Boolean;
    private var accountText:TextFieldDisplayConcrete;
    private var registerButton:TitleMenuOption;
    private var loginButton:TitleMenuOption;
    private var resetButton:TitleMenuOption;

    public function WebAccountInfoView() {
        this.makeUIElements();
        this.makeSignals();
    }

    public function get login():Signal {
        return (this._login);
    }

    public function get register():Signal {
        return (this._register);
    }

    public function get reset():Signal {
        return (this._reset);
    }

    private function makeUIElements():void {
        this.makeAccountText();
        this.makeLoginButton();
        this.makeRegisterButton();
        this.makeResetButton();
    }

    private function makeSignals():void {
        this._login = new NativeMappedSignal(this.loginButton, MouseEvent.CLICK);
        this._register = new NativeMappedSignal(this.registerButton, MouseEvent.CLICK);
        this._reset = new NativeMappedSignal(this.resetButton, MouseEvent.CLICK);
    }

    private function makeAccountText():void {
        this.accountText = this.makeTextFieldConcrete();
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT));
    }

    private function makeTextFieldConcrete():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete();
        _local1.setAutoSize(TextFieldAutoSize.RIGHT);
        _local1.setSize(FONT_SIZE).setColor(0xB3B3B3);
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        return (_local1);
    }

    private function makeLoginButton():void {
        this.loginButton = new TitleMenuOption(TextKey.LOG_IN, FONT_SIZE, false);
        this.loginButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeResetButton():void {
        this.resetButton = new TitleMenuOption("reset", FONT_SIZE, false);
        this.resetButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeRegisterButton():void {
        this.registerButton = new TitleMenuOption(TextKey.REGISTER, FONT_SIZE, false);
        this.registerButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeDividerText():DisplayObject {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local1.setColor(0xB3B3B3).setAutoSize(TextFieldAutoSize.RIGHT).setSize(FONT_SIZE);
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        _local1.setStringBuilder(new StaticStringBuilder(" - "));
        return (_local1);
    }

    public function setInfo(_arg1:String, _arg2:Boolean):void {
        this.userName = _arg1;
        this.isRegistered = _arg2;
        this.updateUI();
    }

    private function updateUI():void {
        this.removeUIElements();
        if (this.isRegistered) {
            this.showUIForRegisteredAccount();
        }
        else {
            this.showUIForGuestAccount();
        }
    }

    private function removeUIElements():void {
        while (numChildren) {
            removeChildAt(0);
        }
    }

    private function showUIForRegisteredAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.LOGGED_IN_TEXT, {"userName": this.userName}));
        var _local1:BuildData = StaticInjectorContext.getInjector().getInstance(BuildData);
        this.loginButton.setTextKey(TextKey.LOG_OUT);
        if ((((_local1.getEnvironment() == BuildEnvironment.TESTING)) || ((_local1.getEnvironment() == BuildEnvironment.LOCALHOST)))) {
            this.addAndAlignHorizontally(this.accountText, this.makeDividerText(), this.resetButton, this.makeDividerText(), this.loginButton);
        }
        else {
            this.addAndAlignHorizontally(this.accountText, this.loginButton);
        }
    }

    private function showUIForGuestAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT, {"userName": this.userName}));
        this.loginButton.setTextKey(TextKey.LOG_IN);
        this.addAndAlignHorizontally(this.accountText, this.makeDividerText(), this.registerButton, this.makeDividerText(), this.loginButton);
    }

    private function addAndAlignHorizontally(..._args):void {
        var _local2:DisplayObject;
        var _local3:int;
        var _local4:int;
        var _local5:DisplayObject;
        for each (_local2 in _args) {
            addChild(_local2);
        }
        _local3 = 0;
        _local4 = _args.length;
        while (_local4--) {
            _local5 = _args[_local4];
            _local5.x = _local3;
            _local3 = (_local3 - _local5.width);
        }
    }


}
}
