package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class CharacterRectList extends Sprite {

    private var classes:ClassesModel;
    private var model:PlayerModel;
    private var assetFactory:CharacterFactory;
    public var newCharacter:Signal;
    public var buyCharacterSlot:Signal;

    public function CharacterRectList() {
        var _local5:SavedCharacter;
        var _local6:BuyCharacterRect;
        var _local7:CharacterClass;
        var _local8:CharacterStats;
        var _local9:CurrentCharacterRect;
        var _local10:int;
        var _local11:CreateNewCharacterRect;
        super();
        var _local1:Injector = StaticInjectorContext.getInjector();
        this.classes = _local1.getInstance(ClassesModel);
        this.model = _local1.getInstance(PlayerModel);
        this.assetFactory = _local1.getInstance(CharacterFactory);
        this.newCharacter = new Signal();
        this.buyCharacterSlot = new Signal();
        var _local2:String = this.model.getName();
        var _local3:int = 4;
        var _local4:Vector.<SavedCharacter> = this.model.getSavedCharacters();
        for each (_local5 in _local4) {
            _local7 = this.classes.getCharacterClass(_local5.objectType());
            _local8 = this.model.getCharStats()[_local5.objectType()];
            _local9 = new CurrentCharacterRect(_local2, _local7, _local5, _local8);
            if (Parameters.skinTypes16.indexOf(_local5.skinType()) != -1) {
                _local9.setIcon(this.getIcon(_local5, 50));
            }
            else {
                _local9.setIcon(this.getIcon(_local5, 100));
            }
            _local9.y = _local3;
            addChild(_local9);
            _local3 = (_local3 + (CharacterRect.HEIGHT + 4));
        }
        if (this.model.hasAvailableCharSlot()) {
            _local10 = 0;
            while (_local10 < this.model.getAvailableCharSlots()) {
                _local11 = new CreateNewCharacterRect(this.model);
                _local11.addEventListener(MouseEvent.MOUSE_DOWN, this.onNewChar);
                _local11.y = _local3;
                addChild(_local11);
                _local3 = (_local3 + (CharacterRect.HEIGHT + 4));
                _local10++;
            }
        }
        _local6 = new BuyCharacterRect(this.model);
        _local6.addEventListener(MouseEvent.MOUSE_DOWN, this.onBuyCharSlot);
        _local6.y = _local3;
        addChild(_local6);
    }

    private function getIcon(_arg1:SavedCharacter, _arg2:int = 100):DisplayObject {
        var _local3:CharacterClass = this.classes.getCharacterClass(_arg1.objectType());
        var _local4:CharacterSkin = ((_local3.skins.getSkin(_arg1.skinType())) || (_local3.skins.getDefaultSkin()));
        var _local5:BitmapData = this.assetFactory.makeIcon(_local4.template, _arg2, _arg1.tex1(), _arg1.tex2());
        return (new Bitmap(_local5));
    }

    private function onNewChar(_arg1:Event):void {
        this.newCharacter.dispatch();
    }

    private function onBuyCharSlot(_arg1:Event):void {
        this.buyCharacterSlot.dispatch(this.model.getCharSlotPrice());
    }


}
}
