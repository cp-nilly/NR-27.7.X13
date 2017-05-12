package com.company.assembleegameclient.map.serialization {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.IntPoint;
import com.hurlant.util.Base64;

import flash.utils.ByteArray;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class MapDecoder {


    private static function get json():JsonParser {
        return (StaticInjectorContext.getInjector().getInstance(JsonParser));
    }

    public static function decodeMap(_arg1:String):Map {
        var _local2:Object = json.parse(_arg1);
        var _local3:Map = new Map(null);
        _local3.setProps(_local2["width"], _local2["height"], _local2["name"], _local2["back"], false, false);
        _local3.initialize();
        writeMapInternal(_local2, _local3, 0, 0);
        return (_local3);
    }

    public static function writeMap(_arg1:String, _arg2:Map, _arg3:int, _arg4:int):void {
        var _local5:Object = json.parse(_arg1);
        writeMapInternal(_local5, _arg2, _arg3, _arg4);
    }

    public static function getSize(_arg1:String):IntPoint {
        var _local2:Object = json.parse(_arg1);
        return (new IntPoint(_local2["width"], _local2["height"]));
    }

    private static function writeMapInternal(_arg1:Object, _arg2:Map, _arg3:int, _arg4:int):void {
        var _local7:int;
        var _local8:int;
        var _local9:Object;
        var _local10:Array;
        var _local11:int;
        var _local12:Object;
        var _local13:GameObject;
        var _local5:ByteArray = Base64.decodeToByteArray(_arg1["data"]);
        _local5.uncompress();
        var _local6:Array = _arg1["dict"];
        _local7 = _arg4;
        while (_local7 < (_arg4 + _arg1["height"])) {
            _local8 = _arg3;
            while (_local8 < (_arg3 + _arg1["width"])) {
                _local9 = _local6[_local5.readShort()];
                if (!(((((((_local8 < 0)) || ((_local8 >= _arg2.width_)))) || ((_local7 < 0)))) || ((_local7 >= _arg2.height_)))) {
                    if (_local9.hasOwnProperty("ground")) {
                        _local11 = GroundLibrary.idToType_[_local9["ground"]];
                        _arg2.setGroundTile(_local8, _local7, _local11);
                    }
                    _local10 = _local9["objs"];
                    if (_local10 != null) {
                        for each (_local12 in _local10) {
                            _local13 = getGameObject(_local12);
                            _local13.objectId_ = BasicObject.getNextFakeObjectId();
                            _arg2.addObj(_local13, (_local8 + 0.5), (_local7 + 0.5));
                        }
                    }
                }
                _local8++;
            }
            _local7++;
        }
    }

    public static function getGameObject(_arg1:Object):GameObject {
        var _local2:int = ObjectLibrary.idToType_[_arg1["id"]];
        var _local3:XML = ObjectLibrary.xmlLibrary_[_local2];
        var _local4:GameObject = ObjectLibrary.getObjectFromType(_local2);
        _local4.size_ = ((_arg1.hasOwnProperty("size")) ? _arg1["size"] : _local4.props_.getSize());
        return (_local4);
    }


}
}
