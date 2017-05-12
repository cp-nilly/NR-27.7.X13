package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;
import com.company.util.SpriteUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class TradeSlot extends Slot implements TooltipAble {

    private static const IDENTITY_MATRIX:Matrix = new Matrix();
    public static const EMPTY:int = -1;
    private static const DOSE_MATRIX:Matrix = makeDoseMatrix();

    public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

    public var included_:Boolean;
    public var equipmentToolTipFactory:EquipmentToolTipFactory;
    private var id:uint;
    private var item_:int;
    private var overlay_:Shape;
    private var overlayFill_:GraphicsSolidFill;
    private var lineStyle_:GraphicsStroke;
    private var overlayPath_:GraphicsPath;
    private var graphicsData_:Vector.<IGraphicsData>;
    private var bitmapFactory:BitmapTextFactory;

    public function TradeSlot(_arg1:int, _arg2:Boolean, _arg3:Boolean, _arg4:int, _arg5:int, _arg6:Array, _arg7:uint) {
        this.equipmentToolTipFactory = new EquipmentToolTipFactory();
        this.overlayFill_ = new GraphicsSolidFill(16711310, 1);
        this.lineStyle_ = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, this.overlayFill_);
        this.overlayPath_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsData_ = new <IGraphicsData>[this.lineStyle_, this.overlayPath_, GraphicsUtil.END_STROKE];
        super(_arg4, _arg5, _arg6);
        this.id = _arg7;
        this.item_ = _arg1;
        this.included_ = _arg3;
        this.drawItemIfAvailable();
        if (!_arg2) {
            transform.colorTransform = MoreColorUtil.veryDarkCT;
        }
        this.overlay_ = this.getOverlay();
        addChild(this.overlay_);
        this.setIncluded(_arg3);
        this.hoverTooltipDelegate.setDisplayObject(this);
    }

    private static function makeDoseMatrix():Matrix {
        var _local1:Matrix = new Matrix();
        _local1.translate(10, 5);
        return (_local1);
    }


    private function drawItemIfAvailable():void {
        if (!this.isEmpty()) {
            this.drawItem();
        }
    }

    private function drawItem():void {
        var _local4:Bitmap;
        var _local5:BitmapData;
        SpriteUtil.safeRemoveChild(this, backgroundImage_);
        var _local1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.item_, 80, true);
        var _local2:XML = ObjectLibrary.xmlLibrary_[this.item_];
        if (((_local2.hasOwnProperty("Doses")) && (this.bitmapFactory))) {
            _local1 = _local1.clone();
            _local5 = this.bitmapFactory.make(new StaticStringBuilder(String(_local2.Doses)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
            _local1.draw(_local5, DOSE_MATRIX);
        }
        if (((_local2.hasOwnProperty("Quantity")) && (this.bitmapFactory))) {
            _local1 = _local1.clone();
            _local5 = this.bitmapFactory.make(new StaticStringBuilder(String(_local2.Quantity)), 12, 0xFFFFFF, false, IDENTITY_MATRIX, false);
            _local1.draw(_local5, DOSE_MATRIX);
        }
        var _local3:Point = offsets(this.item_, type_, false);
        _local4 = new Bitmap(_local1);
        _local4.x = (((WIDTH / 2) - (_local4.width / 2)) + _local3.x);
        _local4.y = (((HEIGHT / 2) - (_local4.height / 2)) + _local3.y);
        SpriteUtil.safeAddChild(this, _local4);
    }

    public function setIncluded(_arg1:Boolean):void {
        this.included_ = _arg1;
        this.overlay_.visible = this.included_;
        if (this.included_) {
            fill_.color = 16764247;
        }
        else {
            fill_.color = 0x545454;
        }
        drawBackground();
    }

    public function setBitmapFactory(_arg1:BitmapTextFactory):void {
        this.bitmapFactory = _arg1;
        this.drawItemIfAvailable();
    }

    private function getOverlay():Shape {
        var _local1:Shape = new Shape();
        GraphicsUtil.clearPath(this.overlayPath_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, cuts_, this.overlayPath_);
        _local1.graphics.drawGraphicsData(this.graphicsData_);
        return (_local1);
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

    public function setPlayer(_arg1:Player):void {
        if (!this.isEmpty()) {
            this.hoverTooltipDelegate.tooltip = this.equipmentToolTipFactory.make(this.item_, _arg1, -1, InventoryOwnerTypes.OTHER_PLAYER, this.id);
        }
    }

    public function isEmpty():Boolean {
        return ((this.item_ == EMPTY));
    }


}
}
