package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.PointUtil;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.BlurFilter;
import flash.utils.getTimer;

import kabam.rotmg.assets.EmbeddedData;

public class Tutorial extends Sprite {

    public static const NEXT_ACTION:String = "Next";
    public static const MOVE_FORWARD_ACTION:String = "MoveForward";
    public static const MOVE_BACKWARD_ACTION:String = "MoveBackward";
    public static const ROTATE_LEFT_ACTION:String = "RotateLeft";
    public static const ROTATE_RIGHT_ACTION:String = "RotateRight";
    public static const MOVE_LEFT_ACTION:String = "MoveLeft";
    public static const MOVE_RIGHT_ACTION:String = "MoveRight";
    public static const UPDATE_ACTION:String = "Update";
    public static const ATTACK_ACTION:String = "Attack";
    public static const DAMAGE_ACTION:String = "Damage";
    public static const KILL_ACTION:String = "Kill";
    public static const SHOW_LOOT_ACTION:String = "ShowLoot";
    public static const TEXT_ACTION:String = "Text";
    public static const SHOW_PORTAL_ACTION:String = "ShowPortal";
    public static const ENTER_PORTAL_ACTION:String = "EnterPortal";
    public static const NEAR_REQUIREMENT:String = "Near";
    public static const EQUIP_REQUIREMENT:String = "Equip";

    public var gs_:GameSprite;
    public var steps_:Vector.<Step>;
    public var currStepId_:int = 0;
    private var darkBox_:Sprite;
    private var boxesBack_:Shape;
    private var boxes_:Shape;
    private var tutorialMessage_:TutorialMessage = null;

    public function Tutorial(_arg1:GameSprite) {
        var _local2:XML;
        var _local3:Graphics;
        this.steps_ = new Vector.<Step>();
        this.darkBox_ = new Sprite();
        this.boxesBack_ = new Shape();
        this.boxes_ = new Shape();
        super();
        this.gs_ = _arg1;
        for each (_local2 in EmbeddedData.tutorialXML.Step) {
            this.steps_.push(new Step(_local2));
        }
        addChild(this.boxesBack_);
        addChild(this.boxes_);
        _local3 = this.darkBox_.graphics;
        _local3.clear();
        _local3.beginFill(0, 0.1);
        _local3.drawRect(0, 0, 800, 600);
        _local3.endFill();
        Parameters.data_.needsTutorial = false;
        Parameters.save();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg1:Event):void {
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        this.draw();
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local4:Step;
        var _local5:Boolean;
        var _local6:Requirement;
        var _local7:int;
        var _local8:UIDrawBox;
        var _local9:UIDrawArrow;
        var _local10:Player;
        var _local11:Boolean;
        var _local12:GameObject;
        var _local13:Number;
        var _local2:Number = Math.abs(Math.sin((getTimer() / 300)));
        this.boxesBack_.filters = [new BlurFilter((5 + (_local2 * 5)), (5 + (_local2 * 5)))];
        this.boxes_.graphics.clear();
        this.boxesBack_.graphics.clear();
        var _local3:int;
        while (_local3 < this.steps_.length) {
            _local4 = this.steps_[_local3];
            _local5 = true;
            for each (_local6 in _local4.reqs_) {
                _local10 = this.gs_.map.player_;
                switch (_local6.type_) {
                    case NEAR_REQUIREMENT:
                        _local11 = false;
                        for each (_local12 in this.gs_.map.goDict_) {
                            if (!((!((_local12.objectType_ == _local6.objectType_))) || (((!((_local6.objectName_ == ""))) && (!((_local12.name_ == _local6.objectName_))))))) {
                                _local13 = PointUtil.distanceXY(_local12.x_, _local12.y_, _local10.x_, _local10.y_);
                                if (_local13 <= _local6.radius_) {
                                    _local11 = true;
                                    break;
                                }
                            }
                        }
                        if (!_local11) {
                            _local5 = false;
                        }
                        break;
                }
            }
            if (!_local5) {
                _local4.satisfiedSince_ = 0;
            }
            else {
                if (_local4.satisfiedSince_ == 0) {
                    _local4.satisfiedSince_ = getTimer();
                }
                _local7 = (getTimer() - _local4.satisfiedSince_);
                for each (_local8 in _local4.uiDrawBoxes_) {
                    _local8.draw((5 * _local2), this.boxes_.graphics, _local7);
                    _local8.draw((6 * _local2), this.boxesBack_.graphics, _local7);
                }
                for each (_local9 in _local4.uiDrawArrows_) {
                    _local9.draw((5 * _local2), this.boxes_.graphics, _local7);
                    _local9.draw((6 * _local2), this.boxesBack_.graphics, _local7);
                }
            }
            _local3++;
        }
    }

    function doneAction(_arg1:String):void {
        var _local3:Requirement;
        var _local4:Player;
        var _local5:Boolean;
        var _local6:GameObject;
        var _local7:Number;
        if (this.currStepId_ >= this.steps_.length) {
            return;
        }
        var _local2:Step = this.steps_[this.currStepId_];
        if (_arg1 != _local2.action_) {
            return;
        }
        for each (_local3 in _local2.reqs_) {
            _local4 = this.gs_.map.player_;
            switch (_local3.type_) {
                case NEAR_REQUIREMENT:
                    _local5 = false;
                    for each (_local6 in this.gs_.map.goDict_) {
                        if (_local6.objectType_ == _local3.objectType_) {
                            _local7 = PointUtil.distanceXY(_local6.x_, _local6.y_, _local4.x_, _local4.y_);
                            if (_local7 <= _local3.radius_) {
                                _local5 = true;
                                break;
                            }
                        }
                    }
                    if (!_local5) {
                        return;
                    }
                    break;
                case EQUIP_REQUIREMENT:
                    if (_local4.equipment_[_local3.slot_] != _local3.objectType_) {
                        return;
                    }
                    break;
            }
        }
        this.currStepId_++;
        this.draw();
    }

    private function draw():void {
        var _local3:UIDrawBox;
        return;
    }


}
}
