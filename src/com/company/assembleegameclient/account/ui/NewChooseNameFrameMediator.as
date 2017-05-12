package com.company.assembleegameclient.account.ui {
import com.company.util.MoreObjectUtil;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewChooseNameFrameMediator extends Mediator {

    [Inject]
    public var view:NewChooseNameFrame;
    [Inject]
    public var account:Account;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var nameChanged:NameChangedSignal;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var playerModel:PlayerModel;
    private var name:String;


    override public function initialize():void {
        this.view.choose.add(this.onChoose);
        this.view.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.view.choose.remove(this.onChoose);
        this.view.cancel.remove(this.onCancel);
    }

    private function onChoose(_arg1:String):void {
        this.name = _arg1;
        if (_arg1.length < 1) {
            this.view.setError("Name too short");
        }
        else {
            this.sendNameToServer();
        }
    }

    private function sendNameToServer():void {
        var _local1:Object = {"name": this.name};
        MoreObjectUtil.addToObject(_local1, this.account.getCredentials());
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/setName", _local1);
        this.view.disable();
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onNameChoseDone();
        }
        else {
            this.onNameChoseError(_arg2);
        }
    }

    private function onNameChoseDone():void {
        if (this.playerModel != null) {
            this.playerModel.setName(this.name);
        }
        this.nameChanged.dispatch(this.name);
        this.closeDialogs.dispatch();
    }

    private function onNameChoseError(_arg1:String):void {
        this.view.setError(_arg1);
        this.view.enable();
    }

    private function onCancel():void {
        this.closeDialogs.dispatch();
    }


}
}
