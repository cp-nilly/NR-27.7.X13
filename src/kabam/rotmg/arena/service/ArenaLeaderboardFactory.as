package kabam.rotmg.arena.service {
import com.company.util.ConversionUtil;

import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.pets.data.PetVO;

public class ArenaLeaderboardFactory {

    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;
    [Inject]
    public var currentRunModel:CurrentArenaRunModel;


    public function makeEntries(_arg1:XMLList):Vector.<ArenaLeaderboardEntry> {
        var _local4:XML;
        var _local2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
        var _local3:int = 1;
        for each (_local4 in _arg1) {
            _local2.push(this.makeArenaEntry(_local4, _local3));
            _local3++;
        }
        _local2 = this.removeDuplicateUser(_local2);
        return (this.addCurrentRun(_local2));
    }

    private function addCurrentRun(_arg1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry> {
        var _local3:Boolean;
        var _local4:Boolean;
        var _local5:ArenaLeaderboardEntry;
        var _local2:Vector.<ArenaLeaderboardEntry> = new Vector.<ArenaLeaderboardEntry>();
        if (this.currentRunModel.hasEntry()) {
            _local3 = false;
            _local4 = false;
            for each (_local5 in _arg1) {
                if (((!(_local3)) && (this.currentRunModel.entry.isBetterThan(_local5)))) {
                    this.currentRunModel.entry.rank = _local5.rank;
                    _local2.push(this.currentRunModel.entry);
                    _local3 = true;
                }
                if (_local5.isPersonalRecord) {
                    _local4 = true;
                }
                if (_local3) {
                    _local5.rank++;
                }
                _local2.push(_local5);
            }
            if ((((((_local2.length < 20)) && (!(_local3)))) && (!(_local4)))) {
                this.currentRunModel.entry.rank = (_local2.length + 1);
                _local2.push(this.currentRunModel.entry);
            }
        }
        return ((((_local2.length > 0)) ? _local2 : _arg1));
    }

    private function removeDuplicateUser(_arg1:Vector.<ArenaLeaderboardEntry>):Vector.<ArenaLeaderboardEntry> {
        var _local3:Boolean;
        var _local4:ArenaLeaderboardEntry;
        var _local5:ArenaLeaderboardEntry;
        var _local2:int = -1;
        if (this.currentRunModel.hasEntry()) {
            _local3 = false;
            _local4 = this.currentRunModel.entry;
            for each (_local5 in _arg1) {
                if (((_local5.isPersonalRecord) && (_local4.isBetterThan(_local5)))) {
                    _local2 = (_local5.rank - 1);
                    _local3 = true;
                }
                else {
                    if (_local3) {
                        _local5.rank--;
                    }
                }
            }
        }
        if (_local2 != -1) {
            _arg1.splice(_local2, 1);
        }
        return (_arg1);
    }

    private function makeArenaEntry(_arg1:XML, _arg2:int):ArenaLeaderboardEntry {
        var _local10:PetVO;
        var _local11:XML;
        var _local3:ArenaLeaderboardEntry = new ArenaLeaderboardEntry();
        _local3.isPersonalRecord = _arg1.hasOwnProperty("IsPersonalRecord");
        _local3.runtime = _arg1.Time;
        _local3.name = _arg1.PlayData.CharacterData.Name;
        _local3.rank = ((_arg1.hasOwnProperty("Rank")) ? _arg1.Rank : _arg2);
        var _local4:int = _arg1.PlayData.CharacterData.Texture;
        var _local5:int = _arg1.PlayData.CharacterData.Class;
        var _local6:CharacterClass = this.classesModel.getCharacterClass(_local5);
        var _local7:CharacterSkin = _local6.skins.getSkin(_local4);
        var _local8:int = ((_arg1.PlayData.CharacterData.hasOwnProperty("Tex1")) ? _arg1.PlayData.CharacterData.Tex1 : 0);
        var _local9:int = ((_arg1.PlayData.CharacterData.hasOwnProperty("Tex2")) ? _arg1.PlayData.CharacterData.Tex2 : 0);
        _local3.playerBitmap = this.factory.makeIcon(_local7.template, ((_local7.is16x16) ? 50 : 100), _local8, _local9);
        _local3.equipment = ConversionUtil.toIntVector(_arg1.PlayData.CharacterData.Inventory);
        _local3.slotTypes = _local6.slotTypes;
        _local3.guildName = _arg1.PlayData.CharacterData.GuildName;
        _local3.guildRank = _arg1.PlayData.CharacterData.GuildRank;
        _local3.currentWave = _arg1.WaveNumber;
        if (_arg1.PlayData.hasOwnProperty("Pet")) {
            _local10 = new PetVO();
            _local11 = new XML(_arg1.PlayData.Pet);
            _local10.apply(_local11);
            _local3.pet = _local10;
        }
        return (_local3);
    }


}
}
