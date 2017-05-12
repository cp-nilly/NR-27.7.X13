package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;

import kabam.rotmg.constants.*;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class SkullComparison extends SlotComparison {


    override protected function compareSlots(_arg1:XML, _arg2:XML):void {
        var _local3:XML;
        var _local4:XML;
        var _local5:Number;
        var _local6:Number;
        var _local7:int;
        var _local8:int;
        var _local9:Number;
        var _local10:Number;
        _local3 = this.getVampireBlastTag(_arg1);
        _local4 = this.getVampireBlastTag(_arg2);
        comparisonStringBuilder = new AppendingLineBuilder();
        if (((!((_local3 == null))) && (!((_local4 == null))))) {
            _local5 = Number(_local3.@radius);
            _local6 = Number(_local4.@radius);
            _local7 = int(_local3.@totalDamage);
            _local8 = int(_local4.@totalDamage);
            _local9 = ((0.5 * _local5) + (0.5 * _local7));
            _local10 = ((0.5 * _local6) + (0.5 * _local8));
            comparisonStringBuilder.pushParams(TextKey.STEAL, {
                "effect": new LineBuilder().setParams(TextKey.HP_WITHIN_SQRS, {
                    "amount": _local7,
                    "range": _local5
                }).setPrefix(TooltipHelper.getOpenTag(getTextColor((_local9 - _local10)))).setPostfix(TooltipHelper.getCloseTag())
            });
            processedTags[_local3.toXMLString()] = true;
        }
    }

    private function getVampireBlastTag(xml:XML):XML {
        var matches:XMLList;
        matches = xml.Activate.(text() == ActivationType.VAMPIRE_BLAST);
        return ((((matches.length()) >= 1) ? matches[0] : null));
    }


}
}
