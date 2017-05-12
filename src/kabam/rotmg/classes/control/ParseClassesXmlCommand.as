package kabam.rotmg.classes.control {
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterClassStat;
import kabam.rotmg.classes.model.CharacterClassUnlock;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.text.model.TextKey;

public class ParseClassesXmlCommand {

    [Inject]
    public var data:XML;
    [Inject]
    public var classes:ClassesModel;


    public function execute():void {
        var _local2:XML;
        var _local1:XMLList = this.data.Object;
        for each (_local2 in _local1) {
            this.parseCharacterClass(_local2);
        }
    }

    private function parseCharacterClass(_arg1:XML):void {
        var _local2:int = _arg1.@type;
        var _local3:CharacterClass = this.classes.getCharacterClass(_local2);
        this.populateCharacter(_local3, _arg1);
    }

    private function populateCharacter(_arg1:CharacterClass, _arg2:XML):void {
        var _local3:XML;
        _arg1.id = _arg2.@type;
        _arg1.name = (((_arg2.DisplayId == undefined)) ? _arg2.@id : _arg2.DisplayId);
        _arg1.description = _arg2.Description;
        _arg1.hitSound = _arg2.HitSound;
        _arg1.deathSound = _arg2.DeathSound;
        _arg1.bloodProb = _arg2.BloodProb;
        _arg1.slotTypes = this.parseIntList(_arg2.SlotTypes);
        _arg1.defaultEquipment = this.parseIntList(_arg2.Equipment);
        _arg1.hp = this.parseCharacterStat(_arg2, "MaxHitPoints");
        _arg1.mp = this.parseCharacterStat(_arg2, "MaxMagicPoints");
        _arg1.attack = this.parseCharacterStat(_arg2, "Attack");
        _arg1.defense = this.parseCharacterStat(_arg2, "Defense");
        _arg1.speed = this.parseCharacterStat(_arg2, "Speed");
        _arg1.dexterity = this.parseCharacterStat(_arg2, "Dexterity");
        _arg1.hpRegeneration = this.parseCharacterStat(_arg2, "HpRegen");
        _arg1.mpRegeneration = this.parseCharacterStat(_arg2, "MpRegen");
        _arg1.unlockCost = _arg2.UnlockCost;
        for each (_local3 in _arg2.UnlockLevel) {
            _arg1.unlocks.push(this.parseUnlock(_local3));
        }
        _arg1.skins.addSkin(this.makeDefaultSkin(_arg2), true);
    }

    private function makeDefaultSkin(_arg1:XML):CharacterSkin {
        var _local2:String = _arg1.AnimatedTexture.File;
        var _local3:int = _arg1.AnimatedTexture.Index;
        var _local4:CharacterSkin = new CharacterSkin();
        _local4.id = 0;
        _local4.name = TextKey.CLASSIC_SKIN;
        _local4.template = new CharacterTemplate(_local2, _local3);
        _local4.setState(CharacterSkinState.OWNED);
        _local4.setIsSelected(true);
        return (_local4);
    }

    private function parseUnlock(_arg1:XML):CharacterClassUnlock {
        var _local2:CharacterClassUnlock = new CharacterClassUnlock();
        _local2.level = _arg1.@level;
        _local2.character = this.classes.getCharacterClass(_arg1.@type);
        return (_local2);
    }

    private function parseCharacterStat(_arg1:XML, _arg2:String):CharacterClassStat {
        var _local4:XML;
        var _local5:XML;
        var _local6:CharacterClassStat;
        var _local3:XML = _arg1[_arg2][0];
        for each (_local5 in _arg1.LevelIncrease) {
            if (_local5.text() == _arg2) {
                _local4 = _local5;
            }
        }
        _local6 = new CharacterClassStat();
        _local6.initial = int(_local3.toString());
        _local6.max = _local3.@max;
        _local6.rampMin = ((_local4) ? _local4.@min : 0);
        _local6.rampMax = ((_local4) ? _local4.@max : 0);
        return (_local6);
    }

    private function parseIntList(_arg1:String):Vector.<int> {
        var _local2:Array = _arg1.split(",");
        var _local3:int = _local2.length;
        var _local4:Vector.<int> = new Vector.<int>(_local3, true);
        var _local5:int;
        while (_local5 < _local3) {
            _local4[_local5] = int(_local2[_local5]);
            _local5++;
        }
        return (_local4);
    }


}
}
