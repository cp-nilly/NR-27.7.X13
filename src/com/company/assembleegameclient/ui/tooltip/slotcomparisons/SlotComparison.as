package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import flash.utils.Dictionary;

import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

public class SlotComparison {

    static const BETTER_COLOR:uint = 0xFF00;
    static const WORSE_COLOR:uint = 0xFF0000;
    static const NO_DIFF_COLOR:uint = 16777103;
    static const LABEL_COLOR:uint = 0xB3B3B3;
    static const UNTIERED_COLOR:uint = 9055202;

    public var processedTags:Dictionary;
    public var processedActivateOnEquipTags:AppendingLineBuilder;
    public var comparisonStringBuilder:AppendingLineBuilder;


    public function compare(_arg1:XML, _arg2:XML):void {
        this.resetFields();
        this.compareSlots(_arg1, _arg2);
    }

    protected function compareSlots(_arg1:XML, _arg2:XML):void {
    }

    private function resetFields():void {
        this.processedTags = new Dictionary();
        this.processedActivateOnEquipTags = new AppendingLineBuilder();
    }

    protected function getTextColor(_arg1:Number):uint {
        if (_arg1 < 0) {
            return (WORSE_COLOR);
        }
        if (_arg1 > 0) {
            return (BETTER_COLOR);
        }
        return (NO_DIFF_COLOR);
    }

    protected function wrapInColoredFont(_arg1:String, _arg2:uint = 16777103):String {
        return ((((('<font color="#' + _arg2.toString(16)) + '">') + _arg1) + "</font>"));
    }

    protected function getMpCostText(_arg1:String):String {
        return (((this.wrapInColoredFont("MP Cost: ", LABEL_COLOR) + this.wrapInColoredFont(_arg1, NO_DIFF_COLOR)) + "\n"));
    }


}
}
