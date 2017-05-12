package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;
import com.company.util.IntPoint;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class Merchant extends SellableObject implements IInteractiveObject {

    private static const NONE_MESSAGE:int = 0;
    private static const NEW_MESSAGE:int = 1;
    private static const MINS_LEFT_MESSAGE:int = 2;
    private static const ITEMS_LEFT_MESSAGE:int = 3;
    private static const DISCOUNT_MESSAGE:int = 4;
    private static const T:Number = 1;
    private static const DOSE_MATRIX:Matrix = function ():Matrix {
        var _local1:* = new Matrix();
        _local1.translate(10, 5);
        return (_local1);
    }();

    public var merchandiseType_:int = -1;
    public var count_:int = -1;
    public var minsLeft_:int = -1;
    public var discount_:int = 0;
    public var merchandiseTexture_:BitmapData = null;
    public var untilNextMessage_:int = 0;
    public var alpha_:Number = 1;
    private var addSpeechBalloon:AddSpeechBalloonSignal;
    private var stringMap:StringMap;
    private var firstUpdate_:Boolean = true;
    private var messageIndex_:int = 0;
    private var ct_:ColorTransform;

    public function Merchant(_arg1:XML) {
        this.ct_ = new ColorTransform(1, 1, 1, 1);
        this.addSpeechBalloon = StaticInjectorContext.getInjector().getInstance(AddSpeechBalloonSignal);
        this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        super(_arg1);
        isInteractive_ = true;
    }

    override public function setPrice(_arg1:int):void {
        super.setPrice(_arg1);
        this.untilNextMessage_ = 0;
    }

    override public function setRankReq(_arg1:int):void {
        super.setRankReq(_arg1);
        this.untilNextMessage_ = 0;
    }

    override public function addTo(_arg1:Map, _arg2:Number, _arg3:Number):Boolean {
        if (!super.addTo(_arg1, _arg2, _arg3)) {
            return (false);
        }
        _arg1.merchLookup_[new IntPoint(x_, y_)] = this;
        return (true);
    }

    override public function removeFromMap():void {
        var _local1:IntPoint = new IntPoint(x_, y_);
        if (map_.merchLookup_[_local1] == this) {
            map_.merchLookup_[_local1] = null;
        }
        super.removeFromMap();
    }

    public function getSpeechBalloon(_arg1:int):AddSpeechBalloonVO {
        var _local2:LineBuilder;
        var _local3:uint;
        var _local4:uint;
        var _local5:uint;
        switch (_arg1) {
            case NEW_MESSAGE:
                _local2 = new LineBuilder().setParams("Merchant.new");
                _local3 = 0xE6E6E6;
                _local4 = 0xFFFFFF;
                _local5 = 5931045;
                break;
            case MINS_LEFT_MESSAGE:
                if (this.minsLeft_ == 0) {
                    _local2 = new LineBuilder().setParams("Merchant.goingSoon");
                }
                else {
                    if (this.minsLeft_ == 1) {
                        _local2 = new LineBuilder().setParams("Merchant.goingInOneMinute");
                    }
                    else {
                        _local2 = new LineBuilder().setParams("Merchant.goingInNMinutes", {"minutes": this.minsLeft_});
                    }
                }
                _local3 = 5973542;
                _local4 = 16549442;
                _local5 = 16549442;
                break;
            case ITEMS_LEFT_MESSAGE:
                _local2 = new LineBuilder().setParams("Merchant.limitedStock", {"count": this.count_});
                _local3 = 5973542;
                _local4 = 16549442;
                _local5 = 16549442;
                break;
            case DISCOUNT_MESSAGE:
                _local2 = new LineBuilder().setParams("Merchant.discount", {"discount": this.discount_});
                _local3 = 6324275;
                _local4 = 16777103;
                _local5 = 16777103;
                break;
            default:
                return (null);
        }
        _local2.setStringMap(this.stringMap);
        return (new AddSpeechBalloonVO(this, _local2.getString(), "", false, false, _local3, 1, _local4, 1, _local5, 6, true, false));
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local5:GTween;
        super.update(_arg1, _arg2);
        if (this.firstUpdate_) {
            if (this.minsLeft_ == 2147483647) {
                _local5 = new GTween(this, (0.5 * T), {"size_": 150}, {"ease": Sine.easeOut});
                _local5.nextTween = new GTween(this, (0.5 * T), {"size_": 100}, {"ease": Sine.easeIn});
                _local5.nextTween.paused = true;
            }
            this.firstUpdate_ = false;
        }
        this.untilNextMessage_ = (this.untilNextMessage_ - _arg2);
        if (this.untilNextMessage_ > 0) {
            return (true);
        }
        this.untilNextMessage_ = 5000;
        var _local3:Vector.<int> = new Vector.<int>();
        if (this.minsLeft_ == 2147483647) {
            _local3.push(NEW_MESSAGE);
        }
        else {
            if ((((this.minsLeft_ >= 0)) && ((this.minsLeft_ <= 5)))) {
                _local3.push(MINS_LEFT_MESSAGE);
            }
        }
        if ((((this.count_ >= 1)) && ((this.count_ <= 2)))) {
            _local3.push(ITEMS_LEFT_MESSAGE);
        }
        if (this.discount_ > 0) {
            _local3.push(DISCOUNT_MESSAGE);
        }
        if (_local3.length == 0) {
            return (true);
        }
        this.messageIndex_ = (++this.messageIndex_ % _local3.length);
        var _local4:int = _local3[this.messageIndex_];
        this.addSpeechBalloon.dispatch(this.getSpeechBalloon(_local4));
        return (true);
    }

    override public function soldObjectName():String {
        return (ObjectLibrary.typeToDisplayId_[this.merchandiseType_]);
    }

    override public function soldObjectInternalName():String {
        var _local1:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        return (_local1.@id.toString());
    }

    override public function getTooltip():ToolTip {
        return (new EquipmentToolTip(this.merchandiseType_, map_.player_, -1, InventoryOwnerTypes.NPC));
    }

    override public function getSellableType():int {
        return (this.merchandiseType_);
    }

    override public function getIcon():BitmapData {
        var _local3:BaseSimpleText;
        var _local1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, 80, true);
        var _local2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local2.hasOwnProperty("Doses")) {
            _local1 = _local1.clone();
            _local3 = new BaseSimpleText(12, 0xFFFFFF, false, 0, 0);
            _local3.text = String(_local2.Doses);
            _local3.updateMetrics();
            _local1.draw(_local3, DOSE_MATRIX);
        }
        if (_local2.hasOwnProperty("Quantity")) {
            _local1 = _local1.clone();
            _local3 = new BaseSimpleText(12, 0xFFFFFF, false, 0, 0);
            _local3.text = String(_local2.Quantity);
            _local3.updateMetrics();
            _local1.draw(_local3, DOSE_MATRIX);
        }
        return (_local1);
    }

    public function getTex1Id(_arg1:int):int {
        var _local2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local2 == null) {
            return (_arg1);
        }
        if ((((_local2.Activate == "Dye")) && (_local2.hasOwnProperty("Tex1")))) {
            return (int(_local2.Tex1));
        }
        return (_arg1);
    }

    public function getTex2Id(_arg1:int):int {
        var _local2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local2 == null) {
            return (_arg1);
        }
        if ((((_local2.Activate == "Dye")) && (_local2.hasOwnProperty("Tex2")))) {
            return (int(_local2.Tex2));
        }
        return (_arg1);
    }

    override protected function getTexture(_arg1:Camera, _arg2:int):BitmapData {
        if ((((this.alpha_ == 1)) && ((size_ == 100)))) {
            return (this.merchandiseTexture_);
        }
        var _local3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, size_, false, false);
        if (this.alpha_ != 1) {
            this.ct_.alphaMultiplier = this.alpha_;
            _local3.colorTransform(_local3.rect, this.ct_);
        }
        return (_local3);
    }

    public function setMerchandiseType(_arg1:int):void {
        this.merchandiseType_ = _arg1;
        this.merchandiseTexture_ = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, 100, false);
    }


}
}
