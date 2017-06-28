package kabam.rotmg.pets.data {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import org.osflash.signals.Signal;

public class PetVO {

    public const updated:Signal = new Signal();

    private var staticData:XML;
    private var id:int;
    private var type:int;
    private var rarity:String;
    private var name:String;
    private var maxAbilityPower:int;
    public var abilityList:Array;
    private var skinID:int;
    private var skin:AnimatedChar;

    public function PetVO(_arg1:int = undefined) {
        this.abilityList = [new AbilityVO(), new AbilityVO(), new AbilityVO()];
        super();
        this.id = _arg1;
        this.staticData = <data/>;
        this.listenToAbilities();
    }

    private static function getPetDataDescription(_arg1:int):String {
        return (ObjectLibrary.getPetDataXMLByType(_arg1).Description);
    }

    private static function getPetDataDisplayId(_arg1:int):String {
        return (ObjectLibrary.getPetDataXMLByType(_arg1).@id);
    }

    public static function clone(_arg1:PetVO):PetVO {
        return new PetVO(_arg1.id);
    }


    private function listenToAbilities():void {
        var _local1:AbilityVO;
        for each (_local1 in this.abilityList) {
            _local1.updated.add(this.onAbilityUpdate);
        }
    }

    public function maxedAllAbilities():Boolean {
        var _local2:AbilityVO;
        var _local1:int;
        for each (_local2 in this.abilityList) {
            if (_local2.level == 100) {
                _local1++;
            }
        }
        return ((_local1 == this.abilityList.length));
    }

    private function onAbilityUpdate(_arg1:AbilityVO):void {
        this.updated.dispatch();
    }

    public function apply(_arg1:XML):void {
        this.extractBasicData(_arg1);
        this.extractAbilityData(_arg1);
    }

    private function extractBasicData(_arg1:XML):void {
        ((_arg1.@instanceId) && (this.setID(_arg1.@instanceId)));
        ((_arg1.@type) && (this.setType(_arg1.@type)));
        ((_arg1.@name) && (this.setName(_arg1.@name)));
        ((_arg1.@skin) && (this.setSkin(_arg1.@skin)));
        ((_arg1.@rarity) && (this.setRarity(_arg1.@rarity)));
    }

    public function extractAbilityData(_arg1:XML):void {
        var _local2:uint;
        var _local4:AbilityVO;
        var _local5:int;
        var _local3:uint = this.abilityList.length;
        _local2 = 0;
        while (_local2 < _local3) {
            _local4 = this.abilityList[_local2];
            _local5 = _arg1.Abilities.Ability[_local2].@type;
            _local4.name = getPetDataDisplayId(_local5);
            _local4.description = getPetDataDescription(_local5);
            _local4.level = _arg1.Abilities.Ability[_local2].@power;
            _local4.points = _arg1.Abilities.Ability[_local2].@points;
            _local2++;
        }
    }

    public function getFamily():String {
        return (this.staticData.Family);
    }

    public function setID(_arg1:int):void {
        this.id = _arg1;
    }

    public function getID():int {
        return (this.id);
    }

    public function setType(_arg1:int):void {
        this.type = _arg1;
        this.staticData = ObjectLibrary.xmlLibrary_[this.type];
    }

    public function getType():int {
        return (this.type);
    }

    public function setRarity(_arg1:uint):void {
        this.rarity = PetRarityEnum.selectByOrdinal(_arg1).value;
        this.unlockAbilitiesBasedOnPetRarity(_arg1);
        this.updated.dispatch();
    }

    private function unlockAbilitiesBasedOnPetRarity(_arg1:uint):void {
        this.abilityList[0].setUnlocked(true);
        this.abilityList[1].setUnlocked((_arg1 >= PetRarityEnum.UNCOMMON.ordinal));
        this.abilityList[2].setUnlocked((_arg1 >= PetRarityEnum.LEGENDARY.ordinal));
    }

    public function getRarity():String {
        return (this.rarity);
    }

    public function setName(_arg1:String):void {
        this.name = ObjectLibrary.typeToDisplayId_[this.skinID];
        if ((((this.name == null)) || ((this.name == "")))) {
            this.name = ObjectLibrary.typeToDisplayId_[this.getType()];
        }
        this.updated.dispatch();
    }

    public function getName():String {
        return (this.name);
    }

    public function setMaxAbilityPower(_arg1:int):void {
        this.maxAbilityPower = _arg1;
        this.updated.dispatch();
    }

    public function getMaxAbilityPower():int {
        return (this.maxAbilityPower);
    }

    public function setSkin(_arg1:int):void {
        this.skinID = _arg1;
        this.updated.dispatch();
    }

    public function getSkinID():int {
        return (this.skinID);
    }

    public function getSkin():Bitmap {
        this.makeSkin();
        var _local1:MaskedImage = this.skin.imageFromAngle(0, AnimatedChar.STAND, 0);
        var _local2:int = (((this.skin.getHeight() == 16)) ? 40 : 80);
        var _local3:BitmapData = TextureRedrawer.resize(_local1.image_, _local1.mask_, _local2, true, 0, 0);
        _local3 = GlowRedrawer.outlineGlow(_local3, 0);
        return (new Bitmap(_local3));
    }

    public function getSkinMaskedImage():MaskedImage {
        this.makeSkin();
        return (((this.skin) ? this.skin.imageFromAngle(0, AnimatedChar.STAND, 0) : null));
    }

    private function makeSkin():void {
        var _local1:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(this.skinID));
        var _local2:String = _local1.AnimatedTexture.File;
        var _local3:int = _local1.AnimatedTexture.Index;
        this.skin = AnimatedChars.getAnimatedChar(_local2, _local3);
    }


}
}
