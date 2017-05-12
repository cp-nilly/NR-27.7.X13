package com.company.assembleegameclient.map {
import flash.utils.Dictionary;

public class RegionLibrary {

    public static const xmlLibrary_:Dictionary = new Dictionary();
    public static const ENTRY_REGION_TYPE:uint = 1;
    public static const EXIT_REGION_TYPE:uint = 48;

    public static var idToType_:Dictionary = new Dictionary();


    public static function parseFromXML(_arg1:XML):void {
        var _local2:XML;
        var _local3:int;
        for each (_local2 in _arg1.Region) {
            _local3 = int(_local2.@type);
            xmlLibrary_[_local3] = _local2;
            idToType_[String(_local2.@id)] = _local3;
        }
    }

    public static function getIdFromType(_arg1:int):String {
        var _local2:XML = xmlLibrary_[_arg1];
        if (_local2 == null) {
            return (null);
        }
        return (String(_local2.@id));
    }

    public static function getColor(_arg1:int):uint {
        var _local2:XML = xmlLibrary_[_arg1];
        if (_local2 == null) {
            return (0);
        }
        return (uint(_local2.Color));
    }


}
}
