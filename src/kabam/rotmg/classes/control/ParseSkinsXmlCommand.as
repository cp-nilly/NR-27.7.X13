package kabam.rotmg.classes.control {
import com.company.assembleegameclient.objects.ObjectLibrary;

import kabam.rotmg.assets.EmbeddedData;
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;

public class ParseSkinsXmlCommand {

    [Inject]
    public var model:ClassesModel;


    private static function parseNodeEquipment(_arg1:XML):void {
        var _local2:XMLList;
        var _local3:XML;
        var _local4:int;
        var _local5:int;
        _local2 = _arg1.children();
        for each (_local3 in _local2) {
            if (_local3.attribute("skinType").length() != 0) {
                _local4 = int(_local3.@skinType);
                _local5 = 0xFFD700;
                if (_local3.attribute("color").length() != 0) {
                    _local5 = int(_local3.@color);
                }
                ObjectLibrary.skinSetXMLDataLibrary_[_local4] = _local3;
            }
        }
    }


    public function execute():void {
        var _local1:XML;
        var _local2:XMLList;
        var _local3:XML;
        _local1 = EmbeddedData.skinsXML;
        _local2 = _local1.children();
        for each (_local3 in _local2) {
            this.parseNode(_local3);
        }
        _local1 = EmbeddedData.skinsEquipmentSetsXML;
        _local2 = _local1.children();
        for each (_local3 in _local2) {
            parseNodeEquipment(_local3);
        }
    }

    private function parseNode(_arg1:XML):void {
        var _local2:String = _arg1.AnimatedTexture.File;
        var _local3:int = _arg1.AnimatedTexture.Index;
        var _local4:CharacterSkin = new CharacterSkin();
        _local4.id = _arg1.@type;
        _local4.name = (((_arg1.DisplayId == undefined)) ? _arg1.@id : _arg1.DisplayId);
        _local4.unlockLevel = _arg1.UnlockLevel;
        if (_arg1.hasOwnProperty("NoSkinSelect")) {
            _local4.skinSelectEnabled = false;
        }
        if (_arg1.hasOwnProperty("UnlockSpecial")) {
            _local4.unlockSpecial = _arg1.UnlockSpecial;
        }
        _local4.template = new CharacterTemplate(_local2, _local3);
        if (_local2.indexOf("16") >= 0) {
            _local4.is16x16 = true;
        }
        var _local5:CharacterClass = this.model.getCharacterClass(_arg1.PlayerClassType);
        _local5.skins.addSkin(_local4);
    }


}
}
