package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.util.GuildUtil;
import com.company.util.AssetLibrary;

import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.controller.FriendActionSignal;
import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendRequestVO;
import kabam.rotmg.text.model.TextKey;

public class PlayerMenu extends Menu {

    public var gs_:AGameSprite;
    public var playerName_:String;
    public var player_:Player;
    public var playerPanel_:GameObjectListItem;

    public function PlayerMenu() {
        super(0x363636, 0xFFFFFF);
    }

    public function initDifferentServer(_arg1:AGameSprite, _arg2:String, _arg3:Boolean = false, _arg4:Boolean = false):void {
        var _local5:MenuOption;
        this.gs_ = _arg1;
        this.playerName_ = _arg2;
        this.player_ = null;
        this.yOffset = (this.yOffset - 25);
        _local5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_PM);
        _local5.addEventListener(MouseEvent.CLICK, this.onPrivateMessage);
        addOption(_local5);
        _local5 = new MenuOption(AssetLibrary.getImageFromSet("lotfInterfaceBig", 10), 0xFFFFFF, TextKey.FRIEND_ADD_TITLE);
        _local5.addEventListener(MouseEvent.CLICK, this.onAddFriend);
        addOption(_local5);
        if (_arg3) {
            _local5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_GUILDCHAT);
            _local5.addEventListener(MouseEvent.CLICK, this.onGuildMessage);
            addOption(_local5);
        }
        if (_arg4) {
            _local5 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 7), 0xFFFFFF, TextKey.PLAYERMENU_TRADE);
            _local5.addEventListener(MouseEvent.CLICK, this.onTradeMessage);
            addOption(_local5);
        }
    }

    public function init(_arg1:AGameSprite, _arg2:Player):void {
        var _local3:MenuOption;
        this.gs_ = _arg1;
        this.playerName_ = _arg2.name_;
        this.player_ = _arg2;
        this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_, false, true);
        this.yOffset = (this.yOffset + 7);
        addChild(this.playerPanel_);
        if (((Player.isAdmin) || (Player.isMod))) {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban MultiBoxer");
            _local3.addEventListener(MouseEvent.CLICK, this.onKickMultiBox);
            addOption(_local3);
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban RWT");
            _local3.addEventListener(MouseEvent.CLICK, this.onKickRWT);
            addOption(_local3);
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, "Ban Cheat");
            _local3.addEventListener(MouseEvent.CLICK, this.onKickCheat);
            addOption(_local3);
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 4), 0xFFFFFF, TextKey.PLAYERMENU_MUTE);
            _local3.addEventListener(MouseEvent.CLICK, this.onMute);
            addOption(_local3);
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 3), 0xFFFFFF, TextKey.PLAYERMENU_UNMUTE);
            _local3.addEventListener(MouseEvent.CLICK, this.onUnMute);
            addOption(_local3);
        }
        if (((this.gs_.map.allowPlayerTeleport()) && (this.player_.isTeleportEligible(this.player_)))) {
            _local3 = new TeleportMenuOption(this.gs_.map.player_);
            _local3.addEventListener(MouseEvent.CLICK, this.onTeleport);
            addOption(_local3);
        }
        if ((((this.gs_.map.player_.guildRank_ >= GuildUtil.OFFICER)) && ((((_arg2.guildName_ == null)) || ((_arg2.guildName_.length == 0)))))) {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 10), 0xFFFFFF, TextKey.PLAYERMENU_INVITE);
            _local3.addEventListener(MouseEvent.CLICK, this.onInvite);
            addOption(_local3);
        }
        if (!this.player_.starred_) {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 5), 0xFFFFFF, TextKey.PLAYERMENU_LOCK);
            _local3.addEventListener(MouseEvent.CLICK, this.onLock);
            addOption(_local3);
        }
        else {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterface2", 6), 0xFFFFFF, TextKey.PLAYERMENU_UNLOCK);
            _local3.addEventListener(MouseEvent.CLICK, this.onUnlock);
            addOption(_local3);
        }
        _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 7), 0xFFFFFF, TextKey.PLAYERMENU_TRADE);
        _local3.addEventListener(MouseEvent.CLICK, this.onTrade);
        addOption(_local3);
        _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_PM);
        _local3.addEventListener(MouseEvent.CLICK, this.onPrivateMessage);
        addOption(_local3);
        if (this.player_.isFellowGuild_) {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 21), 0xFFFFFF, TextKey.PLAYERMENU_GUILDCHAT);
            _local3.addEventListener(MouseEvent.CLICK, this.onGuildMessage);
            addOption(_local3);
        }
        if (!this.player_.ignored_) {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 8), 0xFFFFFF, TextKey.FRIEND_BLOCK_BUTTON);
            _local3.addEventListener(MouseEvent.CLICK, this.onIgnore);
            addOption(_local3);
        }
        else {
            _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 9), 0xFFFFFF, TextKey.PLAYERMENU_UNIGNORE);
            _local3.addEventListener(MouseEvent.CLICK, this.onUnignore);
            addOption(_local3);
        }
        _local3 = new MenuOption(AssetLibrary.getImageFromSet("lofiInterfaceBig", 18), 0xFFFFFF, "Add as Friend");
        _local3.addEventListener(MouseEvent.CLICK, this.onAddFriend);
        addOption(_local3);
    }

    private function onKickMultiBox(_arg1:Event):void {
        this.gs_.gsc_.playerText((("/kick " + this.player_.name_) + " Multiboxing"));
        remove();
    }

    private function onKickRWT(_arg1:Event):void {
        this.gs_.gsc_.playerText((("/kick " + this.player_.name_) + " RWT"));
        remove();
    }

    private function onKickCheat(_arg1:Event):void {
        this.gs_.gsc_.playerText((("/kick " + this.player_.name_) + " Cheating"));
        remove();
    }

    private function onMute(_arg1:Event):void {
        this.gs_.gsc_.playerText(("/mute " + this.player_.name_));
        remove();
    }

    private function onUnMute(_arg1:Event):void {
        this.gs_.gsc_.playerText(("/unmute " + this.player_.name_));
        remove();
    }

    private function onPrivateMessage(_arg1:Event):void {
        var _local2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local2.dispatch(true, (("/tell " + this.playerName_) + " "));
        remove();
    }

    private function onAddFriend(_arg1:Event):void {
        var _local2:FriendActionSignal = StaticInjectorContext.getInjector().getInstance(FriendActionSignal);
        _local2.dispatch(new FriendRequestVO(FriendConstant.INVITE, this.playerName_));
        remove();
    }

    private function onTradeMessage(_arg1:Event):void {
        var _local2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local2.dispatch(true, ("/trade " + this.playerName_));
        remove();
    }

    private function onGuildMessage(_arg1:Event):void {
        var _local2:ShowChatInputSignal = StaticInjectorContext.getInjector().getInstance(ShowChatInputSignal);
        _local2.dispatch(true, "/g ");
        remove();
    }

    private function onTeleport(_arg1:Event):void {
        this.gs_.map.player_.teleportTo(this.player_);
        remove();
    }

    private function onInvite(_arg1:Event):void {
        this.gs_.gsc_.guildInvite(this.playerName_);
        remove();
    }

    private function onLock(_arg1:Event):void {
        this.gs_.map.party_.lockPlayer(this.player_);
        remove();
    }

    private function onUnlock(_arg1:Event):void {
        this.gs_.map.party_.unlockPlayer(this.player_);
        remove();
    }

    private function onTrade(_arg1:Event):void {
        this.gs_.gsc_.requestTrade(this.playerName_);
        remove();
    }

    private function onIgnore(_arg1:Event):void {
        this.gs_.map.party_.ignorePlayer(this.player_);
        remove();
    }

    private function onUnignore(_arg1:Event):void {
        this.gs_.map.party_.unignorePlayer(this.player_);
        remove();
    }


}
}
