package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class SpellComparison extends SlotComparison {

    private var itemXML:XML;
    private var curItemXML:XML;
    private var projXML:XML;
    private var otherProjXML:XML;

    public function SpellComparison() {
        comparisonStringBuilder = new AppendingLineBuilder();
    }

    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        this.itemXML = _arg1;
        this.curItemXML = _arg2;
        this.projXML = _arg1.Projectile[0];
        this.otherProjXML = _arg2.Projectile[0];
        this.getDamageText();
        this.getRangeText();
        processedTags[this.projXML.toXMLString()] = true;
    }

    private function getDamageText():StringBuilder {
        var _local1:int = int(this.projXML.MinDamage);
        var _local2:int = int(this.projXML.MaxDamage);
        var _local3:int = int(this.otherProjXML.MinDamage);
        var _local4:int = int(this.otherProjXML.MaxDamage);
        var _local5:Number = ((_local1 + _local2) / 2);
        var _local6:Number = ((_local3 + _local4) / 2);
        var _local7:uint = getTextColor((_local5 - _local6));
        var _local8:String = (((_local1) == _local2) ? _local2.toString() : ((_local1 + " - ") + _local2));
        return (comparisonStringBuilder.pushParams(TextKey.DAMAGE, {"damage": (((('<font color="#' + _local7.toString(16)) + '">') + _local8) + "</font>")}));
    }

    private function getRangeText():StringBuilder {
        var _local1:Number = ((Number(this.projXML.Speed) * Number(this.projXML.LifetimeMS)) / 10000);
        var _local2:Number = ((Number(this.otherProjXML.Speed) * Number(this.otherProjXML.LifetimeMS)) / 10000);
        var _local3:uint = getTextColor((_local1 - _local2));
        return (comparisonStringBuilder.pushParams(TextKey.RANGE, {"range": (((('<font color="#' + _local3.toString(16)) + '">') + _local1) + "</font>")}));
    }


}
}
