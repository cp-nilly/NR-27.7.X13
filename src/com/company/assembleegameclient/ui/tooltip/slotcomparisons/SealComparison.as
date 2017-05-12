package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class SealComparison extends SlotComparison {

    private var healingTag:XML;
    private var damageTag:XML;
    private var otherHealingTag:XML;
    private var otherDamageTag:XML;


    override protected function compareSlots(itemXML:XML, curItemXML:XML):void {
        var tag:XML;
        comparisonStringBuilder = new AppendingLineBuilder();
        this.healingTag = this.getEffectTag(itemXML, "Healing");
        this.damageTag = this.getEffectTag(itemXML, "Damaging");
        this.otherHealingTag = this.getEffectTag(curItemXML, "Healing");
        this.otherDamageTag = this.getEffectTag(curItemXML, "Damaging");
        if (this.canCompare()) {
            this.handleHealingText();
            this.handleDamagingText();
            if (itemXML.@id == "Seal of Blasphemous Prayer") {
                tag = itemXML.Activate.(text() == "ConditionEffectSelf")[0];
                comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
                comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                    "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_INVULERABLE),
                    "duration": tag.@duration
                }, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
                processedTags[tag.toXMLString()] = true;
            }
        }
    }

    private function canCompare():Boolean {
        return (((((((!((this.healingTag == null))) && (!((this.damageTag == null))))) && (!((this.otherHealingTag == null))))) && (!((this.otherDamageTag == null)))));
    }

    private function getEffectTag(xml:XML, effectName:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == "ConditionEffectAura");
        for each (tag in matches) {
            if (tag.@effect == effectName) {
                return (tag);
            }
        }
        return (null);
    }

    private function handleHealingText():void {
        var _local1:int = int(this.healingTag.@duration);
        var _local2:int = int(this.otherHealingTag.@duration);
        var _local3:Number = Number(this.healingTag.@range);
        var _local4:Number = Number(this.otherHealingTag.@range);
        var _local5:Number = (((0.5 * _local1) * 0.5) * _local3);
        var _local6:Number = (((0.5 * _local2) * 0.5) * _local4);
        var _local7:uint = getTextColor((_local5 - _local6));
        var _local8:AppendingLineBuilder = new AppendingLineBuilder();
        _local8.pushParams(TextKey.WITHIN_SQRS, {"range": this.healingTag.@range}, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        _local8.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_HEALING),
            "duration": _local1.toString()
        }, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT, {"effect": _local8});
        processedTags[this.healingTag.toXMLString()] = true;
    }

    private function handleDamagingText():void {
        var _local1:int = int(this.damageTag.@duration);
        var _local2:int = int(this.otherDamageTag.@duration);
        var _local3:Number = Number(this.damageTag.@range);
        var _local4:Number = Number(this.otherDamageTag.@range);
        var _local5:Number = (((0.5 * _local1) * 0.5) * _local3);
        var _local6:Number = (((0.5 * _local2) * 0.5) * _local4);
        var _local7:uint = getTextColor((_local5 - _local6));
        var _local8:AppendingLineBuilder = new AppendingLineBuilder();
        _local8.pushParams(TextKey.WITHIN_SQRS, {"range": this.damageTag.@range}, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        _local8.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_DAMAGING),
            "duration": _local1.toString()
        }, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT, {"effect": _local8});
        processedTags[this.damageTag.toXMLString()] = true;
    }


}
}
