package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class CloakComparison extends SlotComparison {


    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        var _local3:XML;
        var _local4:XML;
        var _local5:Number;
        var _local6:Number;
        _local3 = this.getInvisibleTag(_arg1);
        _local4 = this.getInvisibleTag(_arg2);
        comparisonStringBuilder = new AppendingLineBuilder();
        if (((!((_local3 == null))) && (!((_local4 == null))))) {
            _local5 = Number(_local3.@duration);
            _local6 = Number(_local4.@duration);
            this.appendDurationText(_local5, _local6);
            processedTags[_local3.toXMLString()] = true;
        }
        this.handleExceptions(_arg1);
    }

    private function handleExceptions(itemXML:XML):void {
        var teleportTag:XML;
        if (itemXML.@id == "Cloak of the Planewalker") {
            comparisonStringBuilder.pushParams(TextKey.TELEPORT_TO_TARGET, {}, TooltipHelper.getOpenTag(UNTIERED_COLOR), TooltipHelper.getCloseTag());
            teleportTag = XML(itemXML.Activate.(text() == ActivationType.TELEPORT))[0];
            processedTags[teleportTag.toXMLString()] = true;
        }
    }

    private function getInvisibleTag(xml:XML):XML {
        var matches:XMLList;
        var conditionTag:XML;
        matches = xml.Activate.(text() == ActivationType.COND_EFFECT_SELF);
        for each (conditionTag in matches) {
            if (conditionTag.(@effect == "Invisible")) {
                return (conditionTag);
            }
        }
        return (null);
    }

    private function appendDurationText(_arg1:Number, _arg2:Number):void {
        var _local3:uint = getTextColor((_arg1 - _arg2));
        comparisonStringBuilder.pushParams(TextKey.EFFECT_ON_SELF, {"effect": ""});
        comparisonStringBuilder.pushParams(TextKey.EFFECT_FOR_DURATION, {
            "effect": TextKey.wrapForTokenResolution(TextKey.ACTIVE_EFFECT_INVISIBLE),
            "duration": _arg1.toString()
        }, TooltipHelper.getOpenTag(_local3), TooltipHelper.getCloseTag());
    }


}
}
