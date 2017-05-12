package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.components.Selectable;
import com.company.assembleegameclient.account.ui.components.SelectionGroup;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.HorizontalLayout;
import kabam.rotmg.ui.view.SignalWaiter;

public class PaymentMethodRadioButtons extends Sprite {

    private const waiter:SignalWaiter = new SignalWaiter();

    private var labels:Vector.<String>;
    private var boxes:Vector.<PaymentMethodRadioButton>;
    private var group:SelectionGroup;

    public function PaymentMethodRadioButtons(_arg1:Vector.<String>) {
        this.labels = _arg1;
        this.waiter.complete.add(this.alignRadioButtons);
        this.makeRadioButtons();
        this.alignRadioButtons();
        this.makeSelectionGroup();
    }

    public function setSelected(_arg1:String):void {
        this.group.setSelected(_arg1);
    }

    public function getSelected():String {
        return (this.group.getSelected().getValue());
    }

    private function makeRadioButtons():void {
        var _local1:int = this.labels.length;
        this.boxes = new Vector.<PaymentMethodRadioButton>(_local1, true);
        var _local2:int;
        while (_local2 < _local1) {
            this.boxes[_local2] = this.makeRadioButton(this.labels[_local2]);
            _local2++;
        }
    }

    private function makeRadioButton(_arg1:String):PaymentMethodRadioButton {
        var _local2:PaymentMethodRadioButton = new PaymentMethodRadioButton(_arg1);
        _local2.addEventListener(MouseEvent.CLICK, this.onSelected);
        this.waiter.push(_local2.textSet);
        addChild(_local2);
        return (_local2);
    }

    private function onSelected(_arg1:Event):void {
        var _local2:Selectable = (_arg1.currentTarget as Selectable);
        this.group.setSelected(_local2.getValue());
    }

    private function alignRadioButtons():void {
        var _local1:Vector.<DisplayObject> = this.castBoxesToDisplayObjects();
        var _local2:Layout = new HorizontalLayout();
        _local2.setPadding(20);
        _local2.layout(_local1);
    }

    private function castBoxesToDisplayObjects():Vector.<DisplayObject> {
        var _local1:int = this.boxes.length;
        var _local2:Vector.<DisplayObject> = new <DisplayObject>[];
        var _local3:int;
        while (_local3 < _local1) {
            _local2[_local3] = this.boxes[_local3];
            _local3++;
        }
        return (_local2);
    }

    private function makeSelectionGroup():void {
        var _local1:Vector.<Selectable> = this.castBoxesToSelectables();
        this.group = new SelectionGroup(_local1);
        this.group.setSelected(this.boxes[0].getValue());
    }

    private function castBoxesToSelectables():Vector.<Selectable> {
        var _local1:int = this.boxes.length;
        var _local2:Vector.<Selectable> = new <Selectable>[];
        var _local3:int;
        while (_local3 < _local1) {
            _local2[_local3] = this.boxes[_local3];
            _local3++;
        }
        return (_local2);
    }


}
}
