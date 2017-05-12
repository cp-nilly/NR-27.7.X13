package com.company.assembleegameclient.ui.panels {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Party;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.PlayerGameObjectListItem;
import com.company.assembleegameclient.ui.menu.PlayerMenu;
import com.company.util.MoreColorUtil;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

public class PartyPanel extends Panel {

    public var menuLayer:DisplayObjectContainer;
    public var memberPanels:Vector.<PlayerGameObjectListItem>;
    public var mouseOver_:Boolean;
    public var menu:PlayerMenu;

    public function PartyPanel(_arg1:GameSprite) {
        this.memberPanels = new Vector.<PlayerGameObjectListItem>(Party.NUM_MEMBERS, true);
        super(_arg1);
        this.memberPanels[0] = this.createPartyMemberPanel(0, 0);
        this.memberPanels[1] = this.createPartyMemberPanel(100, 0);
        this.memberPanels[2] = this.createPartyMemberPanel(0, 32);
        this.memberPanels[3] = this.createPartyMemberPanel(100, 32);
        this.memberPanels[4] = this.createPartyMemberPanel(0, 64);
        this.memberPanels[5] = this.createPartyMemberPanel(100, 64);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function createPartyMemberPanel(_arg1:int, _arg2:int):PlayerGameObjectListItem {
        var _local3:PlayerGameObjectListItem = new PlayerGameObjectListItem(0xFFFFFF, false, null);
        addChild(_local3);
        _local3.x = (_arg1 - 5);
        _local3.y = (_arg2 - 8);
        return (_local3);
    }

    private function onAddedToStage(_arg1:Event):void {
        var _local2:PlayerGameObjectListItem;
        for each (_local2 in this.memberPanels) {
            _local2.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            _local2.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            _local2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        var _local2:PlayerGameObjectListItem;
        this.removeMenu();
        for each (_local2 in this.memberPanels) {
            _local2.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            _local2.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            _local2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        if (((!((this.menu == null))) && (!((this.menu.parent == null))))) {
            return;
        }
        var _local2:PlayerGameObjectListItem = (_arg1.currentTarget as PlayerGameObjectListItem);
        var _local3:Player = (_local2.go as Player);
        if ((((_local3 == null)) || ((_local3.texture_ == null)))) {
            return;
        }
        this.mouseOver_ = true;
    }

    private function onMouseOut(_arg1:MouseEvent):void {
        this.mouseOver_ = false;
    }

    private function onMouseDown(_arg1:MouseEvent):void {
        this.removeMenu();
        var _local2:PlayerGameObjectListItem = (_arg1.currentTarget as PlayerGameObjectListItem);
        _local2.setEnabled(false);
        this.menu = new PlayerMenu();
        this.menu.init(gs_, (_local2.go as Player));
        this.menuLayer.addChild(this.menu);
        this.menu.addEventListener(Event.REMOVED_FROM_STAGE, this.onMenuRemoved);
    }

    private function onMenuRemoved(_arg1:Event):void {
        var _local2:GameObjectListItem;
        var _local3:PlayerGameObjectListItem;
        for each (_local2 in this.memberPanels) {
            _local3 = (_local2 as PlayerGameObjectListItem);
            if (_local3) {
                _local3.setEnabled(true);
            }
        }
        _arg1.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, this.onMenuRemoved);
    }

    private function removeMenu():void {
        if (this.menu != null) {
            this.menu.remove();
            this.menu = null;
        }
    }

    override public function draw():void {
        var _local4:GameObjectListItem;
        var _local5:Player;
        var _local6:ColorTransform;
        var _local7:Number;
        var _local8:int;
        var _local1:Party = gs_.map.party_;
        if (_local1 == null) {
            for each (_local4 in this.memberPanels) {
                _local4.clear();
            }
            return;
        }
        var _local2:int;
        var _local3:int;
        while (_local3 < Party.NUM_MEMBERS) {
            if (((this.mouseOver_) || (((!((this.menu == null))) && (!((this.menu.parent == null))))))) {
                _local5 = (this.memberPanels[_local3].go as Player);
            }
            else {
                _local5 = _local1.members_[_local3];
            }
            if (((!((_local5 == null))) && ((_local5.map_ == null)))) {
                _local5 = null;
            }
            _local6 = null;
            if (_local5 != null) {
                if (_local5.hp_ < (_local5.maxHP_ * 0.2)) {
                    if (_local2 == 0) {
                        _local2 = getTimer();
                    }
                    _local7 = (int((Math.abs(Math.sin((_local2 / 200))) * 10)) / 10);
                    _local8 = 128;
                    _local6 = new ColorTransform(1, 1, 1, 1, (_local7 * _local8), (-(_local7) * _local8), (-(_local7) * _local8));
                }
                if (!_local5.starred_) {
                    if (_local6 != null) {
                        _local6.concat(MoreColorUtil.darkCT);
                    }
                    else {
                        _local6 = MoreColorUtil.darkCT;
                    }
                }
            }
            this.memberPanels[_local3].draw(_local5, _local6);
            _local3++;
        }
    }


}
}
