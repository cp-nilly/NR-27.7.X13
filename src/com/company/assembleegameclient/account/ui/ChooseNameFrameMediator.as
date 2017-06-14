package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.events.NameResultEvent;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.ui.signals.NameChangedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChooseNameFrameMediator extends Mediator {

    [Inject]
    public var view:ChooseNameFrame;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var nameChanged:NameChangedSignal;
    private var gameSprite:AGameSprite;
    private var name:String;


    override public function initialize():void {
        this.gameSprite = this.view.gameSprite;
        this.view.choose.add(this.onChoose);
        this.view.cancel.add(this.onCancel);
    }

    override public function destroy():void {
        this.view.choose.remove(this.onChoose);
        this.view.cancel.remove(this.onCancel);
    }

    private function onChoose(_arg1:String):void {
        this.name = _arg1;
        this.gameSprite.addEventListener(NameResultEvent.NAMERESULTEVENT, this.onNameResult);
        this.gameSprite.gsc_.chooseName(_arg1);
        this.view.disable();
    }

    public function onNameResult(_arg1:NameResultEvent):void {
        this.gameSprite.removeEventListener(NameResultEvent.NAMERESULTEVENT, this.onNameResult);
        var _local2:Boolean = _arg1.m_.success_;
        if (_local2) {
            this.handleSuccessfulNameChange();
        }
        else {
            this.handleFailedNameChange(_arg1.m_.errorText_);
        }
    }

    private function handleSuccessfulNameChange():void {
        this.gameSprite.model.setName(this.name);
        this.gameSprite.map.player_.name_ = this.name;
        this.closeDialogs.dispatch();
        this.nameChanged.dispatch(this.name);
    }

    private function handleFailedNameChange(_arg1:String):void {
        this.view.setError(_arg1);
        this.view.enable();
    }

    private function onCancel():void {
        this.closeDialogs.dispatch();
    }


}
}
