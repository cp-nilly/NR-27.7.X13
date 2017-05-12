package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Shape;
import flash.display.Sprite;

import kabam.rotmg.constants.ItemConstants;

public class ItemTile extends Sprite {

    public static const TILE_DOUBLE_CLICK:String = "TILE_DOUBLE_CLICK";
    public static const TILE_SINGLE_CLICK:String = "TILE_SINGLE_CLICK";
    public static const WIDTH:int = 40;
    public static const HEIGHT:int = 40;
    public static const BORDER:int = 4;

    private var fill_:GraphicsSolidFill;
    private var path_:GraphicsPath;
    private var graphicsData_:Vector.<IGraphicsData>;
    private var restrictedUseIndicator:Shape;
    public var itemSprite:ItemTileSprite;
    public var tileId:int;
    public var ownerGrid:ItemGrid;
    public var blockingItemUpdates:Boolean;

    public function ItemTile(_arg1:int, _arg2:ItemGrid) {
        this.fill_ = new GraphicsSolidFill(this.getBackgroundColor(), 1);
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsData_ = new <IGraphicsData>[this.fill_, this.path_, GraphicsUtil.END_FILL];
        super();
        this.tileId = _arg1;
        this.ownerGrid = _arg2;
        this.restrictedUseIndicator = new Shape();
        addChild(this.restrictedUseIndicator);
        this.setItemSprite(new ItemTileSprite());
    }

    public function drawBackground(_arg1:Array):void {
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, _arg1, this.path_);
        graphics.clear();
        graphics.drawGraphicsData(this.graphicsData_);
        var _local2:GraphicsSolidFill = new GraphicsSolidFill(6036765, 1);
        GraphicsUtil.clearPath(this.path_);
        var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[_local2, this.path_, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, _arg1, this.path_);
        this.restrictedUseIndicator.graphics.drawGraphicsData(_local3);
        this.restrictedUseIndicator.cacheAsBitmap = true;
        this.restrictedUseIndicator.visible = false;
    }

    public function setItem(_arg1:int):Boolean {
        if (_arg1 == this.itemSprite.itemId) {
            return (false);
        }
        if (this.blockingItemUpdates) {
            return (true);
        }
        this.itemSprite.setType(_arg1);
        this.updateUseability(this.ownerGrid.curPlayer);
        return (true);
    }

    public function setItemSprite(_arg1:ItemTileSprite):void {
        this.itemSprite = _arg1;
        this.itemSprite.x = (WIDTH / 2);
        this.itemSprite.y = (HEIGHT / 2);
        addChild(this.itemSprite);
    }

    public function updateUseability(_arg1:Player):void {
        var _local2:int = this.itemSprite.itemId;
        if ((((_local2 >= 0x9000)) && ((_local2 < 0xF000)))) {
            _local2 = 36863;
        }
        if (this.itemSprite.itemId != ItemConstants.NO_ITEM) {
            this.restrictedUseIndicator.visible = !(ObjectLibrary.isUsableByPlayer(_local2, _arg1));
        }
        else {
            this.restrictedUseIndicator.visible = false;
        }
    }

    public function canHoldItem(_arg1:int):Boolean {
        return (true);
    }

    public function resetItemPosition():void {
        this.setItemSprite(this.itemSprite);
    }

    public function getItemId():int {
        if ((((this.itemSprite.itemId >= 0x9000)) && ((this.itemSprite.itemId < 0xF000)))) {
            return (36863);
        }
        return (this.itemSprite.itemId);
    }

    protected function getBackgroundColor():int {
        return (0x545454);
    }


}
}
