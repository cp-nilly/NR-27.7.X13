package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.account.ui.components.Selectable;
import com.company.assembleegameclient.account.ui.components.SelectionGroup;
import com.company.assembleegameclient.util.offer.Offer;
import com.company.assembleegameclient.util.offer.Offers;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.lib.ui.api.Layout;
import kabam.lib.ui.impl.VerticalLayout;
import kabam.rotmg.account.core.model.MoneyConfig;

public class OfferRadioButtons extends Sprite {

    private var offers:Offers;
    private var config:MoneyConfig;
    private var choices:Vector.<OfferRadioButton>;
    private var group:SelectionGroup;

    public function OfferRadioButtons(_arg1:Offers, _arg2:MoneyConfig) {
        this.offers = _arg1;
        this.config = _arg2;
        this.makeGoldChoices();
        this.alignGoldChoices();
        this.makeSelectionGroup();
    }

    public function getChoice():OfferRadioButton {
        return ((this.group.getSelected() as OfferRadioButton));
    }

    private function makeGoldChoices():void {
        var _local1:int = this.offers.offerList.length;
        this.choices = new Vector.<OfferRadioButton>(_local1, true);
        var _local2:int;
        while (_local2 < _local1) {
            this.choices[_local2] = this.makeGoldChoice(this.offers.offerList[_local2]);
            _local2++;
        }
    }

    private function makeGoldChoice(_arg1:Offer):OfferRadioButton {
        var _local2:OfferRadioButton = new OfferRadioButton(_arg1, this.config);
        _local2.addEventListener(MouseEvent.CLICK, this.onSelected);
        addChild(_local2);
        return (_local2);
    }

    private function onSelected(_arg1:MouseEvent):void {
        var _local2:Selectable = (_arg1.currentTarget as Selectable);
        this.group.setSelected(_local2.getValue());
    }

    private function alignGoldChoices():void {
        var _local1:Vector.<DisplayObject> = this.castChoicesToDisplayList();
        var _local2:Layout = new VerticalLayout();
        _local2.setPadding(5);
        _local2.layout(_local1);
    }

    private function castChoicesToDisplayList():Vector.<DisplayObject> {
        var _local1:int = this.choices.length;
        var _local2:Vector.<DisplayObject> = new <DisplayObject>[];
        var _local3:int;
        while (_local3 < _local1) {
            _local2[_local3] = this.choices[_local3];
            _local3++;
        }
        return (_local2);
    }

    private function makeSelectionGroup():void {
        var _local1:Vector.<Selectable> = this.castBoxesToSelectables();
        this.group = new SelectionGroup(_local1);
        this.group.setSelected(this.choices[0].getValue());
    }

    private function castBoxesToSelectables():Vector.<Selectable> {
        var _local1:int = this.choices.length;
        var _local2:Vector.<Selectable> = new <Selectable>[];
        var _local3:int;
        while (_local3 < _local1) {
            _local2[_local3] = this.choices[_local3];
            _local3++;
        }
        return (_local2);
    }

    public function showBonuses(_arg1:Boolean):void {
        var _local2:int = this.choices.length;
        while (_local2--) {
            this.choices[_local2].showBonus(_arg1);
        }
    }


}
}
