package com.company.assembleegameclient.map {
import com.company.util.GraphicsUtil;

import flash.display.GradientType;
import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class HurtOverlay extends Shape {

    public function HurtOverlay() {
        var w:Number = WebMain.STAGE.stageWidth - 200;
        var h:Number = WebMain.STAGE.stageHeight;
        var sw:Number = w / Math.sin(Math.PI / 4);
        var sh:Number = h / Math.sin(Math.PI / 4);
        var gFill:GraphicsGradientFill = new GraphicsGradientFill(
                GradientType.RADIAL,
                [0xFFFFFF, 0xFFFFFF, 0xFFFFFF],
                [0, 0, 0.92],
                [0, 155, 0xFF],
                GraphicsUtil.getGradientMatrix(sw, sh, 0, (w - sw) / 2, (h - sh) / 2));
        var gPath:GraphicsPath = GraphicsUtil.getRectPath(0, 0, w, h);
        var gGfxData:Vector.<IGraphicsData> = new <IGraphicsData>[gFill, gPath, GraphicsUtil.END_FILL];
        graphics.drawGraphicsData(gGfxData);
        visible = false;
    }

}
}
