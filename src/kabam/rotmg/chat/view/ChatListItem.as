package kabam.rotmg.chat.view {
import com.company.assembleegameclient.objects.Player;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

public class ChatListItem extends Sprite {

    private static const CHAT_ITEM_TIMEOUT:uint = 20000;

    private var itemWidth:int;
    private var list:Vector.<DisplayObject>;
    private var count:uint;
    private var layoutHeight:uint;
    private var creationTime:uint;
    private var timedOutOverride:Boolean;
    public var playerObjectId:int;
    public var playerName:String = "";
    public var fromGuild:Boolean = false;
    public var isTrade:Boolean = false;

    public function ChatListItem(_arg1:Vector.<DisplayObject>, _arg2:int, _arg3:int, _arg4:Boolean, _arg5:int, _arg6:String, _arg7:Boolean, _arg8:Boolean) {
        mouseEnabled = true;
        this.itemWidth = _arg2;
        this.layoutHeight = _arg3;
        this.list = _arg1;
        this.count = _arg1.length;
        this.creationTime = getTimer();
        this.timedOutOverride = _arg4;
        this.playerObjectId = _arg5;
        this.playerName = _arg6;
        this.fromGuild = _arg7;
        this.isTrade = _arg8;
        this.layoutItems();
        this.addItems();
        addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onRightMouseDown);
    }

    public function onRightMouseDown(e:MouseEvent):void {
        var hmod:HUDModel;
        var aPlayer:Player;
        try {
            hmod = StaticInjectorContext.getInjector().getInstance(HUDModel);
            if (((((!((hmod.gameSprite.map.goDict_[this.playerObjectId] == null))) && ((hmod.gameSprite.map.goDict_[this.playerObjectId] is Player)))) && (!((hmod.gameSprite.map.player_.objectId_ == this.playerObjectId))))) {
                aPlayer = (hmod.gameSprite.map.goDict_[this.playerObjectId] as Player);
                hmod.gameSprite.addChatPlayerMenu(aPlayer, e.stageX, e.stageY);
            }
            else {
                if (((((((!(this.isTrade)) && (!((this.playerName == null))))) && (!((this.playerName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.playerName))))) {
                    hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.playerName, this.fromGuild);
                }
                else {
                    if (((((((this.isTrade) && (!((this.playerName == null))))) && (!((this.playerName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.playerName))))) {
                        hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.playerName, false, true);
                    }
                }
            }
        }
        catch (e:Error) {
        }
    }

    public function isTimedOut():Boolean {
        return ((((getTimer() > (this.creationTime + CHAT_ITEM_TIMEOUT))) || (this.timedOutOverride)));
    }

    private function layoutItems():void {
        var _local1:int;
        var _local3:DisplayObject;
        var _local4:Rectangle;
        var _local5:int;
        _local1 = 0;
        var _local2:int;
        while (_local2 < this.count) {
            _local3 = this.list[_local2];
            _local4 = _local3.getRect(_local3);
            _local3.x = _local1;
            _local3.y = (((this.layoutHeight - _local4.height) * 0.5) - this.layoutHeight);
            if ((_local1 + _local4.width) > this.itemWidth) {
                _local3.x = 0;
                _local1 = 0;
                _local5 = 0;
                while (_local5 < _local2) {
                    this.list[_local5].y = (this.list[_local5].y - this.layoutHeight);
                    _local5++;
                }
            }
            _local1 = (_local1 + _local4.width);
            _local2++;
        }
    }

    private function addItems():void {
        var _local1:DisplayObject;
        for each (_local1 in this.list) {
            addChild(_local1);
        }
    }


}
}
