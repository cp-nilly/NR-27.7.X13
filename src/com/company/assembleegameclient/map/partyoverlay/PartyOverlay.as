package com.company.assembleegameclient.map.partyoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.Event;

public class PartyOverlay extends Sprite {

    public var map_:Map;
    public var partyMemberArrows_:Vector.<PlayerArrow> = null;
    public var questArrow_:QuestArrow;

    public function PartyOverlay(_arg1:Map) {
        var _local3:PlayerArrow;
        super();
        this.map_ = _arg1;
        this.partyMemberArrows_ = new Vector.<PlayerArrow>(Party.NUM_MEMBERS, true);
        var _local2:int;
        while (_local2 < Party.NUM_MEMBERS) {
            _local3 = new PlayerArrow();
            this.partyMemberArrows_[_local2] = _local3;
            addChild(_local3);
            _local2++;
        }
        this.questArrow_ = new QuestArrow(this.map_);
        addChild(this.questArrow_);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        GameObjectArrow.removeMenu();
    }

    public function draw(_arg1:Camera, _arg2:int):void {
        var _local6:PlayerArrow;
        var _local7:Player;
        var _local8:int;
        var _local9:PlayerArrow;
        var _local10:Number;
        var _local11:Number;
        if (this.map_.player_ == null) {
            return;
        }
        var _local3:Party = this.map_.party_;
        var _local4:Player = this.map_.player_;
        var _local5:int;
        while (_local5 < Party.NUM_MEMBERS) {
            _local6 = this.partyMemberArrows_[_local5];
            if (!_local6.mouseOver_) {
                if (_local5 >= _local3.members_.length) {
                    _local6.setGameObject(null);
                }
                else {
                    _local7 = _local3.members_[_local5];
                    if (((((_local7.drawn_) || ((_local7.map_ == null)))) || (_local7.dead_))) {
                        _local6.setGameObject(null);
                    }
                    else {
                        _local6.setGameObject(_local7);
                        _local8 = 0;
                        while (_local8 < _local5) {
                            _local9 = this.partyMemberArrows_[_local8];
                            _local10 = (_local6.x - _local9.x);
                            _local11 = (_local6.y - _local9.y);
                            if (((_local10 * _local10) + (_local11 * _local11)) < 64) {
                                if (!_local9.mouseOver_) {
                                    _local9.addGameObject(_local7);
                                }
                                _local6.setGameObject(null);
                                break;
                            }
                            _local8++;
                        }
                        _local6.draw(_arg2, _arg1);
                    }
                }
            }
            _local5++;
        }
        if (!this.questArrow_.mouseOver_) {
            this.questArrow_.draw(_arg2, _arg1);
        }
    }


}
}
