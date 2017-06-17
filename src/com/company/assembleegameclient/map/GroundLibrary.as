package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.TextureDataConcrete;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.utils.Dictionary;

public class GroundLibrary {

    public static const propsLibrary_:Dictionary = new Dictionary();
    public static const xmlLibrary_:Dictionary = new Dictionary();
    public static const typeToTextureData_:Dictionary = new Dictionary();

    private static var tileTypeColorDict_:Dictionary = new Dictionary();
    public static var idToType_:Dictionary = new Dictionary();
    public static var defaultProps_:GroundProperties;
    public static var GROUND_CATEGORY:String = "Ground";


    public static function parseFromXML(_arg1:XML):void {
        var _local2:XML;
        var _local3:int;
        for each (_local2 in _arg1.Ground) {
            _local3 = int(_local2.@type);
            propsLibrary_[_local3] = new GroundProperties(_local2);
            xmlLibrary_[_local3] = _local2;
            typeToTextureData_[_local3] = new TextureDataConcrete(_local2);
            idToType_[String(_local2.@id)] = _local3;
        }
        defaultProps_ = propsLibrary_[0xFF];
    }

    public static function getIdFromType(_arg1:int):String {
        var _local2:GroundProperties = propsLibrary_[_arg1];
        if (_local2 == null) {
            return (null);
        }
        return (_local2.id_);
    }

    public static function getBitmapData(_arg1:int, _arg2:int = 0):BitmapData {
        return (typeToTextureData_[_arg1].getTexture(_arg2));
    }

    public static function getColor(_arg1:*):uint {
        var _local2:XML;
        var _local3:uint;
        var _local4:BitmapData;
        if (!tileTypeColorDict_.hasOwnProperty(_arg1)) {
            _local2 = xmlLibrary_[_arg1];
            if (_local2.hasOwnProperty("Color")) {
                _local3 = uint(_local2.Color);
            }
            else {
                _local4 = getBitmapData(_arg1);
                _local3 = BitmapUtil.mostCommonColor(_local4);
            }
            tileTypeColorDict_[_arg1] = _local3;
        }
        return (tileTypeColorDict_[_arg1]);
    }


}
}
