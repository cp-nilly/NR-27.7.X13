package com.company.assembleegameclient.util {
import flash.utils.Dictionary;

public class FreeList {

    private static var dict_:Dictionary = new Dictionary();


    public static function newObject(_arg1:Class):Object {
        var _local2:Vector.<Object> = dict_[_arg1];
        if (_local2 == null) {
            _local2 = new Vector.<Object>();
            dict_[_arg1] = _local2;
        }
        else {
            if (_local2.length > 0) {
                return (_local2.pop());
            }
        }
        return (new (_arg1)());
    }

    public static function storeObject(_arg1:*, _arg2:Object):void {
        var _local3:Vector.<Object> = dict_[_arg1];
        if (_local3 == null) {
            _local3 = new Vector.<Object>();
            dict_[_arg1] = _local3;
        }
        _local3.push(_arg2);
    }

    public static function getObject(_arg1:*):Object {
        var _local2:Vector.<Object> = dict_[_arg1];
        if (((!((_local2 == null))) && ((_local2.length > 0)))) {
            return (_local2.pop());
        }
        return (null);
    }

    public static function dump(_arg1:*):void {
        delete dict_[_arg1];
    }

    public static function deleteObject(_arg1:Object):void {
        var _local2:Class = Object(_arg1).constructor;
        var _local3:Vector.<Object> = dict_[_local2];
        if (_local3 == null) {
            _local3 = new Vector.<Object>();
            dict_[_local2] = _local3;
        }
        _local3.push(_arg1);
    }


}
}
