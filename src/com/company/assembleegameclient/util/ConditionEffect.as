package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;

import kabam.rotmg.text.model.TextKey;

public class ConditionEffect {

    public static const NOTHING:uint = 0;
    public static const DEAD:uint = 1;
    public static const QUIET:uint = 2;
    public static const WEAK:uint = 3;
    public static const SLOWED:uint = 4;
    public static const SICK:uint = 5;
    public static const DAZED:uint = 6;
    public static const STUNNED:uint = 7;
    public static const BLIND:uint = 8;
    public static const HALLUCINATING:uint = 9;
    public static const DRUNK:uint = 10;
    public static const CONFUSED:uint = 11;
    public static const STUN_IMMUNE:uint = 12;
    public static const INVISIBLE:uint = 13;
    public static const PARALYZED:uint = 14;
    public static const SPEEDY:uint = 15;
    public static const BLEEDING:uint = 16;
    public static const ARMORBROKENIMMUNE:uint = 17;
    public static const HEALING:uint = 18;
    public static const DAMAGING:uint = 19;
    public static const BERSERK:uint = 20;
    public static const PAUSED:uint = 21;
    public static const STASIS:uint = 22;
    public static const STASIS_IMMUNE:uint = 23;
    public static const INVINCIBLE:uint = 24;
    public static const INVULNERABLE:uint = 25;
    public static const ARMORED:uint = 26;
    public static const ARMORBROKEN:uint = 27;
    public static const HEXED:uint = 28;
    public static const NINJA_SPEEDY:uint = 29;
    public static const UNSTABLE:uint = 30;
    public static const DARKNESS:uint = 31;
    public static const SLOWED_IMMUNE:uint = 32;
    public static const DAZED_IMMUNE:uint = 33;
    public static const PARALYZED_IMMUNE:uint = 34;
    public static const PETRIFIED:uint = 35;
    public static const PETRIFIED_IMMUNE:uint = 36;
    public static const PET_EFFECT_ICON:uint = 37;
    public static const CURSE:uint = 38;
    public static const CURSE_IMMUNE:uint = 39;
    public static const HP_BOOST:uint = 40;
    public static const MP_BOOST:uint = 41;
    public static const ATT_BOOST:uint = 42;
    public static const DEF_BOOST:uint = 43;
    public static const SPD_BOOST:uint = 44;
    public static const DEX_BOOST:uint = 45;
    public static const VIT_BOOST:uint = 46;
    public static const WIS_BOOST:uint = 47;
    public static const HIDDEN:uint = 48;
    public static const MUTED:int = 49;
    public static const GROUND_DAMAGE:uint = 99;
    public static const DEAD_BIT:uint = (1 << (DEAD - 1));
    public static const QUIET_BIT:uint = (1 << (QUIET - 1));
    public static const WEAK_BIT:uint = (1 << (WEAK - 1));
    public static const SLOWED_BIT:uint = (1 << (SLOWED - 1));
    public static const SICK_BIT:uint = (1 << (SICK - 1));
    public static const DAZED_BIT:uint = (1 << (DAZED - 1));
    public static const STUNNED_BIT:uint = (1 << (STUNNED - 1));
    public static const BLIND_BIT:uint = (1 << (BLIND - 1));
    public static const HALLUCINATING_BIT:uint = (1 << (HALLUCINATING - 1));
    public static const DRUNK_BIT:uint = (1 << (DRUNK - 1));
    public static const CONFUSED_BIT:uint = (1 << (CONFUSED - 1));
    public static const STUN_IMMUNE_BIT:uint = (1 << (STUN_IMMUNE - 1));
    public static const INVISIBLE_BIT:uint = (1 << (INVISIBLE - 1));
    public static const PARALYZED_BIT:uint = (1 << (PARALYZED - 1));
    public static const SPEEDY_BIT:uint = (1 << (SPEEDY - 1));
    public static const BLEEDING_BIT:uint = (1 << (BLEEDING - 1));
    public static const ARMORBROKEN_IMMUNE_BIT:uint = (1 << (ARMORBROKENIMMUNE - 1));
    public static const HEALING_BIT:uint = (1 << (HEALING - 1));
    public static const DAMAGING_BIT:uint = (1 << (DAMAGING - 1));
    public static const BERSERK_BIT:uint = (1 << (BERSERK - 1));
    public static const PAUSED_BIT:uint = (1 << (PAUSED - 1));
    public static const STASIS_BIT:uint = (1 << (STASIS - 1));
    public static const STASIS_IMMUNE_BIT:uint = (1 << (STASIS_IMMUNE - 1));
    public static const INVINCIBLE_BIT:uint = (1 << (INVINCIBLE - 1));
    public static const INVULNERABLE_BIT:uint = (1 << (INVULNERABLE - 1));
    public static const ARMORED_BIT:uint = (1 << (ARMORED - 1));
    public static const ARMORBROKEN_BIT:uint = (1 << (ARMORBROKEN - 1));
    public static const HEXED_BIT:uint = (1 << (HEXED - 1));
    public static const NINJA_SPEEDY_BIT:uint = (1 << (NINJA_SPEEDY - 1));
    public static const UNSTABLE_BIT:uint = (1 << (UNSTABLE - 1));
    public static const DARKNESS_BIT:uint = (1 << (DARKNESS - 1));
    public static const SLOWED_IMMUNE_BIT:uint = (1 << (SLOWED_IMMUNE - NEW_CON_THREASHOLD));
    public static const DAZED_IMMUNE_BIT:uint = (1 << (DAZED_IMMUNE - NEW_CON_THREASHOLD));
    public static const PARALYZED_IMMUNE_BIT:uint = (1 << (PARALYZED_IMMUNE - NEW_CON_THREASHOLD));
    public static const PETRIFIED_BIT:uint = (1 << (PETRIFIED - NEW_CON_THREASHOLD));
    public static const PETRIFIED_IMMUNE_BIT:uint = (1 << (PETRIFIED_IMMUNE - NEW_CON_THREASHOLD));
    public static const PET_EFFECT_ICON_BIT:uint = (1 << (PET_EFFECT_ICON - NEW_CON_THREASHOLD));
    public static const CURSE_BIT:uint = (1 << (CURSE - NEW_CON_THREASHOLD));
    public static const CURSE_IMMUNE_BIT:uint = (1 << (CURSE_IMMUNE - NEW_CON_THREASHOLD));
    public static const HP_BOOST_BIT:uint = (1 << (HP_BOOST - NEW_CON_THREASHOLD));
    public static const MP_BOOST_BIT:uint = (1 << (MP_BOOST - NEW_CON_THREASHOLD));
    public static const ATT_BOOST_BIT:uint = (1 << (ATT_BOOST - NEW_CON_THREASHOLD));
    public static const DEF_BOOST_BIT:uint = (1 << (DEF_BOOST - NEW_CON_THREASHOLD));
    public static const SPD_BOOST_BIT:uint = (1 << (SPD_BOOST - NEW_CON_THREASHOLD));
    public static const VIT_BOOST_BIT:uint = (1 << (VIT_BOOST - NEW_CON_THREASHOLD));
    public static const WIS_BOOST_BIT:uint = (1 << (WIS_BOOST - NEW_CON_THREASHOLD));
    public static const DEX_BOOST_BIT:uint = (1 << (DEX_BOOST - NEW_CON_THREASHOLD));
    public static const HIDDEN_BIT:uint = (1 << (HIDDEN - NEW_CON_THREASHOLD));
    public static const MUTED_BIT:uint = (1 << (MUTED - NEW_CON_THREASHOLD));
    public static const MAP_FILTER_BITMASK:uint = DRUNK_BIT | BLIND_BIT | PAUSED_BIT;
    public static const PROJ_NOHIT_BITMASK:uint = INVINCIBLE_BIT | STASIS_BIT | PAUSED_BIT;
    public static const CE_FIRST_BATCH:uint = 0;
    public static const CE_SECOND_BATCH:uint = 1;
    public static const NUMBER_CE_BATCHES:uint = 2;
    public static const NEW_CON_THREASHOLD:uint = 32;
    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 6, 6, 2, BitmapFilterQuality.LOW, false, false);

    public static var effects_:Vector.<ConditionEffect> =
            new <ConditionEffect>[
                new ConditionEffect("Nothing", 0, null, TextKey.CONDITIONEFFECT_NOTHING),
                new ConditionEffect("Dead", DEAD_BIT, null, TextKey.CONDITIONEFFECT_DEAD),
                new ConditionEffect("Quiet", QUIET_BIT, [32], TextKey.CONDITIONEFFECT_QUIET),
                new ConditionEffect("Weak", WEAK_BIT, [34, 35, 36, 37], TextKey.CONDITIONEFFECT_WEAK),
                new ConditionEffect("Slowed", SLOWED_BIT, [1], TextKey.CONDITION_EFFECT_SLOWED),
                new ConditionEffect("Sick", SICK_BIT, [39], TextKey.CONDITIONEFFECT_SICK),
                new ConditionEffect("Dazed", DAZED_BIT, [44], TextKey.CONDITION_EFFECT_DAZED),
                new ConditionEffect("Stunned", STUNNED_BIT, [45], TextKey.CONDITIONEFFECT_STUNNED),
                new ConditionEffect("Blind", BLIND_BIT, [41], TextKey.CONDITIONEFFECT_BLIND),
                new ConditionEffect("Hallucinating", HALLUCINATING_BIT, [42], TextKey.CONDITIONEFFECT_HALLUCINATING),
                new ConditionEffect("Drunk", DRUNK_BIT, [43], TextKey.CONDITIONEFFECT_DRUNK),
                new ConditionEffect("Confused", CONFUSED_BIT, [2], TextKey.CONDITIONEFFECT_CONFUSED),
                new ConditionEffect("Stun Immune", STUN_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_STUN_IMMUNE),
                new ConditionEffect("Invisible", INVISIBLE_BIT, null, TextKey.CONDITIONEFFECT_INVISIBLE),
                new ConditionEffect("Paralyzed", PARALYZED_BIT, [53, 54], TextKey.CONDITION_EFFECT_PARALYZED),
                new ConditionEffect("Speedy", SPEEDY_BIT, [0], TextKey.CONDITIONEFFECT_SPEEDY),
                new ConditionEffect("Bleeding", BLEEDING_BIT, [46], TextKey.CONDITIONEFFECT_BLEEDING),
                new ConditionEffect("Armor Broken Immune", ARMORBROKEN_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_ARMOR_BROKEN_IMMUNE),
                new ConditionEffect("Healing", HEALING_BIT, [47], TextKey.CONDITIONEFFECT_HEALING),
                new ConditionEffect("Damaging", DAMAGING_BIT, [49], TextKey.CONDITIONEFFECT_DAMAGING),
                new ConditionEffect("Berserk", BERSERK_BIT, [50], TextKey.CONDITIONEFFECT_BERSERK),
                new ConditionEffect("Paused", PAUSED_BIT, null, TextKey.CONDITIONEFFECT_PAUSED),
                new ConditionEffect("Stasis", STASIS_BIT, null, TextKey.CONDITIONEFFECT_STASIS),
                new ConditionEffect("Stasis Immune", STASIS_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_STASIS_IMMUNE),
                new ConditionEffect("Invincible", INVINCIBLE_BIT, null, TextKey.CONDITIONEFFECT_INVINCIBLE),
                new ConditionEffect("Invulnerable", INVULNERABLE_BIT, [17], TextKey.CONDITIONEFFECT_INVULNERABLE),
                new ConditionEffect("Armored", ARMORED_BIT, [16], TextKey.CONDITIONEFFECT_ARMORED),
                new ConditionEffect("Armor Broken", ARMORBROKEN_BIT, [55], TextKey.CONDITIONEFFECT_ARMOR_BROKEN),
                new ConditionEffect("Hexed", HEXED_BIT, [42], TextKey.CONDITIONEFFECT_HEXED),
                new ConditionEffect("Ninja Speedy", NINJA_SPEEDY_BIT, [0], TextKey.CONDITIONEFFECT_NINJA_SPEEDY),
                new ConditionEffect("Unstable", UNSTABLE_BIT, [56], TextKey.CONDITIONEFFECT_UNSTABLE),
                new ConditionEffect("Darkness", DARKNESS_BIT, [57], TextKey.CONDITIONEFFECT_DARKNESS),
                new ConditionEffect("Slowed Immune", SLOWED_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_SLOWIMMUNE),
                new ConditionEffect("Dazed Immune", DAZED_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_DAZEDIMMUNE),
                new ConditionEffect("Paralyzed Immune", PARALYZED_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_PARALYZEDIMMUNE),
                new ConditionEffect("Petrify", PETRIFIED_BIT, null, TextKey.CONDITIONEFFECT_PETRIFIED),
                new ConditionEffect("Petrify Immune", PETRIFIED_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_PETRIFY_IMMUNE),
                new ConditionEffect("Pet Disable", PET_EFFECT_ICON_BIT, [27], TextKey.CONDITIONEFFECT_STASIS, true),
                new ConditionEffect("Curse", CURSE_BIT, [58], TextKey.CONDITIONEFFECT_CURSE),
                new ConditionEffect("Curse Immune", CURSE_IMMUNE_BIT, null, TextKey.CONDITIONEFFECT_CURSE_IMMUNE),
                new ConditionEffect("HP Boost", HP_BOOST_BIT, [32], "HP Boost", true),
                new ConditionEffect("MP Boost", MP_BOOST_BIT, [33], "MP Boost", true),
                new ConditionEffect("Att Boost", ATT_BOOST_BIT, [34], "Att Boost", true),
                new ConditionEffect("Def Boost", DEF_BOOST_BIT, [35], "Def Boost", true),
                new ConditionEffect("Spd Boost", SPD_BOOST_BIT, [36], "Spd Boost", true),
                new ConditionEffect("Vit Boost", VIT_BOOST_BIT, [38], "Vit Boost", true),
                new ConditionEffect("Wis Boost", WIS_BOOST_BIT, [39], "Wis Boost", true),
                new ConditionEffect("Dex Boost", DEX_BOOST_BIT, [37], "Dex Boost", true),
                new ConditionEffect("Hidden", HIDDEN_BIT, [27], "Hidden", true),
                new ConditionEffect("Muted", MUTED_BIT, [21], "Muted", true)
            ];
    
    private static var conditionEffectFromName_:Object = null;
    private static var effectIconCache:Object = null;
    private static var bitToIcon_:Object = null;
    private static var bitToIcon2_:Object = null;

    public var name_:String;
    public var bit_:uint;
    public var iconOffsets_:Array;
    public var localizationKey_:String;
    public var icon16Bit_:Boolean;

    public function ConditionEffect(_arg1:String, _arg2:uint, _arg3:Array, _arg4:String = "", _arg5:Boolean = false) {
        this.name_ = _arg1;
        this.bit_ = _arg2;
        this.iconOffsets_ = _arg3;
        this.localizationKey_ = _arg4;
        this.icon16Bit_ = _arg5;
    }

    public static function getConditionEffectFromName(_arg1:String):uint {
        var _local2:uint;
        if (conditionEffectFromName_ == null) {
            conditionEffectFromName_ = new Object();
            _local2 = 0;
            while (_local2 < effects_.length) {
                conditionEffectFromName_[effects_[_local2].name_] = _local2;
                _local2++;
            }
        }
        return (conditionEffectFromName_[_arg1]);
    }

    public static function getConditionEffectEnumFromName(_arg1:String):ConditionEffect {
        var _local2:ConditionEffect;
        for each (_local2 in effects_) {
            if (_local2.name_ == _arg1) {
                return (_local2);
            }
        }
        return (null);
    }

    public static function getConditionEffectIcons(_arg1:uint, _arg2:Vector.<BitmapData>, _arg3:int):void {
        var _local4:uint;
        var _local5:uint;
        var _local6:Vector.<BitmapData>;
        while (_arg1 != 0) {
            _local4 = (_arg1 & (_arg1 - 1));
            _local5 = (_arg1 ^ _local4);
            _local6 = getIconsFromBit(_local5);
            if (_local6 != null) {
                _arg2.push(_local6[(_arg3 % _local6.length)]);
            }
            _arg1 = _local4;
        }
    }

    public static function getConditionEffectIcons2(_arg1:uint, _arg2:Vector.<BitmapData>, _arg3:int):void {
        var _local4:uint;
        var _local5:uint;
        var _local6:Vector.<BitmapData>;
        while (_arg1 != 0) {
            _local4 = (_arg1 & (_arg1 - 1));
            _local5 = (_arg1 ^ _local4);
            _local6 = getIconsFromBit2(_local5);
            if (_local6 != null) {
                _arg2.push(_local6[(_arg3 % _local6.length)]);
            }
            _arg1 = _local4;
        }
    }

    public static function addConditionEffectIcon(_arg1:Vector.<BitmapData>, _arg2:int, _arg3:Boolean):void {
        var _local4:BitmapData;
        var _local5:Matrix;
        var _local6:Matrix;
        if (effectIconCache == null) {
            effectIconCache = {};
        }
        if (effectIconCache[_arg2]) {
            _local4 = effectIconCache[_arg2];
        }
        else {
            _local5 = new Matrix();
            _local5.translate(4, 4);
            _local6 = new Matrix();
            _local6.translate(1.5, 1.5);
            if (_arg3) {
                _local4 = new BitmapDataSpy(18, 18, true, 0);
                _local4.draw(AssetLibrary.getImageFromSet("lofiInterfaceBig", _arg2), _local6);
            }
            else {
                _local4 = new BitmapDataSpy(16, 16, true, 0);
                _local4.draw(AssetLibrary.getImageFromSet("lofiInterface2", _arg2), _local5);
            }
            _local4 = GlowRedrawer.outlineGlow(_local4, 0xFFFFFFFF);
            _local4.applyFilter(_local4, _local4.rect, PointUtil.ORIGIN, GLOW_FILTER);
            effectIconCache[_arg2] = _local4;
        }
        _arg1.push(_local4);
    }

    private static function getIconsFromBit(_arg1:uint):Vector.<BitmapData> {
        var _local2:Matrix;
        var _local3:uint;
        var _local4:Vector.<BitmapData>;
        var _local5:int;
        var _local6:BitmapData;
        if (bitToIcon_ == null) {
            bitToIcon_ = new Object();
            _local2 = new Matrix();
            _local2.translate(4, 4);
            _local3 = 0;
            while (_local3 < 32) {
                _local4 = null;
                if (effects_[_local3].iconOffsets_ != null) {
                    _local4 = new Vector.<BitmapData>();
                    _local5 = 0;
                    while (_local5 < effects_[_local3].iconOffsets_.length) {
                        _local6 = new BitmapDataSpy(16, 16, true, 0);
                        _local6.draw(AssetLibrary.getImageFromSet("lofiInterface2", effects_[_local3].iconOffsets_[_local5]), _local2);
                        _local6 = GlowRedrawer.outlineGlow(_local6, 0xFFFFFFFF);
                        _local6.applyFilter(_local6, _local6.rect, PointUtil.ORIGIN, GLOW_FILTER);
                        _local4.push(_local6);
                        _local5++;
                    }
                }
                bitToIcon_[effects_[_local3].bit_] = _local4;
                _local3++;
            }
        }
        return (bitToIcon_[_arg1]);
    }

    private static function getIconsFromBit2(_arg1:uint):Vector.<BitmapData> {
        var _local2:Vector.<BitmapData>;
        var _local3:BitmapData;
        var _local4:Matrix;
        var _local5:Matrix;
        var _local6:uint;
        var _local7:int;
        if (bitToIcon2_ == null) {
            bitToIcon2_ = [];
            _local2 = new Vector.<BitmapData>();
            _local4 = new Matrix();
            _local4.translate(4, 4);
            _local5 = new Matrix();
            _local5.translate(1.5, 1.5);
            _local6 = 32;
            while (_local6 < effects_.length) {
                _local2 = null;
                if (effects_[_local6].iconOffsets_ != null) {
                    _local2 = new Vector.<BitmapData>();
                    _local7 = 0;
                    while (_local7 < effects_[_local6].iconOffsets_.length) {
                        if (effects_[_local6].icon16Bit_) {
                            _local3 = new BitmapDataSpy(18, 18, true, 0);
                            _local3.draw(AssetLibrary.getImageFromSet("lofiInterfaceBig", effects_[_local6].iconOffsets_[_local7]), _local5);
                        }
                        else {
                            _local3 = new BitmapDataSpy(16, 16, true, 0);
                            _local3.draw(AssetLibrary.getImageFromSet("lofiInterface2", effects_[_local6].iconOffsets_[_local7]), _local4);
                        }
                        _local3 = GlowRedrawer.outlineGlow(_local3, 0xFFFFFFFF);
                        _local3.applyFilter(_local3, _local3.rect, PointUtil.ORIGIN, GLOW_FILTER);
                        _local2.push(_local3);
                        _local7++;
                    }
                }
                bitToIcon2_[effects_[_local6].bit_] = _local2;
                _local6++;
            }
        }
        if (((!((bitToIcon2_ == null))) && (!((bitToIcon2_[_arg1] == null))))) {
            return (bitToIcon2_[_arg1]);
        }
        return (null);
    }


}
}
