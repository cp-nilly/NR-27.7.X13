package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

public class GroupDivider {

    public static const GROUP_LABELS:Vector.<String> = new <String>["Ground", "Basic Objects", "Enemies", "Walls", "3D Objects", "All Objects", "Regions", "Dungeons"];

    public static var GROUPS:Dictionary = new Dictionary(true);
    public static var DEFAULT_DUNGEON:String = "AbyssOfDemons";
    public static var HIDE_OBJECTS_IDS:Vector.<String> = new <String>["Gothic Wiondow Light", "Statue of Oryx Base", "AbyssExitGuarder", "AbyssIdolDead", "AbyssTreasureLavaBomb", "Area 1 Controller", "Area 2 Controller", "Area 3 Controller", "Area 4 Controller", "Area 5 Controller", "Arena Horseman Anchor", "FireMakerUp", "FireMakerLf", "FireMakerRt", "FireMakerDn", "Group Wall Observer", "LavaTrigger", "Mad Gas Controller", "Mad Lab Open Wall", "Maggot Sack", "NM Black Open Wall", "NM Blue Open Wall", "NM Green Open Wall", "NM Red Open Wall", "NM Green Dragon Shield Counter", "NM Green Dragon Shield Counter Deux", "NM Red Dragon Lava Bomb", "NM Red Dragon Lava Trigger", "Pirate King Healer", "Puppet Theatre Boss Spawn", "Puppet Treasure Chest", "Skuld Apparition", "Sorc Bomb Thrower", "Tempest Cloud", "Treasure Dropper", "Treasure Flame Trap 1.7 Sec", "Treasure Flame Trap 1.2 Sec", "Zombie Rise", "destnex Observer 1", "destnex Observer 2", "destnex Observer 3", "destnex Observer 4", "drac floor black", "drac floor blue", "drac floor green", "drac floor red", "drac wall black", "drac wall blue", "drac wall red", "drac wall green", "ic boss manager", "ic boss purifier generator", "ic boss spawner live", "md1 Governor", "md1 Lava Makers", "md1 Left Burst", "md1 Right Burst", "md1 Mid Burst", "md1 Left Hand spawner", "md1 Right Hand spawner", "md1 RightHandSmash", "md1 LeftHandSmash", "shtrs Add Lava", "shtrs Bird Check", "shtrs BirdSpawn 1", "shtrs BirdSpawn 2", "shtrs Bridge Closer", "shtrs Mage Closer 1", "shtrs Monster Cluster", "shtrs Mage Bridge Check", "shtrs Bridge Review Board", "shtrs Crystal Check", "shtrs Final Fight Check", "shtrs Final Mediator Lava", "shtrs KillWall 1", "shtrs KillWall 2", "shtrs KillWall 3", "shtrs KillWall 4", "shtrs KillWall 5", "shtrs KillWall 6", "shtrs KillWall 7", "shtrs Laser1", "shtrs Laser2", "shtrs Laser3", "shtrs Laser4", "shtrs Laser5", "shtrs Laser6", "shtrs Pause Watcher", "shtrs Player Check", "shtrs Player Check Archmage", "shtrs Spawn Bridge", "shtrs The Cursed Crown", "shtrs blobomb maker", "shtrs portal maker", "vlntns Governor", "vlntns Planter"];


    public static function divideObjects():void {
        var _local9:int;
        var _local10:String;
        var _local11:Boolean;
        var _local12:XML;
        var _local13:XML;
        var _local14:PlayerModel;
        var _local15:String;
        var _local16:XML;
        var _local1:Dictionary = new Dictionary(true);
        var _local2:Dictionary = new Dictionary(true);
        var _local3:Dictionary = new Dictionary(true);
        var _local4:Dictionary = new Dictionary(true);
        var _local5:Dictionary = new Dictionary(true);
        var _local6:Dictionary = new Dictionary(true);
        var _local7:Dictionary = new Dictionary(true);
        var _local8:Dictionary = new Dictionary(true);
        for each (_local12 in ObjectLibrary.xmlLibrary_) {
            _local10 = _local12.@id;
            _local9 = int(_local12.@type);
            _local14 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if (!((((((((((_local12.hasOwnProperty("Item")) || (_local12.hasOwnProperty("Player")))) || ((_local12.Class == "Projectile")))) || ((_local12.Class == "PetSkin")))) || ((_local12.Class == "Pet")))) || ((((_local10.search("Spawner") >= 0)) && (!(_local14.isAdmin())))))) {
                if (!((!(_local14.isAdmin())) && ((HIDE_OBJECTS_IDS.indexOf(_local10) >= 0)))) {
                    _local11 = false;
                    if (((_local12.hasOwnProperty("Class")) && (String(_local12.Class).match(/wall$/i)))) {
                        _local6[_local9] = _local12;
                        _local7[_local9] = _local12;
                        _local11 = true;
                    }
                    else {
                        if (_local12.hasOwnProperty("Model")) {
                            _local5[_local9] = _local12;
                            _local7[_local9] = _local12;
                            _local11 = true;
                        }
                        else {
                            if (_local12.hasOwnProperty("Enemy")) {
                                _local4[_local9] = _local12;
                                _local7[_local9] = _local12;
                                _local11 = true;
                            }
                            else {
                                if (((_local12.hasOwnProperty("Static")) && (!(_local12.hasOwnProperty("Price"))))) {
                                    _local3[_local9] = _local12;
                                    _local7[_local9] = _local12;
                                    _local11 = true;
                                }
                                else {
                                    if (_local14.isAdmin()) {
                                        _local7[_local9] = _local12;
                                    }
                                }
                            }
                        }
                    }
                    _local15 = ObjectLibrary.propsLibrary_[_local9].belonedDungeon;
                    if (((_local11) && (!((_local15 == ""))))) {
                        if (_local8[_local15] == null) {
                            _local8[_local15] = new Dictionary(true);
                        }
                        _local8[_local15][_local9] = _local12;
                    }
                }
            }
        }
        for each (_local13 in GroundLibrary.xmlLibrary_) {
            _local1[int(_local13.@type)] = _local13;
        }
        if (_local14.isAdmin()) {
            for each (_local16 in RegionLibrary.xmlLibrary_) {
                _local2[int(_local16.@type)] = _local16;
            }
        }
        else {
            _local2[RegionLibrary.idToType_["Spawn"]] = RegionLibrary.xmlLibrary_[RegionLibrary.idToType_["Spawn"]];
            _local2[RegionLibrary.idToType_["User Dungeon End"]] = RegionLibrary.xmlLibrary_[RegionLibrary.idToType_["User Dungeon End"]];
        }
        GROUPS[GROUP_LABELS[0]] = _local1;
        GROUPS[GROUP_LABELS[1]] = _local3;
        GROUPS[GROUP_LABELS[2]] = _local4;
        GROUPS[GROUP_LABELS[3]] = _local6;
        GROUPS[GROUP_LABELS[4]] = _local5;
        GROUPS[GROUP_LABELS[5]] = _local7;
        GROUPS[GROUP_LABELS[6]] = _local2;
        GROUPS[GROUP_LABELS[7]] = _local8;
    }

    public static function getDungeonsLabel():Vector.<String> {
        var _local2:String;
        var _local1:Vector.<String> = new Vector.<String>();
        for (_local2 in ObjectLibrary.dungeonsXMLLibrary_) {
            _local1.push(_local2);
        }
        _local1.sort(MoreStringUtil.cmp);
        return (_local1);
    }

    public static function getDungeonsXML(_arg1:String):Dictionary {
        return (GROUPS[GROUP_LABELS[7]][_arg1]);
    }

    public static function getCategoryByType(_arg1:int, _arg2:int):String {
        var _local4:XML;
        var _local3:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
        if (_arg2 == Layer.REGION) {
            return (GROUP_LABELS[6]);
        }
        if (_arg2 == Layer.GROUND) {
            return (GROUP_LABELS[0]);
        }
        if (_local3.isAdmin()) {
            return (GROUP_LABELS[5]);
        }
        _local4 = ObjectLibrary.xmlLibrary_[_arg1];
        if (((((((((_local4.hasOwnProperty("Item")) || (_local4.hasOwnProperty("Player")))) || ((_local4.Class == "Projectile")))) || ((_local4.Class == "PetSkin")))) || ((_local4.Class == "Pet")))) {
            return ("");
        }
        if (_local4.hasOwnProperty("Enemy")) {
            return (GROUP_LABELS[2]);
        }
        if (_local4.hasOwnProperty("Model")) {
            return (GROUP_LABELS[4]);
        }
        if (((_local4.hasOwnProperty("Class")) && (String(_local4.Class).match(/wall$/i)))) {
            return (GROUP_LABELS[3]);
        }
        if (((_local4.hasOwnProperty("Static")) && (!(_local4.hasOwnProperty("Price"))))) {
            return (GROUP_LABELS[1]);
        }
        return ("");
    }


}
}
