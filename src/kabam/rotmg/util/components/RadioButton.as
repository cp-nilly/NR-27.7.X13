package kabam.rotmg.util.components {
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;

import org.osflash.signals.Signal;

public class RadioButton extends Sprite {

    public const changed:Signal = new Signal(Boolean);
    private const WIDTH:int = 28;
    private const HEIGHT:int = 28;

    private var unselected:Shape;
    private var selected:Shape;

    public function RadioButton() {
        addChild((this.unselected = this.makeUnselected()));
        addChild((this.selected = this.makeSelected()));
        this.setSelected(false);
    }

    public function setSelected(_arg1:Boolean):void {
        this.unselected.visible = !(_arg1);
        this.selected.visible = _arg1;
        this.changed.dispatch(_arg1);
    }

    private function makeUnselected():Shape {
        var _local1:Shape = new Shape();
        this.drawOutline(_local1.graphics);
        return (_local1);
    }

    private function makeSelected():Shape {
        var _local1:Shape = new Shape();
        this.drawOutline(_local1.graphics);
        this.drawFill(_local1.graphics);
        return (_local1);
    }

    private function drawOutline(_arg1:Graphics):void {
        var _local2:GraphicsSolidFill = new GraphicsSolidFill(0, 0.01);
        var _local3:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
        var _local4:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, _local3);
        var _local5:GraphicsPath = new GraphicsPath();
        GraphicsUtil.drawCutEdgeRect(0, 0, this.WIDTH, this.HEIGHT, 4, GraphicsUtil.ALL_CUTS, _local5);
        var _local6:Vector.<IGraphicsData> = new <IGraphicsData>[_local4, _local2, _local5, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        _arg1.drawGraphicsData(_local6);
    }

    private function drawFill(_arg1:Graphics):void {
        var _local2:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
        var _local3:GraphicsPath = new GraphicsPath();
        GraphicsUtil.drawCutEdgeRect(4, 4, (this.WIDTH - 8), (this.HEIGHT - 8), 2, GraphicsUtil.ALL_CUTS, _local3);
        var _local4:Vector.<IGraphicsData> = new <IGraphicsData>[_local2, _local3, GraphicsUtil.END_FILL];
        _arg1.drawGraphicsData(_local4);
    }


}
}
