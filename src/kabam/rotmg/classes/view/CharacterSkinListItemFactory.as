package kabam.rotmg.classes.view {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.Currency;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkins;
import kabam.rotmg.util.components.LegacyBuyButton;

public class CharacterSkinListItemFactory {

    [Inject]
    public var characters:CharacterFactory;


    public function make(_arg1:CharacterSkins):Vector.<DisplayObject> {
        var _local2:Vector.<CharacterSkin>;
        var _local3:int;
        _local2 = _arg1.getListedSkins();
        _local3 = _local2.length;
        var _local4:Vector.<DisplayObject> = new Vector.<DisplayObject>(_local3, true);
        var _local5:int;
        while (_local5 < _local3) {
            _local4[_local5] = this.makeCharacterSkinTile(_local2[_local5]);
            _local5++;
        }
        return (_local4);
    }

    private function makeCharacterSkinTile(_arg1:CharacterSkin):CharacterSkinListItem {
        var _local2:CharacterSkinListItem = new CharacterSkinListItem();
        _local2.setSkin(this.makeIcon(_arg1));
        _local2.setModel(_arg1);
        _local2.setLockIcon(AssetLibrary.getImageFromSet("lofiInterface2", 5));
        _local2.setBuyButton(this.makeBuyButton());
        return (_local2);
    }

    private function makeBuyButton():LegacyBuyButton {
        return (new LegacyBuyButton("", 16, 0, Currency.GOLD));
    }

    private function makeIcon(_arg1:CharacterSkin):Bitmap {
        var _local2:int = (((Parameters.skinTypes16.indexOf(_arg1.id)) != -1) ? 50 : 100);
        var _local3:BitmapData = this.characters.makeIcon(_arg1.template, _local2);
        return (new Bitmap(_local3));
    }


}
}
