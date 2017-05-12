package com.company.assembleegameclient.ui {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsPathWinding;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class LineBreakDesign extends Shape {

    private var designFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var designPath_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>(), GraphicsPathWinding.NON_ZERO);

    private const designGraphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[designFill_, designPath_, GraphicsUtil.END_FILL];

    public function LineBreakDesign(_arg1:int, _arg2:uint) {
        super();
        this.setWidthColor(_arg1, _arg2);
    }

    public function setWidthColor(_arg1:int, _arg2:uint):void {
        graphics.clear();
        this.designFill_.color = _arg2;
        GraphicsUtil.clearPath(this.designPath_);
        GraphicsUtil.drawDiamond(0, 0, 4, this.designPath_);
        GraphicsUtil.drawDiamond(_arg1, 0, 4, this.designPath_);
        GraphicsUtil.drawRect(0, -1, _arg1, 2, this.designPath_);
        graphics.drawGraphicsData(this.designGraphicsData_);
    }


}
}
