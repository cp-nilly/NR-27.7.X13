package com.company.assembleegameclient.util {
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

import kabam.rotmg.text.model.TextKey;

public class GuildUtil {

    public static const INITIATE:int = 0;
    public static const MEMBER:int = 10;
    public static const OFFICER:int = 20;
    public static const LEADER:int = 30;
    public static const FOUNDER:int = 40;
    public static const MAX_MEMBERS:int = 50;


    public static function rankToString(_arg1:int):String {
        switch (_arg1) {
            case INITIATE:
                return (wrapInBraces(TextKey.GUILD_RANK_INITIATE));
            case MEMBER:
                return (wrapInBraces(TextKey.GUILD_RANK_MEMBER));
            case OFFICER:
                return (wrapInBraces(TextKey.GUILD_RANK_OFFICER));
            case LEADER:
                return (wrapInBraces(TextKey.GUILD_RANK_LEADER));
            case FOUNDER:
                return (wrapInBraces(TextKey.GUILD_RANK_FOUNDER));
        }
        return (wrapInBraces(TextKey.GUILD_RANK_UNKNOWN));
    }

    private static function wrapInBraces(_arg1:String):String {
        return ((("{" + _arg1) + "}"));
    }

    public static function rankToIcon(_arg1:int, _arg2:int):BitmapData {
        var _local3:BitmapData;
        switch (_arg1) {
            case INITIATE:
                _local3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 20);
                break;
            case MEMBER:
                _local3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 19);
                break;
            case OFFICER:
                _local3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 18);
                break;
            case LEADER:
                _local3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 17);
                break;
            case FOUNDER:
                _local3 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 16);
                break;
        }
        return (TextureRedrawer.redraw(_local3, _arg2, true, 0, true));
    }

    public static function guildFameIcon(_arg1:int):BitmapData {
        var _local2:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 226);
        return (TextureRedrawer.redraw(_local2, _arg1, true, 0, true));
    }

    public static function allowedChange(_arg1:int, _arg2:int, _arg3:int):Boolean {
        if (_arg2 == _arg3) {
            return (false);
        }
        if ((((((_arg1 == FOUNDER)) && ((_arg2 < FOUNDER)))) && ((_arg3 < FOUNDER)))) {
            return (true);
        }
        if ((((((_arg1 == LEADER)) && ((_arg2 < LEADER)))) && ((_arg3 <= LEADER)))) {
            return (true);
        }
        if ((((((_arg1 == OFFICER)) && ((_arg2 < OFFICER)))) && ((_arg3 < OFFICER)))) {
            return (true);
        }
        return (false);
    }

    public static function promotedRank(_arg1:int):int {
        switch (_arg1) {
            case INITIATE:
                return (MEMBER);
            case MEMBER:
                return (OFFICER);
            case OFFICER:
                return (LEADER);
        }
        return (FOUNDER);
    }

    public static function canPromote(_arg1:int, _arg2:int):Boolean {
        var _local3:int = promotedRank(_arg2);
        return (allowedChange(_arg1, _arg2, _local3));
    }

    public static function demotedRank(_arg1:int):int {
        switch (_arg1) {
            case OFFICER:
                return (MEMBER);
            case LEADER:
                return (OFFICER);
            case FOUNDER:
                return (LEADER);
        }
        return (INITIATE);
    }

    public static function canDemote(_arg1:int, _arg2:int):Boolean {
        var _local3:int = demotedRank(_arg2);
        return (allowedChange(_arg1, _arg2, _local3));
    }

    public static function canRemove(_arg1:int, _arg2:int):Boolean {
        return ((((_arg1 >= OFFICER)) && ((_arg2 < _arg1))));
    }


}
}
