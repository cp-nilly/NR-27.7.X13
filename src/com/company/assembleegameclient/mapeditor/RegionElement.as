package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Shape;

public class RegionElement extends Element {

    public var regionXML_:XML;

    public function RegionElement(_arg1:XML) {
        super(int(_arg1.@type));
        this.regionXML_ = _arg1;
        var _local2:Shape = new Shape();
        _local2.graphics.beginFill(RegionLibrary.getColor(type_), 0.5);
        _local2.graphics.drawRect(0, 0, (WIDTH - 8), (HEIGHT - 8));
        _local2.graphics.endFill();
        _local2.x = ((WIDTH / 2) - (_local2.width / 2));
        _local2.y = ((HEIGHT / 2) - (_local2.height / 2));
        addChild(_local2);
    }

    override protected function getToolTip():ToolTip {
        return (new RegionTypeToolTip(this.regionXML_));
    }


}
}
