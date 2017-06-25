package com.company.assembleegameclient.map {
import com.company.util.GraphicsUtil;

import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class GradientOverlay extends Shape {

    private var gradientFill_:GraphicsGradientFill;
    private var gradientPath_:GraphicsPath;
    private var gradientGraphicsData_:Vector.<IGraphicsData>;

    public function GradientOverlay() {
        gradientFill_ = new GraphicsGradientFill(GradientType.LINEAR, [0, 0], [0, 1], [0, 0xFF], GraphicsUtil.getGradientMatrix(10, WebMain.STAGE.stageHeight));
        gradientPath_ = GraphicsUtil.getRectPath(0, 0, 10, WebMain.STAGE.stageHeight);
        gradientGraphicsData_ = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];
        graphics.drawGraphicsData(this.gradientGraphicsData_);
    }

}
}
