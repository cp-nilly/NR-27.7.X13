package kabam.rotmg.dailyLogin.view {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.swiftsuspenders.Injector;

public class ItemTileRenderer extends Sprite {

    protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];
    private static const IDENTITY_MATRIX:Matrix = new Matrix();
    private static const DOSE_MATRIX:Matrix = function ():Matrix {
        var _local1:* = new Matrix();
        _local1.translate(10, 5);
        return (_local1);
    }();

    private var itemId:int;
    private var bitmapFactory:BitmapTextFactory;
    private var tooltip:ToolTip;
    private var itemBitmap:Bitmap;

    public function ItemTileRenderer(_arg1:int) {
        this.itemId = _arg1;
        this.itemBitmap = new Bitmap();
        addChild(this.itemBitmap);
        this.drawTile();
        this.addEventListener(MouseEvent.MOUSE_OVER, this.onTileHover);
        this.addEventListener(MouseEvent.MOUSE_OUT, this.onTileOut);
    }

    private function onTileOut(_arg1:MouseEvent):void {
        var _local2:Injector = StaticInjectorContext.getInjector();
        var _local3:HideTooltipsSignal = _local2.getInstance(HideTooltipsSignal);
        _local3.dispatch();
    }

    private function onTileHover(_arg1:MouseEvent):void {
        if (!stage) {
            return;
        }
        var _local2:ItemTile = (_arg1.currentTarget as ItemTile);
        this.addToolTipToTile(_local2);
    }

    private function addToolTipToTile(_arg1:ItemTile):void {
        var _local4:String;
        if (this.itemId > 0) {
            this.tooltip = new EquipmentToolTip(this.itemId, null, -1, "");
        }
        else {
            if ((_arg1 is EquipmentTile)) {
                _local4 = ItemConstants.itemTypeToName((_arg1 as EquipmentTile).itemType);
            }
            else {
                _local4 = TextKey.ITEM;
            }
            this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.ITEM_EMPTY_SLOT, 200, {"itemType": TextKey.wrapForTokenResolution(_local4)});
        }
        this.tooltip.attachToTarget(_arg1);
        var _local2:Injector = StaticInjectorContext.getInjector();
        var _local3:ShowTooltipSignal = _local2.getInstance(ShowTooltipSignal);
        _local3.dispatch(this.tooltip);
    }

    public function drawTile():void {
        var _local2:BitmapData;
        var _local3:XML;
        var _local4:BitmapData;
        var _local1:int = this.itemId;
        if (_local1 != ItemConstants.NO_ITEM) {
            if ((((_local1 >= 0x9000)) && ((_local1 < 0xF000)))) {
                _local1 = 36863;
            }
            _local2 = ObjectLibrary.getRedrawnTextureFromType(_local1, CalendarSettings.ITEM_SIZE, true);
            _local3 = ObjectLibrary.xmlLibrary_[_local1];
            if (((((_local3) && (_local3.hasOwnProperty("Doses")))) && (this.bitmapFactory))) {
                _local2 = _local2.clone();
                _local4 = this.bitmapFactory.make(new StaticStringBuilder(String(_local3.Doses)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                _local2.draw(_local4, DOSE_MATRIX);
            }
            if (((((_local3) && (_local3.hasOwnProperty("Quantity")))) && (this.bitmapFactory))) {
                _local2 = _local2.clone();
                _local4 = this.bitmapFactory.make(new StaticStringBuilder(String(_local3.Quantity)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
                _local2.draw(_local4, DOSE_MATRIX);
            }
            this.itemBitmap.bitmapData = _local2;
            this.itemBitmap.x = (-(_local2.width) / 2);
            this.itemBitmap.y = (-(_local2.width) / 2);
            visible = true;
        }
        else {
            visible = false;
        }
    }


}
}
