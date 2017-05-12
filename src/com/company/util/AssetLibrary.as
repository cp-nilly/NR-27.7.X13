package com.company.util {
import flash.display.BitmapData;
import flash.media.Sound;
import flash.media.SoundTransform;
import flash.utils.Dictionary;

public class AssetLibrary {

    private static var images_:Dictionary = new Dictionary();
    private static var imageSets_:Dictionary = new Dictionary();
    private static var sounds_:Dictionary = new Dictionary();
    private static var imageLookup_:Dictionary = new Dictionary();

    public function AssetLibrary(_arg1:StaticEnforcer) {
    }

    public static function addImage(_arg1:String, _arg2:BitmapData):void {
        images_[_arg1] = _arg2;
        imageLookup_[_arg2] = _arg1;
    }

    public static function addImageSet(_arg1:String, _arg2:BitmapData, _arg3:int, _arg4:int):void {
        images_[_arg1] = _arg2;
        var _local5:ImageSet = new ImageSet();
        _local5.addFromBitmapData(_arg2, _arg3, _arg4);
        imageSets_[_arg1] = _local5;
        var _local6:int;
        while (_local6 < _local5.images_.length) {
            imageLookup_[_local5.images_[_local6]] = [_arg1, _local6];
            _local6++;
        }
    }

    public static function addToImageSet(_arg1:String, _arg2:BitmapData):void {
        var _local3:ImageSet = imageSets_[_arg1];
        if (_local3 == null) {
            _local3 = new ImageSet();
            imageSets_[_arg1] = _local3;
        }
        _local3.add(_arg2);
        var _local4:int = (_local3.images_.length - 1);
        imageLookup_[_local3.images_[_local4]] = [_arg1, _local4];
    }

    public static function addSound(_arg1:String, _arg2:Class):void {
        var _local3:Array = sounds_[_arg1];
        if (_local3 == null) {
            sounds_[_arg1] = new Array();
        }
        sounds_[_arg1].push(_arg2);
    }

    public static function lookupImage(_arg1:BitmapData):Object {
        return (imageLookup_[_arg1]);
    }

    public static function getImage(_arg1:String):BitmapData {
        return (images_[_arg1]);
    }

    public static function getImageSet(_arg1:String):ImageSet {
        return (imageSets_[_arg1]);
    }

    public static function getImageFromSet(_arg1:String, _arg2:int):BitmapData {
        var _local3:ImageSet = imageSets_[_arg1];
        return (_local3.images_[_arg2]);
    }

    public static function getSound(_arg1:String):Sound {
        var _local2:Array = sounds_[_arg1];
        var _local3:int = (Math.random() * _local2.length);
        return (new (sounds_[_arg1][_local3])());
    }

    public static function playSound(_arg1:String, _arg2:Number = 1):void {
        var _local3:Array = sounds_[_arg1];
        var _local4:int = (Math.random() * _local3.length);
        var _local5:Sound = new (sounds_[_arg1][_local4])();
        var _local6:SoundTransform;
        if (_arg2 != 1) {
            _local6 = new SoundTransform(_arg2);
        }
        _local5.play(0, 0, _local6);
    }


}
}
class StaticEnforcer {


}

