package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.OneWayContainer;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileEvent;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.DisplayHierarchy;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.view.components.TabStripView;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.questrewards.view.QuestRewardsView;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.model.TabStripModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ItemGridMediator extends Mediator {

    [Inject]
    public var view:ItemGrid;
    [Inject]
    public var mapModel:MapModel;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var potionInventoryModel:PotionInventoryModel;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var tabStripModel:TabStripModel;
    [Inject]
    public var showToolTip:ShowTooltipSignal;
    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var reskinPetFlowStart:ReskinPetFlowStartSignal;
    [Inject]
    public var reskinPetModel:PetFormModel;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var addTextLine:AddTextLineSignal;


    override public function initialize():void {
        this.view.addEventListener(ItemTileEvent.ITEM_MOVE, this.onTileMove);
        this.view.addEventListener(ItemTileEvent.ITEM_SHIFT_CLICK, this.onShiftClick);
        this.view.addEventListener(ItemTileEvent.ITEM_DOUBLE_CLICK, this.onDoubleClick);
        this.view.addEventListener(ItemTileEvent.ITEM_CTRL_CLICK, this.onCtrlClick);
        this.view.addToolTip.add(this.onAddToolTip);
    }

    private function onAddToolTip(_arg1:ToolTip):void {
        this.showToolTip.dispatch(_arg1);
    }

    override public function destroy():void {
        super.destroy();
    }

    private function onTileMove(_arg1:ItemTileEvent):void {
        var _local4:InteractiveItemTile;
        var _local5:TabStripView;
        var _local6:int;
        var _local7:FoodFeedFuseSlot;
        var _local8:int;
        var _local2:InteractiveItemTile = _arg1.tile;
        var _local3:* = DisplayHierarchy.getParentWithTypeArray(_local2.getDropTarget(), TabStripView, InteractiveItemTile, FoodFeedFuseSlot, QuestRewardsView, Map);
        if ((((_local2.getItemId() == PotionInventoryModel.HEALTH_POTION_ID)) || ((((_local2.getItemId() == PotionInventoryModel.MAGIC_POTION_ID)) && (!(Boolean((_local3 as FoodFeedFuseSlot)))))))) {
            this.onPotionMove(_arg1);
            return;
        }
        if ((_local3 is InteractiveItemTile)) {
            _local4 = (_local3 as InteractiveItemTile);
            if (this.view.curPlayer.lockedSlot[_local4.tileId] == 0) {
                if (this.canSwapItems(_local2, _local4)) {
                    this.swapItemTiles(_local2, _local4);
                }
            }
            else {
                this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "You cannot put items into this slot right now."));
            }
        }
        else {
            if ((_local3 is TabStripView)) {
                _local5 = (_local3 as TabStripView);
                _local6 = _local2.ownerGrid.curPlayer.nextAvailableInventorySlot();
                if (_local6 != -1) {
                    GameServerConnection.instance.invSwap(this.view.curPlayer, _local2.ownerGrid.owner, _local2.tileId, _local2.itemSprite.itemId, this.view.curPlayer, _local6, ItemConstants.NO_ITEM);
                    _local2.setItem(ItemConstants.NO_ITEM);
                    _local2.updateUseability(this.view.curPlayer);
                }
            }
            else {
                if ((_local3 is FoodFeedFuseSlot)) {
                    _local7 = (_local3 as FoodFeedFuseSlot);
                    if (!_local7.processing) {
                        this.petSlotsState.rightSlotId = _local2.tileId;
                        this.petSlotsState.rightSlotOwnerId = _local2.ownerGrid.owner.objectId_;
                        _local8 = _local2.getItemId();
                        _local7.setItem(_local8, _local2.tileId, _local2.ownerGrid.owner.objectId_, this.petFoodCancel(_local2));
                        _local2.setItem(ItemConstants.NO_ITEM);
                        _local2.blockingItemUpdates = true;
                        _local2.updateUseability(this.view.curPlayer);
                        _local7.setItemPart2(_local8);
                    }
                }
                else {
                    if ((((_local3 is Map)) || ((this.hudModel.gameSprite.map.mouseX < 300)))) {
                        this.dropItem(_local2);
                    }
                }
            }
        }
        _local2.resetItemPosition();
    }

    private function petFoodCancel(itemSlot:InteractiveItemTile):Function {
        return (function ():void {
            itemSlot.blockingItemUpdates = false;
        });
    }

    private function onPotionMove(_arg1:ItemTileEvent):void {
        var _local2:InteractiveItemTile = _arg1.tile;
        var _local3:* = DisplayHierarchy.getParentWithTypeArray(_local2.getDropTarget(), TabStripView, Map);
        if ((_local3 is TabStripView)) {
            this.addToPotionStack(_local2);
        }
        else {
            if ((((_local3 is Map)) || ((this.hudModel.gameSprite.map.mouseX < 300)))) {
                this.dropItem(_local2);
            }
        }
        _local2.resetItemPosition();
    }

    private function addToPotionStack(_arg1:InteractiveItemTile):void {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || ((this.potionInventoryModel.getPotionModel(_arg1.getItemId()).maxPotionCount <= this.hudModel.gameSprite.map.player_.getPotionCount(_arg1.getItemId()))))) {
            return;
        }
        GameServerConnection.instance.invSwapPotion(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, PotionInventoryModel.getPotionSlot(_arg1.getItemId()), ItemConstants.NO_ITEM);
        _arg1.setItem(ItemConstants.NO_ITEM);
        _arg1.updateUseability(this.view.curPlayer);
    }

    private function canSwapItems(_arg1:InteractiveItemTile, _arg2:InteractiveItemTile):Boolean {
        if (!_arg1.canHoldItem(_arg2.getItemId())) {
            return (false);
        }
        if (!_arg2.canHoldItem(_arg1.getItemId())) {
            return (false);
        }
        if ((ItemGrid(_arg2.parent).owner is OneWayContainer)) {
            return (false);
        }
        if (((_arg1.blockingItemUpdates) || (_arg2.blockingItemUpdates))) {
            return (false);
        }
        return (true);
    }

    private function dropItem(_arg1:InteractiveItemTile):void {
        var _local4:Container;
        var _local5:Vector.<int>;
        var _local6:int;
        var _local7:int;
        var _local2:Boolean = ObjectLibrary.isSoulbound(_arg1.itemSprite.itemId);
        var _local3:Container = (this.view.owner as Container);
        if ((((this.view.owner == this.view.curPlayer)) || (((((_local3) && ((_local3.ownerId_ == this.view.curPlayer.accountId_)))) && (!(_local2)))))) {
            _local4 = (this.mapModel.currentInteractiveTarget as Container);
            if (_local4) {
                _local5 = _local4.equipment_;
                _local6 = _local5.length;
                _local7 = 0;
                while (_local7 < _local6) {
                    if (_local5[_local7] < 0) break;
                    _local7++;
                }
                if (_local7 < _local6) {
                    this.dropWithoutDestTile(_arg1, _local4, _local7);
                }
                else {
                    GameServerConnection.instance.invDrop(this.view.owner, _arg1.tileId, _arg1.getItemId());
                }
            }
            else {
                GameServerConnection.instance.invDrop(this.view.owner, _arg1.tileId, _arg1.getItemId());
            }
        }
        _arg1.setItem(-1);
    }

    private function swapItemTiles(_arg1:ItemTile, _arg2:ItemTile):Boolean {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || (!(_arg2)))) {
            return (false);
        }
        GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, _arg2.ownerGrid.owner, _arg2.tileId, _arg2.itemSprite.itemId);
        var _local3:int = _arg1.getItemId();
        _arg1.setItem(_arg2.getItemId());
        _arg2.setItem(_local3);
        _arg1.updateUseability(this.view.curPlayer);
        _arg2.updateUseability(this.view.curPlayer);
        return (true);
    }

    private function dropWithoutDestTile(_arg1:ItemTile, _arg2:Container, _arg3:int):void {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg1)))) || (!(_arg2)))) {
            return;
        }
        GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, _arg2, _arg3, -1);
        _arg1.setItem(ItemConstants.NO_ITEM);
    }

    private function onShiftClick(_arg1:ItemTileEvent):void {
        var _local2:InteractiveItemTile = _arg1.tile;
        if ((((_local2.ownerGrid is InventoryGrid)) || ((_local2.ownerGrid is ContainerGrid)))) {
            GameServerConnection.instance.useItem_new(_local2.ownerGrid.owner, _local2.tileId);
        }
    }

    private function onCtrlClick(_arg1:ItemTileEvent):void {
        var _local2:InteractiveItemTile;
        var _local3:int;
        if (Parameters.data_.inventorySwap) {
            _local2 = _arg1.tile;
            if ((_local2.ownerGrid is InventoryGrid)) {
                _local3 = _local2.ownerGrid.curPlayer.swapInventoryIndex(this.tabStripModel.currentSelection);
                if (_local3 != -1) {
                    GameServerConnection.instance.invSwap(this.view.curPlayer, _local2.ownerGrid.owner, _local2.tileId, _local2.itemSprite.itemId, this.view.curPlayer, _local3, ItemConstants.NO_ITEM);
                    _local2.setItem(ItemConstants.NO_ITEM);
                    _local2.updateUseability(this.view.curPlayer);
                }
            }
        }
    }

    private function onDoubleClick(_arg1:ItemTileEvent):void {
        var _local2:InteractiveItemTile = _arg1.tile;
        if (this.isPetFormStone(_local2)) {
            this.handlePetFormStone(_local2);
        }
        else {
            if (this.isStackablePotion(_local2)) {
                this.addToPotionStack(_local2);
            }
            else {
                if ((_local2.ownerGrid is ContainerGrid)) {
                    this.equipOrUseContainer(_local2);
                }
                else {
                    this.equipOrUseInventory(_local2);
                }
            }
        }
        this.view.refreshTooltip();
    }

    private function handlePetFormStone(_arg1:InteractiveItemTile):void {
        if ((_arg1.ownerGrid is ContainerGrid)) {
            this.pickUpItem(_arg1);
        }
        else {
            if (this.petsModel.isMapNameYardName(this.hudModel.gameSprite.map)) {
                this.reskinPetModel.setSlotObject(_arg1);
                this.reskinPetFlowStart.dispatch();
            }
            else {
                this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "server.use_in_petyard"));
            }
        }
    }

    private function isPetFormStone(_arg1:InteractiveItemTile):Boolean {
        return ((_arg1.getItemId() == 3321));
    }

    private function isStackablePotion(_arg1:InteractiveItemTile):Boolean {
        return ((((_arg1.getItemId() == PotionInventoryModel.HEALTH_POTION_ID)) || ((_arg1.getItemId() == PotionInventoryModel.MAGIC_POTION_ID))));
    }

    private function pickUpItem(_arg1:InteractiveItemTile):void {
        var _local2:int = this.view.curPlayer.nextAvailableInventorySlot();
        if (_local2 != -1) {
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, _local2, ItemConstants.NO_ITEM);
        }
    }

    private function equipOrUseContainer(_arg1:InteractiveItemTile):void {
        var _local2:GameObject = _arg1.ownerGrid.owner;
        var _local3:Player = this.view.curPlayer;
        var _local4:int = this.view.curPlayer.nextAvailableInventorySlot();
        if (_local4 != -1) {
            GameServerConnection.instance.invSwap(_local3, this.view.owner, _arg1.tileId, _arg1.itemSprite.itemId, this.view.curPlayer, _local4, ItemConstants.NO_ITEM);
        }
        else {
            GameServerConnection.instance.useItem_new(_local2, _arg1.tileId);
        }
    }

    private function equipOrUseInventory(_arg1:InteractiveItemTile):void {
        var _local2:GameObject = _arg1.ownerGrid.owner;
        var _local3:Player = this.view.curPlayer;
        var _local4:int = ObjectLibrary.getMatchingSlotIndex(_arg1.getItemId(), _local3);
        if (_local4 != -1) {
            GameServerConnection.instance.invSwap(_local3, _local2, _arg1.tileId, _arg1.getItemId(), _local3, _local4, _local3.equipment_[_local4]);
        }
        else {
            GameServerConnection.instance.useItem_new(_local2, _arg1.tileId);
        }
    }


}
}
