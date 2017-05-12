package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.assembleegameclient.util.FameUtil;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;

public class ScoringBox extends Sprite {

    private var rect_:Rectangle;
    private var mask_:Shape;
    private var linesSprite_:Sprite;
    private var scoreTextLines_:Vector.<ScoreTextLine>;
    private var scrollbar_:Scrollbar;
    private var startTime_:int;

    public function ScoringBox(_arg1:Rectangle, _arg2:XML) {
        var _local4:XML;
        this.mask_ = new Shape();
        this.linesSprite_ = new Sprite();
        this.scoreTextLines_ = new Vector.<ScoreTextLine>();
        super();
        this.rect_ = _arg1;
        graphics.lineStyle(1, 0x494949, 2);
        graphics.drawRect((this.rect_.x + 1), (this.rect_.y + 1), (this.rect_.width - 2), (this.rect_.height - 2));
        graphics.lineStyle();
        this.scrollbar_ = new Scrollbar(16, this.rect_.height);
        this.scrollbar_.addEventListener(Event.CHANGE, this.onScroll);
        this.mask_.graphics.beginFill(0xFFFFFF, 1);
        this.mask_.graphics.drawRect(this.rect_.x, this.rect_.y, this.rect_.width, this.rect_.height);
        this.mask_.graphics.endFill();
        addChild(this.mask_);
        mask = this.mask_;
        addChild(this.linesSprite_);
        this.addLine(TextKey.FAMEVIEW_SHOTS, null, 0, _arg2.Shots, false, 5746018);
        if (int(_arg2.Shots) != 0) {
            this.addLine(TextKey.FAMEVIEW_ACCURACY, null, 0, ((100 * Number(_arg2.ShotsThatDamage)) / Number(_arg2.Shots)), true, 5746018, "", "%");
        }
        this.addLine(TextKey.FAMEVIEW_TILES_SEEN, null, 0, _arg2.TilesUncovered, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_MONSTERKILLS, null, 0, _arg2.MonsterKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_GODKILLS, null, 0, _arg2.GodKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_ORYXKILLS, null, 0, _arg2.OryxKills, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_QUESTSCOMPLETED, null, 0, _arg2.QuestsCompleted, false, 5746018);
        this.addLine(TextKey.FAMEVIEW_DUNGEONSCOMPLETED, null, 0, (((((((((((((((((((((((((int(_arg2.PirateCavesCompleted) + int(_arg2.UndeadLairsCompleted)) + int(_arg2.AbyssOfDemonsCompleted)) + int(_arg2.SnakePitsCompleted)) + int(_arg2.SpiderDensCompleted)) + int(_arg2.SpriteWorldsCompleted)) + int(_arg2.TombsCompleted)) + int(_arg2.ForestMazeCompleted)) + int(_arg2.LairOfDraconisCompleted)) + int(_arg2.CandyLandCompleted)) + int(_arg2.HauntedCemeteryCompleted)) + int(_arg2.CaveOfAThousandTreasuresCompleted)) + int(_arg2.MadLabCompleted)) + int(_arg2.DavyJonesCompleted)) + int(_arg2.TombHeroicCompleted)) + int(_arg2.DreamscapeCompleted)) + int(_arg2.IceCaveCompleted)) + int(_arg2.DeadWaterDocksCompleted)) + int(_arg2.CrawlingDepthCompleted)) + int(_arg2.WoodLandCompleted)) + int(_arg2.BattleNexusCompleted)) + int(_arg2.TheShattersCompleted)) + int(_arg2.BelladonnaCompleted)) + int(_arg2.PuppetMasterCompleted)) + int(_arg2.ToxicSewersCompleted)) + int(_arg2.TheHiveCompleted)), false, 5746018);
        this.addLine(TextKey.FAMEVIEW_PARTYMEMBERLEVELUPS, null, 0, _arg2.LevelUpAssists, false, 5746018);
        var _local3:BitmapData = FameUtil.getFameIcon();
        _local3 = BitmapUtil.cropToBitmapData(_local3, 6, 6, (_local3.width - 12), (_local3.height - 12));
        this.addLine(TextKey.FAMEVIEW_BASEFAMEEARNED, null, 0, _arg2.BaseFame, true, 0xFFC800, "", "", new Bitmap(_local3));
        for each (_local4 in _arg2.Bonus) {
            this.addLine(_local4.@id, _local4.@desc, _local4.@level, int(_local4), true, 0xFFC800, "+", "", new Bitmap(_local3));
        }
    }

    public function showScore():void {
        var _local1:ScoreTextLine;
        this.animateScore();
        this.startTime_ = -(int.MAX_VALUE);
        for each (_local1 in this.scoreTextLines_) {
            _local1.skip();
        }
    }

    public function animateScore():void {
        this.startTime_ = getTimer();
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onScroll(_arg1:Event):void {
        var _local2:Number = this.scrollbar_.pos();
        this.linesSprite_.y = ((_local2 * ((this.rect_.height - this.linesSprite_.height) - 15)) + 5);
    }

    private function addLine(_arg1:String, _arg2:String, _arg3:int, _arg4:int, _arg5:Boolean, _arg6:uint, _arg7:String = "", _arg8:String = "", _arg9:DisplayObject = null):void {
        if ((((_arg4 == 0)) && (!(_arg5)))) {
            return;
        }
        this.scoreTextLines_.push(new ScoreTextLine(20, 0xB3B3B3, _arg6, _arg1, _arg2, _arg3, _arg4, _arg7, _arg8, _arg9));
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local3:Number;
        var _local6:ScoreTextLine;
        var _local2:Number = (this.startTime_ + ((2000 * (this.scoreTextLines_.length - 1)) / 2));
        _local3 = getTimer();
        var _local4:int = Math.min(this.scoreTextLines_.length, (((2 * (getTimer() - this.startTime_)) / 2000) + 1));
        var _local5:int;
        while (_local5 < _local4) {
            _local6 = this.scoreTextLines_[_local5];
            _local6.y = (28 * _local5);
            this.linesSprite_.addChild(_local6);
            _local5++;
        }
        this.linesSprite_.y = ((this.rect_.height - this.linesSprite_.height) - 10);
        if (_local3 > (_local2 + 1000)) {
            this.addScrollbar();
            dispatchEvent(new Event(Event.COMPLETE));
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function addScrollbar():void {
        graphics.clear();
        graphics.lineStyle(1, 0x494949, 2);
        graphics.drawRect((this.rect_.x + 1), (this.rect_.y + 1), (this.rect_.width - 26), (this.rect_.height - 2));
        graphics.lineStyle();
        this.scrollbar_.x = (this.rect_.width - 16);
        this.scrollbar_.setIndicatorSize(this.mask_.height, this.linesSprite_.height);
        this.scrollbar_.setPos(1);
        addChild(this.scrollbar_);
    }


}
}
