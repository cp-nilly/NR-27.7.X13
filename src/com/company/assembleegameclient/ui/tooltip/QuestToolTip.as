package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.partyoverlay.QuestArrow;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.GameObjectListItem;

import flash.display.Graphics;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class QuestToolTip extends ToolTip {

    private var text_:TextFieldDisplayConcrete;
    public var enemyGOLI_:GameObjectListItem;
    public var questObj:GameObject;
    public var bar:Sprite;
    public var hMeter:Sprite;
    public var playerDistText:TextFieldDisplayConcrete;
    public var dist:int;
    public var closestPlayer:Player;

    public function QuestToolTip(gameObject:GameObject) {
        super(6036765, 1, 16549442, 1, false);
        this.text_ = new TextFieldDisplayConcrete().setSize(22).setColor(16549442).setBold(true);
        this.text_.setStringBuilder(new LineBuilder().setParams(TextKey.QUEST_TOOLTIP_QUEST));
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        this.text_.x = 0;
        this.text_.y = 0;
        waiter.push(this.text_.textChanged);
        addChild(this.text_);
        this.enemyGOLI_ = new GameObjectListItem(0xB3B3B3, true, gameObject);
        this.enemyGOLI_.x = 0;
        this.enemyGOLI_.y = 32;
        waiter.push(this.enemyGOLI_.textReady);
        addChild(this.enemyGOLI_);
        filters = [];
        this.questObj = gameObject;
        this.bar = new Sprite();
        this.bar.x = (this.enemyGOLI_.portrait.height - 7);
        this.bar.y = ((56 + this.enemyGOLI_.portrait.height) - this.enemyGOLI_.height);
        this.hMeter = new Sprite();
        this.bar.addChild(this.hMeter);
        this.playerDistText = new TextFieldDisplayConcrete().setSize(13).setColor(0xFC8642).setBold(true);
        this.playerDistText.y = 5;
        this.bar.addChild(this.playerDistText);
        if (Parameters.data_.enhancedQuestToolTip == true) {
            addChild(this.bar);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function onAddedToStage(event:Event) {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        this.stage.addEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick);
    }

    public function onRemovedFromStage(event:Event) {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.stage.removeEventListener(MouseEvent.RIGHT_CLICK, this.onRightClick);
    }

    public function onRightClick(me:MouseEvent):void {
        var questArrow:QuestArrow;
        var map:Map;
        if (me.target is QuestArrow) {
            questArrow = (me.target as QuestArrow);
            if (questArrow.tooltip_ is QuestToolTip) {
                map = this.questObj.map_;
                if (((((!((map == null))) && (map.allowPlayerTeleport()))) && (!((map.player_ == this.closestPlayer))))) {
                    map.player_.teleportTo(this.closestPlayer);
                }
            }
        }
    }

    public function getDist(playerX:Number, playerY:Number, questX:Number, questY:Number):Number {
        var x_:* = (playerX - questX);
        var y_:* = (playerY - questY);
        return (Math.sqrt(((x_ * x_) + (y_ * y_))));
    }

    public function updateDist():void {
        var gameObject:GameObject;
        var dist:int;
        var map:Map = this.questObj.map_;
        this.dist = int.MAX_VALUE;
        for each (gameObject in map) {
            if (gameObject is Player) {
                dist = this.getDist(gameObject.x_, gameObject.y_, this.questObj.x_, this.questObj.y_);
                if (dist < this.dist) {
                    this.dist = dist;
                    this.closestPlayer = (gameObject as Player);
                }
            }
        }
    }

    public function getHPColor(hp:int):int {
        if (hp > 50) {
            return (0xFF00 + (327680 * int(100 - hp)));
        }
        return (0xFFFF00 - (0x0500 * int(50 - hp)));
    }

    public function drawBar(_arg1:int, _arg2:int, _arg3:Number=100, _arg4:Number=3, _arg5:uint=0x545454, _arg6:uint=0xFF00) {
        this.bar.graphics.clear();
        var bar:Graphics = this.bar.graphics;
        bar.lineStyle(0, 0x545454);
        bar.beginFill(_arg5);
        bar.lineTo(_arg3, 0);
        bar.lineTo(_arg3, _arg4);
        bar.lineTo(0, _arg4);
        bar.lineTo(0, 0);
        bar.endFill();
        var _local8:Number = (_arg1 / _arg2);
        _arg3 = (_arg3 * _local8);
        this.hMeter.graphics.clear();
        var hMeter:Graphics = this.hMeter.graphics;
        hMeter.lineStyle(0, 0x545454);
        hMeter.beginFill(this.getHPColor(_local8 * 100));
        hMeter.lineTo(_arg3, 0);
        hMeter.lineTo(_arg3, _arg4);
        hMeter.lineTo(0, _arg4);
        hMeter.lineTo(0, 0);
        hMeter.endFill();
    }

    override public function draw():void {
        if ((((Parameters.data_.enhancedQuestToolTip == true)) && (!((this.questObj.map_ == null))))) {
            this.updateDist();
            this.drawBar(this.questObj.hp_, this.questObj.maxHP_, ((this.enemyGOLI_.width - this.enemyGOLI_.portrait.width) - 4));
            this.playerDistText.setStringBuilder(new LineBuilder().setParams("blank", {"data":this.dist}));
            this.playerDistText.x = ((this.bar.width / 2) - (this.playerDistText.width / 2));
        }
        super.draw();
    }

}
}
