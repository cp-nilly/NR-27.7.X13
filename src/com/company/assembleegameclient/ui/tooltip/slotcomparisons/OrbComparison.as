package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class OrbComparison extends SlotComparison {


    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        var _local3:XML;
        var _local4:XML;
        var _local5:int;
        var _local6:int;
        var _local7:uint;
        _local3 = this.getStasisBlastTag(_arg1);
        _local4 = this.getStasisBlastTag(_arg2);
        comparisonStringBuilder = new AppendingLineBuilder();
        if (((!((_local3 == null))) && (!((_local4 == null))))) {
            _local5 = int(_local3.@duration);
            _local6 = int(_local4.@duration);
            _local7 = getTextColor((_local5 - _local6));
            comparisonStringBuilder.pushParams(TextKey.STASIS_GROUP, {"stasis": new LineBuilder().setParams(TextKey.SEC_COUNT, {"duration": _local5}).setPrefix(TooltipHelper.getOpenTag(_local7)).setPostfix(TooltipHelper.getCloseTag())});
            processedTags[_local3.toXMLString()] = true;
            this.handleExceptions(_arg1);
        }
    }

    private function getStasisBlastTag(orbXML:XML):XML {
        var matches:XMLList;
        matches = orbXML.Activate.(text() == "StasisBlast");
        return ((((matches.length()) == 1) ? matches[0] : null));
    }

    private function handleExceptions(itemXML:XML):void {
        var selfTags:XMLList;
        var speedy:XML;
        var damaging:XML;
        if (itemXML.@id == "Orb of Conflict") {
            selfTags = itemXML.Activate.(text() == "ConditionEffectSelf");
            speedy = selfTags.(@effect == "Speedy")[0];
            damaging = selfTags.(@effect == "Damaging")[0];
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_SPEEDY),
                "duration": speedy.@duration
            }, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
            comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
                "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_DAMAGING),
                "duration": damaging.@duration
            }, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            processedTags[speedy.toXMLString()] = true;
            processedTags[damaging.toXMLString()] = true;
        }
    }


}
}
