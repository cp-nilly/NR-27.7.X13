package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.messaging.impl.data.TradeItem;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class TradeInventory extends Sprite {

    private static const NO_CUT:Array = [0, 0, 0, 0];
    private static const cuts:Array = [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]];
    public static const CLICKITEMS_MESSAGE:int = 0;
    public static const NOTENOUGHSPACE_MESSAGE:int = 1;
    public static const TRADEACCEPTED_MESSAGE:int = 2;
    public static const TRADEWAITING_MESSAGE:int = 3;

    public var gs_:AGameSprite;
    public var playerName_:String;
    private var message_:int;
    private var nameText_:BaseSimpleText;
    private var taglineText_:TextFieldDisplayConcrete;
    public var slots_:Vector.<TradeSlot>;

    public function TradeInventory(_arg1:AGameSprite, _arg2:String, _arg3:Vector.<TradeItem>, _arg4:Boolean) {
        var _local6:TradeItem;
        var _local7:TradeSlot;
        this.slots_ = new Vector.<TradeSlot>();
        super();
        this.gs_ = _arg1;
        this.playerName_ = _arg2;
        this.nameText_ = new BaseSimpleText(20, 0xB3B3B3, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.x = 0;
        this.nameText_.y = 0;
        this.nameText_.text = this.playerName_;
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.taglineText_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
        this.taglineText_.x = 0;
        this.taglineText_.y = 22;
        this.taglineText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.taglineText_);
        var _local5:int;
        while (_local5 < (GeneralConstants.NUM_EQUIPMENT_SLOTS + GeneralConstants.NUM_INVENTORY_SLOTS)) {
            _local6 = _arg3[_local5];
            _local7 = new TradeSlot(_local6.item_, _local6.tradeable_, _local6.included_, _local6.slotType_, (_local5 - 3), cuts[_local5], _local5);
            _local7.setPlayer(this.gs_.map.player_);
            _local7.x = (int((_local5 % 4)) * (Slot.WIDTH + 4));
            _local7.y = ((int((_local5 / 4)) * (Slot.HEIGHT + 4)) + 46);
            if (((_arg4) && (_local6.tradeable_))) {
                _local7.addEventListener(MouseEvent.MOUSE_DOWN, this.onSlotClick);
            }
            this.slots_.push(_local7);
            addChild(_local7);
            _local5++;
        }
    }

    public function getOffer():Vector.<Boolean> {
        var _local1:Vector.<Boolean> = new Vector.<Boolean>();
        var _local2:int;
        while (_local2 < this.slots_.length) {
            _local1.push(this.slots_[_local2].included_);
            _local2++;
        }
        return (_local1);
    }

    public function setOffer(_arg1:Vector.<Boolean>):void {
        var _local2:int;
        while (_local2 < this.slots_.length) {
            this.slots_[_local2].setIncluded(_arg1[_local2]);
            _local2++;
        }
    }

    public function isOffer(_arg1:Vector.<Boolean>):Boolean {
        var _local2:int;
        while (_local2 < this.slots_.length) {
            if (_arg1[_local2] != this.slots_[_local2].included_) {
                return (false);
            }
            _local2++;
        }
        return (true);
    }

    public function numIncluded():int {
        var _local1:int;
        var _local2:int;
        while (_local2 < this.slots_.length) {
            if (this.slots_[_local2].included_) {
                _local1++;
            }
            _local2++;
        }
        return (_local1);
    }

    public function numEmpty():int {
        var _local1:int;
        var _local2:int = 4;
        while (_local2 < this.slots_.length) {
            if (this.slots_[_local2].isEmpty()) {
                _local1++;
            }
            _local2++;
        }
        return (_local1);
    }

    public function setMessage(_arg1:int):void {
        var _local2 = "";
        switch (_arg1) {
            case CLICKITEMS_MESSAGE:
                this.nameText_.setColor(0xB3B3B3);
                this.taglineText_.setColor(0xB3B3B3);
                _local2 = TextKey.TRADEINVENTORY_CLICKITEMSTOTRADE;
                break;
            case NOTENOUGHSPACE_MESSAGE:
                this.nameText_.setColor(0xFF0000);
                this.taglineText_.setColor(0xFF0000);
                _local2 = TextKey.TRADEINVENTORY_NOTENOUGHSPACE;
                break;
            case TRADEACCEPTED_MESSAGE:
                this.nameText_.setColor(9022300);
                this.taglineText_.setColor(9022300);
                _local2 = TextKey.TRADEINVENTORY_TRADEACCEPTED;
                break;
            case TRADEWAITING_MESSAGE:
                this.nameText_.setColor(0xB3B3B3);
                this.taglineText_.setColor(0xB3B3B3);
                _local2 = TextKey.TRADEINVENTORY_PLAYERISSELECTINGITEMS;
                break;
        }
        this.taglineText_.setStringBuilder(new LineBuilder().setParams(_local2));
    }

    private function onSlotClick(_arg1:MouseEvent):void {
        var _local2:TradeSlot = (_arg1.currentTarget as TradeSlot);
        _local2.setIncluded(!(_local2.included_));
        dispatchEvent(new Event(Event.CHANGE));
    }


}
}
