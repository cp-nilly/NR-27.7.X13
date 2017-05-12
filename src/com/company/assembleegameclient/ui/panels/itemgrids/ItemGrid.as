package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.events.MouseEvent;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class ItemGrid extends Panel {

    private static const NO_CUT:Array = [0, 0, 0, 0];
    private static const CutsByNum:Object = {
        "1": [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0]],
        "2": [[1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]],
        "3": [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]]
    };

    private const padding:uint = 4;
    private const rowLength:uint = 4;
    public const addToolTip:Signal = new Signal(ToolTip);

    public var owner:GameObject;
    private var tooltip:ToolTip;
    private var tooltipFocusTile:ItemTile;
    public var curPlayer:Player;
    protected var indexOffset:int;
    public var interactive:Boolean;

    public function ItemGrid(_arg1:GameObject, _arg2:Player, _arg3:int) {
        super(null);
        this.owner = _arg1;
        this.curPlayer = _arg2;
        this.indexOffset = _arg3;
        var _local4:Container = (_arg1 as Container);
        if ((((_arg1 == _arg2)) || (_local4))) {
            this.interactive = true;
        }
    }

    public function hideTooltip():void {
        if (this.tooltip) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.tooltipFocusTile = null;
        }
    }

    public function refreshTooltip():void {
        if (((((!(stage)) || (!(this.tooltip)))) || (!(this.tooltip.stage)))) {
            return;
        }
        if (this.tooltipFocusTile) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.addToolTipToTile(this.tooltipFocusTile);
        }
    }

    private function onTileHover(_arg1:MouseEvent):void {
        if (!stage) {
            return;
        }
        var _local2:ItemTile = (_arg1.currentTarget as ItemTile);
        this.addToolTipToTile(_local2);
        this.tooltipFocusTile = _local2;
    }

    private function addToolTipToTile(_arg1:ItemTile):void {
        var _local2:String;
        if (_arg1.itemSprite.itemId > 0) {
            this.tooltip = new EquipmentToolTip(_arg1.itemSprite.itemId, this.curPlayer, ((this.owner) ? this.owner.objectType_ : -1), this.getCharacterType());
        }
        else {
            if ((_arg1 is EquipmentTile)) {
                _local2 = ItemConstants.itemTypeToName((_arg1 as EquipmentTile).itemType);
            }
            else {
                _local2 = TextKey.ITEM;
            }
            this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.ITEM_EMPTY_SLOT, 200, {"itemType": TextKey.wrapForTokenResolution(_local2)});
        }
        this.tooltip.attachToTarget(_arg1);
        this.addToolTip.dispatch(this.tooltip);
    }

    private function getCharacterType():String {
        if (this.owner == this.curPlayer) {
            return (InventoryOwnerTypes.CURRENT_PLAYER);
        }
        if ((this.owner is Player)) {
            return (InventoryOwnerTypes.OTHER_PLAYER);
        }
        return (InventoryOwnerTypes.NPC);
    }

    protected function addToGrid(_arg1:ItemTile, _arg2:uint, _arg3:uint):void {
        _arg1.drawBackground(CutsByNum[_arg2][_arg3]);
        _arg1.addEventListener(MouseEvent.ROLL_OVER, this.onTileHover);
        _arg1.x = (int((_arg3 % this.rowLength)) * (ItemTile.WIDTH + this.padding));
        _arg1.y = (int((_arg3 / this.rowLength)) * (ItemTile.HEIGHT + this.padding));
        addChild(_arg1);
    }

    public function setItems(_arg1:Vector.<int>, _arg2:int = 0):void {
    }

    public function enableInteraction(_arg1:Boolean):void {
        mouseEnabled = _arg1;
    }

    override public function draw():void {
        this.setItems(this.owner.equipment_, this.indexOffset);
    }


}
}
