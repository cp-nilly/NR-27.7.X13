package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class ItemTileSprite extends Sprite {

    protected static const DIM_FILTER:Array = [new ColorMatrixFilter([0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 0.4, 0, 0, 0, 0, 0, 1, 0])];
    private static const IDENTITY_MATRIX:Matrix = new Matrix();
    private static const DOSE_MATRIX:Matrix = function ():Matrix {
        var _local1:* = new Matrix();
        _local1.translate(10, 5);
        return (_local1);
    }();

    public var itemId:int;
    public var itemBitmap:Bitmap;
    private var bitmapFactory:BitmapTextFactory;

    public function ItemTileSprite() {
        this.itemBitmap = new Bitmap();
        addChild(this.itemBitmap);
        this.itemId = -1;
    }

    public function setDim(_arg1:Boolean):void {
        filters = ((_arg1) ? DIM_FILTER : null);
    }

    public function setType(_arg1:int):void {
        this.itemId = _arg1;
        this.drawTile();
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
            _local2 = ObjectLibrary.getRedrawnTextureFromType(_local1, 80, true);
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
            this.itemBitmap.y = (-(_local2.height) / 2);
            visible = true;
        }
        else {
            visible = false;
        }
    }

    public function setBitmapFactory(_arg1:BitmapTextFactory):void {
        this.bitmapFactory = _arg1;
    }


}
}
