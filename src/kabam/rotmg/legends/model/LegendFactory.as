package kabam.rotmg.legends.model {
import com.company.util.ConversionUtil;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;

public class LegendFactory {

    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var factory:CharacterFactory;
    private var ownAccountId:String;
    private var legends:Vector.<Legend>;


    public function makeLegends(_arg1:XML):Vector.<Legend> {
        this.ownAccountId = this.playerModel.getAccountId();
        this.legends = new <Legend>[];
        this.makeLegendsFromList(_arg1.FameListElem, false);
        this.makeLegendsFromList(_arg1.MyFameListElem, true);
        return (this.legends);
    }

    private function makeLegendsFromList(_arg1:XMLList, _arg2:Boolean):void {
        var _local3:XML;
        var _local4:Legend;
        for each (_local3 in _arg1) {
            if (!this.legendsContains(_local3)) {
                _local4 = this.makeLegend(_local3);
                _local4.isOwnLegend = (_local3.@accountId == this.ownAccountId);
                _local4.isFocus = _arg2;
                this.legends.push(_local4);
            }
        }
    }

    private function legendsContains(_arg1:XML):Boolean {
        var _local2:Legend;
        for each (_local2 in this.legends) {
            if ((((_local2.accountId == _arg1.@accountId)) && ((_local2.charId == _arg1.@charId)))) {
                return (true);
            }
        }
        return (false);
    }

    public function makeLegend(_arg1:XML):Legend {
        var _local2:int = _arg1.ObjectType;
        var _local3:int = _arg1.Texture;
        var _local4:CharacterClass = this.classesModel.getCharacterClass(_local2);
        var _local5:CharacterSkin = _local4.skins.getSkin(_local3);
        var _local6:int = ((_arg1.hasOwnProperty("Tex1")) ? _arg1.Tex1 : 0);
        var _local7:int = ((_arg1.hasOwnProperty("Tex2")) ? _arg1.Tex2 : 0);
        var _local8:int = ((_local5.is16x16) ? 50 : 100);
        var _local9:Legend = new Legend();
        _local9.accountId = _arg1.@accountId;
        _local9.charId = _arg1.@charId;
        _local9.name = _arg1.Name;
        _local9.totalFame = _arg1.TotalFame;
        _local9.character = this.factory.makeIcon(_local5.template, _local8, _local6, _local7);
        _local9.equipmentSlots = _local4.slotTypes;
        _local9.equipment = ConversionUtil.toIntVector(_arg1.Equipment);
        return (_local9);
    }


}
}
