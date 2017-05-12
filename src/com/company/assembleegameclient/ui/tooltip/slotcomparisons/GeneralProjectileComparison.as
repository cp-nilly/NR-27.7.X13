package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class GeneralProjectileComparison extends SlotComparison {

    private var itemXML:XML;
    private var curItemXML:XML;
    private var projXML:XML;
    private var otherProjXML:XML;


    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        this.itemXML = _arg1;
        this.curItemXML = _arg2;
        comparisonStringBuilder = new AppendingLineBuilder();
        if (_arg1.hasOwnProperty("NumProjectiles")) {
            this.addNumProjectileText();
            processedTags[_arg1.NumProjectiles.toXMLString()] = true;
        }
        if (_arg1.hasOwnProperty("Projectile")) {
            this.addProjectileText();
            processedTags[_arg1.Projectile.toXMLString()] = true;
        }
        this.buildRateOfFireText();
    }

    private function addProjectileText():void {
        this.addDamageText();
        var _local1:Number = ((Number(this.projXML.Speed) * Number(this.projXML.LifetimeMS)) / 10000);
        var _local2:Number = ((Number(this.otherProjXML.Speed) * Number(this.otherProjXML.LifetimeMS)) / 10000);
        var _local3:String = TooltipHelper.getFormattedRangeString(_local1);
        comparisonStringBuilder.pushParams(TextKey.RANGE, {"range": wrapInColoredFont(_local3, getTextColor((_local1 - _local2)))});
        if (this.projXML.hasOwnProperty("MultiHit")) {
            comparisonStringBuilder.pushParams(TextKey.MULTIHIT, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
        if (this.projXML.hasOwnProperty("PassesCover")) {
            comparisonStringBuilder.pushParams(TextKey.PASSES_COVER, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
        if (this.projXML.hasOwnProperty("ArmorPiercing")) {
            comparisonStringBuilder.pushParams(TextKey.ARMOR_PIERCING, {}, TooltipHelper.getOpenTag(NO_DIFF_COLOR), TooltipHelper.getCloseTag());
        }
    }

    private function addNumProjectileText():void {
        var _local1:int = int(this.itemXML.NumProjectiles);
        var _local2:int = int(this.curItemXML.NumProjectiles);
        var _local3:uint = getTextColor((_local1 - _local2));
        comparisonStringBuilder.pushParams(TextKey.SHOTS, {"numShots": wrapInColoredFont(_local1.toString(), _local3)});
    }

    private function addDamageText():void {
        this.projXML = XML(this.itemXML.Projectile);
        var _local1:int = int(this.projXML.MinDamage);
        var _local2:int = int(this.projXML.MaxDamage);
        var _local3:Number = ((_local2 + _local1) / 2);
        this.otherProjXML = XML(this.curItemXML.Projectile);
        var _local4:int = int(this.otherProjXML.MinDamage);
        var _local5:int = int(this.otherProjXML.MaxDamage);
        var _local6:Number = ((_local5 + _local4) / 2);
        var _local7:String = (((_local1 == _local2)) ? _local1 : ((_local1 + " - ") + _local2)).toString();
        comparisonStringBuilder.pushParams(TextKey.DAMAGE, {"damage": wrapInColoredFont(_local7, getTextColor((_local3 - _local6)))});
    }

    private function buildRateOfFireText():void {
        if ((((this.itemXML.RateOfFire.length() == 0)) || ((this.curItemXML.RateOfFire.length() == 0)))) {
            return;
        }
        var _local1:Number = Number(this.curItemXML.RateOfFire[0]);
        var _local2:Number = Number(this.itemXML.RateOfFire[0]);
        var _local3:int = int(((_local2 / _local1) * 100));
        var _local4:int = (_local3 - 100);
        if (_local4 == 0) {
            return;
        }
        var _local5:uint = getTextColor(_local4);
        var _local6:String = _local4.toString();
        if (_local4 > 0) {
            _local6 = ("+" + _local6);
        }
        _local6 = wrapInColoredFont((_local6 + "%"), _local5);
        comparisonStringBuilder.pushParams(TextKey.RATE_OF_FIRE, {"data": _local6});
        processedTags[this.itemXML.RateOfFire[0].toXMLString()];
    }


}
}
