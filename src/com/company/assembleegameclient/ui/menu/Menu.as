package com.company.assembleegameclient.ui.menu {
import com.company.util.GraphicsUtil;
import com.company.util.RectangleUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

import kabam.rotmg.ui.view.UnFocusAble;

public class Menu extends Sprite implements UnFocusAble {

    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var background_:uint;
    private var outline_:uint;
    protected var yOffset:int;

    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

    public function Menu(_arg1:uint, _arg2:uint) {
        super();
        this.background_ = _arg1;
        this.outline_ = _arg2;
        this.yOffset = 40;
        filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    protected function addOption(_arg1:MenuOption):void {
        _arg1.x = 8;
        _arg1.y = this.yOffset;
        addChild(_arg1);
        this.yOffset = (this.yOffset + 28);
    }

    protected function onAddedToStage(_arg1:Event):void {
        this.draw();
        this.position();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    protected function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
    }

    protected function onEnterFrame(_arg1:Event):void {
        if (stage == null) {
            return;
        }
        var _local2:Rectangle = getRect(stage);
        var _local3:Number = RectangleUtil.pointDist(_local2, stage.mouseX, stage.mouseY);
        if (_local3 > 40) {
            this.remove();
        }
    }

    private function position():void {
        if (stage == null) {
            return;
        }
        if (stage.mouseX < (stage.stageWidth / 2)) {
            x = (stage.mouseX + 12);
        }
        else {
            x = ((stage.mouseX - width) - 1);
        }
        if (x < 12) {
            x = 12;
        }
        if (stage.mouseY < (stage.stageHeight / 3)) {
            y = (stage.mouseY + 12);
        }
        else {
            y = ((stage.mouseY - height) - 1);
        }
        if (y < 12) {
            y = 12;
        }
    }

    protected function onRollOut(_arg1:Event):void {
        this.remove();
    }

    public function remove():void {
        if (parent != null) {
            parent.removeChild(this);
        }
    }

    protected function draw():void {
        this.backgroundFill_.color = this.background_;
        this.outlineFill_.color = this.outline_;
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, Math.max(154, (width + 12)), (height + 12), 4, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}
