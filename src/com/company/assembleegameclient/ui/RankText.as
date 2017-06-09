package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.util.FameUtil;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class RankText extends Sprite {

    public var background:Sprite = null;
    public var largeText_:Boolean;
    private var numStars_:int = -1;
    private var rank_:int = 0;
    private var admin_:Boolean = false;
    private var prefix_:TextFieldDisplayConcrete = null;
    private var waiter:SignalWaiter;
    private var icon:Sprite;

    public function RankText(numStars:int, largeText:Boolean, showPrefix:Boolean, rank:int = 0, isAdmin:Boolean = false) {
        this.waiter = new SignalWaiter();
        super();
        this.largeText_ = largeText;
        if (showPrefix) {
            this.prefix_ = this.makeText();
            this.prefix_.setStringBuilder(new LineBuilder().setParams(TextKey.RANK_TEXT_RANK));
            this.prefix_.filters = [new DropShadowFilter(0, 0, 0)];
            this.prefix_.textChanged.addOnce(this.position);
            addChild(this.prefix_);
        }
        mouseEnabled = false;
        mouseChildren = false;
        this.draw(numStars, rank, isAdmin);
    }

    public function makeText():TextFieldDisplayConcrete {
        var _local1:int = ((this.largeText_) ? 18 : 16);
        var _local2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local2.setSize(_local1).setColor(0xB3B3B3);
        _local2.setBold(this.largeText_);
        return (_local2);
    }

    public function draw(numStars:int, rank:int, admin:Boolean):void {
        var text:TextFieldDisplayConcrete;
        var onTextChanged:Function;
        onTextChanged = function ():void {
            text.y = text.height;
            icon.x = (text.width + 2);
            icon.y = (text.y - icon.height);
            var _local1:int = (icon.x + icon.width);
            background.graphics.clear();
            background.graphics.beginFill(0, 0.4);
            var _local2:Number = (icon.height + 8);
            background.graphics.drawRoundRect(-2, (icon.y - 3), (_local1 + 6), _local2, 12, 12);
            background.graphics.endFill();
            position();
        };
        if (numStars == this.numStars_ && rank == this.rank_) {
            return;
        }
        this.numStars_ = numStars;
        this.rank_ = rank;
        this.admin_ = admin;
        if (((!((this.background == null))) && (contains(this.background)))) {
            removeChild(this.background);
        }
        if (this.numStars_ < 0) {
            return;
        }
        this.background = new Sprite();
        text = this.makeText();
        text.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        text.setStringBuilder(new StaticStringBuilder(this.numStars_.toString() + (rank ? "-" + rank : "")));
        text.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        this.background.addChild(text);
        this.icon = this.largeText_ ?
                FameUtil.numStarsToBigImage(this.numStars_, this.admin_) :
                FameUtil.numStarsToImage(this.numStars_, this.admin_);
        this.background.addChild(this.icon);
        text.textChanged.addOnce(onTextChanged);
        addChild(this.background);
        if (this.prefix_ != null) {
            this.positionWhenTextIsReady();
        }
    }

    private function positionWhenTextIsReady():void {
        if (this.waiter.isEmpty()) {
            this.position();
        }
        else {
            this.waiter.complete.addOnce(this.position);
        }
    }

    private function position():void {
        if (this.prefix_) {
            this.background.x = this.prefix_.width;
            this.prefix_.y = (this.icon.y - 3);
        }
    }


}
}
