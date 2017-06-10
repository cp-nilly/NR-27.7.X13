package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.GameObjectListItem;
import com.company.assembleegameclient.ui.GuildText;
import com.company.assembleegameclient.ui.RankText;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;

import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PlayerToolTip extends ToolTip {

    public var player_:Player;
    private var playerPanel_:GameObjectListItem;
    private var rankText_:RankText;
    private var guildText_:GuildText;
    private var hpBar_:StatusBar;
    private var mpBar_:StatusBar;
    private var clickMessage_:TextFieldDisplayConcrete;
    private var eGrid:EquippedGrid;

    public function PlayerToolTip(_arg1:Player) {
        var _local2:int;
        super(0x363636, 0.5, 0xFFFFFF, 1);
        this.player_ = _arg1;
        this.playerPanel_ = new GameObjectListItem(0xB3B3B3, true, this.player_, false, true);
        addChild(this.playerPanel_);
        _local2 = 34;
        this.rankText_ = new RankText(this.player_.numStars_, false, true, this.player_.rank_, this.player_.admin_);
        this.rankText_.x = 6;
        this.rankText_.y = _local2;
        addChild(this.rankText_);
        _local2 = (_local2 + 30);
        if (((!((_arg1.guildName_ == null))) && (!((_arg1.guildName_ == ""))))) {
            this.guildText_ = new GuildText(this.player_.guildName_, this.player_.guildRank_, 136);
            this.guildText_.x = 6;
            this.guildText_.y = (_local2 - 2);
            addChild(this.guildText_);
            _local2 = (_local2 + 30);
        }
        this.hpBar_ = new StatusBar(176, 16, 14693428, 0x545454, TextKey.STATUS_BAR_HEALTH_POINTS);
        this.hpBar_.x = 6;
        this.hpBar_.y = _local2;
        addChild(this.hpBar_);
        _local2 = (_local2 + 24);
        this.mpBar_ = new StatusBar(176, 16, 6325472, 0x545454, TextKey.STATUS_BAR_MANA_POINTS);
        this.mpBar_.x = 6;
        this.mpBar_.y = _local2;
        addChild(this.mpBar_);
        _local2 = (_local2 + 24);
        this.eGrid = new EquippedGrid(null, this.player_.slotTypes_, this.player_);
        this.eGrid.x = 8;
        this.eGrid.y = _local2;
        addChild(this.eGrid);
        _local2 = (_local2 + 52);
        this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(0xB3B3B3);
        this.clickMessage_.setAutoSize(TextFieldAutoSize.CENTER);
        this.clickMessage_.setStringBuilder(new LineBuilder().setParams(TextKey.PLAYER_TOOL_TIP_CLICK_MESSAGE));
        this.clickMessage_.filters = [new DropShadowFilter(0, 0, 0)];
        this.clickMessage_.x = (width / 2);
        this.clickMessage_.y = _local2;
        waiter.push(this.clickMessage_.textChanged);
        addChild(this.clickMessage_);
    }

    override public function draw():void {
        this.hpBar_.draw(this.player_.hp_, this.player_.maxHP_, this.player_.maxHPBoost_, this.player_.maxHPMax_);
        this.mpBar_.draw(this.player_.mp_, this.player_.maxMP_, this.player_.maxMPBoost_, this.player_.maxMPMax_);
        this.eGrid.setItems(this.player_.equipment_);
        this.rankText_.draw(this.player_.numStars_, this.player_.rank_, this.player_.admin_);
        super.draw();
    }


}
}
