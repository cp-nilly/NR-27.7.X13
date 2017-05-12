package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class HelmetComparison extends SlotComparison {

    private var berserk:XML;
    private var speedy:XML;
    private var otherBerserk:XML;
    private var otherSpeedy:XML;
    private var armored:XML;
    private var otherArmored:XML;


    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        this.extractDataFromXML(_arg1, _arg2);
        comparisonStringBuilder = new AppendingLineBuilder();
        this.handleBerserk();
        this.handleSpeedy();
        this.handleArmored();
    }

    private function extractDataFromXML(_arg1:XML, _arg2:XML):void {
        this.berserk = this.getAuraTagByType(_arg1, "Berserk");
        this.speedy = this.getSelfTagByType(_arg1, "Speedy");
        this.armored = this.getSelfTagByType(_arg1, "Armored");
        this.otherBerserk = this.getAuraTagByType(_arg2, "Berserk");
        this.otherSpeedy = this.getSelfTagByType(_arg2, "Speedy");
        this.otherArmored = this.getSelfTagByType(_arg2, "Armored");
    }

    private function getAuraTagByType(xml:XML, typeName:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_AURA);
        for each (tag in matches) {
            if (tag.@effect == typeName) {
                return (tag);
            }
        }
        return (null);
    }

    private function getSelfTagByType(xml:XML, typeName:String):XML {
        var matches:XMLList;
        var tag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_SELF);
        for each (tag in matches) {
            if (tag.@effect == typeName) {
                return (tag);
            }
        }
        return (null);
    }

    private function handleBerserk():void {
        if ((((this.berserk == null)) || ((this.otherBerserk == null)))) {
            return;
        }
        var _local1:Number = Number(this.berserk.@range);
        var _local2:Number = Number(this.otherBerserk.@range);
        var _local3:Number = Number(this.berserk.@duration);
        var _local4:Number = Number(this.otherBerserk.@duration);
        var _local5:Number = ((0.5 * _local1) + (0.5 * _local3));
        var _local6:Number = ((0.5 * _local2) + (0.5 * _local4));
        var _local7:uint = getTextColor((_local5 - _local6));
        var _local8:AppendingLineBuilder = new AppendingLineBuilder();
        _local8.pushParams(TextKey.WITHIN_SQRS, {"range": _local1.toString()}, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        _local8.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_BERSERK),
            "duration": _local3.toString()
        }, TooltipHelper.getOpenTag(_local7), TooltipHelper.getCloseTag());
        comparisonStringBuilder.pushParams(TextKey.PARTY_EFFECT, {"effect": _local8});
        processedTags[this.berserk.toXMLString()] = true;
    }

    private function handleSpeedy():void {
        var _local1:Number;
        var _local2:Number;
        if (((!((this.speedy == null))) && (!((this.otherSpeedy == null))))) {
            _local1 = Number(this.speedy.@duration);
            _local2 = Number(this.otherSpeedy.@duration);
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
                "duration": _local1.toString()
            }, TooltipHelper.getOpenTag(getTextColor((_local1 - _local2))), TooltipHelper.getCloseTag());
            processedTags[this.speedy.toXMLString()] = true;
        }
        else {
            if (((!((this.speedy == null))) && ((this.otherSpeedy == null)))) {
                comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
                comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                    "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
                    "duration": this.speedy.@duration
                }, TooltipHelper.getOpenTag(BETTER_COLOR), TooltipHelper.getCloseTag());
                processedTags[this.speedy.toXMLString()] = true;
            }
        }
    }

    private function handleArmored():void {
        if (this.armored != null) {
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_ARMORED),
                "duration": this.armored.@duration
            }, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            processedTags[this.armored.toXMLString()] = true;
        }
    }


}
}
