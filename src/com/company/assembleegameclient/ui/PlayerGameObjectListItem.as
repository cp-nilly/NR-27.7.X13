package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.PlayerToolTip;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class PlayerGameObjectListItem extends GameObjectListItem implements TooltipAble {

    public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

    private var enabled:Boolean = true;
    private var starred:Boolean = false;

    public function PlayerGameObjectListItem(_arg1:uint, _arg2:Boolean, _arg3:GameObject) {
        super(_arg1, _arg2, _arg3);
        var _local4:Player = (_arg3 as Player);
        if (_local4) {
            this.starred = _local4.starred_;
        }
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg1:Event):void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        this.hoverTooltipDelegate.setDisplayObject(this);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
    }

    public function setEnabled(_arg1:Boolean):void {
        if (((!((this.enabled == _arg1))) && (!((Player(go) == null))))) {
            this.enabled = _arg1;
            this.hoverTooltipDelegate.tooltip = ((this.enabled) ? new PlayerToolTip(Player(go)) : null);
            if (!this.enabled) {
                this.hoverTooltipDelegate.getShowToolTip().dispatch(this.hoverTooltipDelegate.tooltip);
            }
        }
    }

    override public function draw(_arg1:GameObject, _arg2:ColorTransform = null):void {
        var _local3:Player = (_arg1 as Player);
        if (((_local3) && (!((this.starred == _local3.starred_))))) {
            transform.colorTransform = ((_arg2) || (MoreColorUtil.identity));
            this.starred = _local3.starred_;
        }
        super.draw(_arg1, _arg2);
    }

    public function setShowToolTipSignal(_arg1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.hoverTooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.hoverTooltipDelegate.getHideToolTips());
    }


}
}
