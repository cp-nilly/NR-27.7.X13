package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class InteractiveItemTile extends ItemTile {

    private static const DOUBLE_CLICK_PAUSE:uint = 250;
    private static const DRAG_DIST:int = 3;

    private var doubleClickTimer:Timer;
    private var dragStart:Point;
    private var pendingSecondClick:Boolean;
    private var isDragging:Boolean;

    public function InteractiveItemTile(_arg1:int, _arg2:ItemGrid, _arg3:Boolean) {
        super(_arg1, _arg2);
        mouseChildren = false;
        this.doubleClickTimer = new Timer(DOUBLE_CLICK_PAUSE, 1);
        this.doubleClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDoubleClickTimerComplete);
        this.setInteractive(_arg3);
    }

    public function setInteractive(_arg1:Boolean):void {
        if (_arg1) {
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }
        else {
            removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        }
    }

    public function getDropTarget():DisplayObject {
        return (itemSprite.dropTarget);
    }

    protected function beginDragCallback():void {
    }

    protected function endDragCallback():void {
    }

    private function onMouseOut(_arg1:MouseEvent):void {
        this.setPendingDoubleClick(false);
    }

    private function onMouseUp(_arg1:MouseEvent):void {
        if (this.isDragging) {
            return;
        }
        if (_arg1.shiftKey) {
            this.setPendingDoubleClick(false);
            dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_SHIFT_CLICK, this));
        }
        else {
            if (_arg1.ctrlKey) {
                this.setPendingDoubleClick(false);
                dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_CTRL_CLICK, this));
            }
            else {
                if (!this.pendingSecondClick) {
                    this.setPendingDoubleClick(true);
                }
                else {
                    this.setPendingDoubleClick(false);
                    dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_DOUBLE_CLICK, this));
                }
            }
        }
    }

    private function onMouseDown(_arg1:MouseEvent):void {
        if (getItemId() == -1) {
            return;
        }
        this.beginDragCheck(_arg1);
    }

    private function setPendingDoubleClick(_arg1:Boolean):void {
        this.pendingSecondClick = _arg1;
        if (this.pendingSecondClick) {
            this.doubleClickTimer.reset();
            this.doubleClickTimer.start();
        }
        else {
            this.doubleClickTimer.stop();
        }
    }

    private function beginDragCheck(_arg1:MouseEvent):void {
        this.dragStart = new Point(_arg1.stageX, _arg1.stageY);
        addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
        addEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
        addEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
    }

    private function cancelDragCheck(_arg1:MouseEvent):void {
        removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMoveCheckDrag);
        removeEventListener(MouseEvent.MOUSE_OUT, this.cancelDragCheck);
        removeEventListener(MouseEvent.MOUSE_UP, this.cancelDragCheck);
    }

    private function onMouseMoveCheckDrag(_arg1:MouseEvent):void {
        var _local2:Number = (_arg1.stageX - this.dragStart.x);
        var _local3:Number = (_arg1.stageY - this.dragStart.y);
        var _local4:Number = Math.sqrt(((_local2 * _local2) + (_local3 * _local3)));
        if (_local4 > DRAG_DIST) {
            this.cancelDragCheck(null);
            this.setPendingDoubleClick(false);
            this.beginDrag(_arg1);
        }
    }

    private function onDoubleClickTimerComplete(_arg1:TimerEvent):void {
        this.setPendingDoubleClick(false);
        dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_CLICK, this));
    }

    private function beginDrag(_arg1:MouseEvent):void {
        this.isDragging = true;
        stage.addChild(itemSprite);
        itemSprite.startDrag(true);
        itemSprite.x = _arg1.stageX;
        itemSprite.y = _arg1.stageY;
        itemSprite.addEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        this.beginDragCallback();
    }

    private function endDrag(_arg1:MouseEvent):void {
        this.isDragging = false;
        itemSprite.stopDrag();
        itemSprite.removeEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        dispatchEvent(new ItemTileEvent(ItemTileEvent.ITEM_MOVE, this));
        this.endDragCallback();
    }

    private function onRemovedFromStage(_arg1:Event):void {
        this.setPendingDoubleClick(false);
        this.cancelDragCheck(null);
        if (this.isDragging) {
            itemSprite.stopDrag();
        }
    }


}
}
