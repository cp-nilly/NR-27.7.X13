package kabam.rotmg.arena.view {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.arena.component.LeaderboardWeeklyResetTimer;
import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.arena.model.ArenaLeaderboardFilter;
import kabam.rotmg.arena.model.ArenaLeaderboardModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class ArenaLeaderboard extends Sprite {

    public const requestData:Signal = new Signal(ArenaLeaderboardFilter);
    public const close:Signal = new Signal();

    private var list:ArenaLeaderboardList;
    private var title:StaticTextDisplay;
    private var leftSword:Bitmap;
    private var rightSword:Bitmap;
    private var tabs:Vector.<ArenaLeaderboardTab>;
    private var selected:ArenaLeaderboardTab;
    private var closeButton:TitleMenuOption;
    private var weeklyCountdownClock:LeaderboardWeeklyResetTimer;

    public function ArenaLeaderboard() {
        this.list = this.makeList();
        this.title = this.makeTitle();
        this.leftSword = this.makeSword(false);
        this.rightSword = this.makeSword(true);
        this.tabs = this.makeTabs();
        this.weeklyCountdownClock = this.makeResetTimer();
        super();
        addChild(this.list);
        addChild(new ScreenGraphic());
        addChild(this.leftSword);
        addChild(this.rightSword);
        addChild(this.title);
        this.makeCloseButton();
        this.makeLines();
        addChild(this.weeklyCountdownClock);
    }

    public function init():void {
        var _local1:ArenaLeaderboardTab = this.tabs[0];
        this.selected = _local1;
        _local1.setSelected(true);
        _local1.selected.dispatch(_local1);
    }

    public function destroy():void {
        var _local1:ArenaLeaderboardTab;
        for each (_local1 in this.tabs) {
            _local1.selected.remove(this.onSelected);
            _local1.destroy();
        }
    }

    public function reloadList():void {
        this.setList(this.selected.getFilter().getEntries());
    }

    private function onCloseClick(_arg1:MouseEvent):void {
        this.close.dispatch();
    }

    private function onSelected(_arg1:ArenaLeaderboardTab):void {
        this.selected.setSelected(false);
        this.selected = _arg1;
        this.selected.setSelected(true);
        this.weeklyCountdownClock.visible = (_arg1.getFilter().getKey() == "weekly");
        if (_arg1.getFilter().hasEntries()) {
            this.list.setItems(_arg1.getFilter().getEntries(), true);
        }
        else {
            this.requestData.dispatch(_arg1.getFilter());
        }
    }

    public function setList(_arg1:Vector.<ArenaLeaderboardEntry>):void {
        this.list.setItems(_arg1, true);
    }

    private function makeTabs():Vector.<ArenaLeaderboardTab> {
        var _local3:ArenaLeaderboardFilter;
        var _local4:ArenaLeaderboardTab;
        var _local1:SignalWaiter = new SignalWaiter();
        var _local2:Vector.<ArenaLeaderboardTab> = new Vector.<ArenaLeaderboardTab>();
        for each (_local3 in ArenaLeaderboardModel.FILTERS) {
            _local4 = new ArenaLeaderboardTab(_local3);
            _local4.y = 70;
            _local4.selected.add(this.onSelected);
            _local2.push(_local4);
            _local1.push(_local4.readyToAlign);
            addChild(_local4);
        }
        _local1.complete.addOnce(this.alignTabs);
        return (_local2);
    }

    private function makeSword(_arg1:Boolean):Bitmap {
        var _local2:BitmapData = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiInterface2", 8), 64, true, 0, true);
        if (_arg1) {
            _local2 = BitmapUtil.mirror(_local2);
        }
        return (new Bitmap(_local2));
    }

    private function makeTitle():StaticTextDisplay {
        var _local1:StaticTextDisplay;
        _local1 = new StaticTextDisplay();
        _local1.setBold(true).setColor(0xB3B3B3).setSize(32);
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        _local1.setStringBuilder(new LineBuilder().setParams(TextKey.ARENA_LEADERBOARD_TITLE));
        _local1.setAutoSize(TextFieldAutoSize.CENTER);
        _local1.y = 25;
        _local1.textChanged.addOnce(this.onAlignTitle);
        return (_local1);
    }

    private function makeCloseButton():void {
        this.closeButton = new TitleMenuOption(TextKey.DONE_TEXT, 36, false);
        this.closeButton.setAutoSize(TextFieldAutoSize.CENTER);
        this.closeButton.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.closeButton.x = 400;
        this.closeButton.y = 553;
        addChild(this.closeButton);
        this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
    }

    private function makeLines():void {
        var _local1:Shape = new Shape();
        addChild(_local1);
        var _local2:Graphics = _local1.graphics;
        _local2.lineStyle(2, 0x545454);
        _local2.moveTo(0, 100);
        _local2.lineTo(800, 100);
    }

    private function makeList():ArenaLeaderboardList {
        var _local1:ArenaLeaderboardList = new ArenaLeaderboardList();
        _local1.x = 15;
        _local1.y = 115;
        return (_local1);
    }

    private function alignTabs():void {
        var _local2:ArenaLeaderboardTab;
        var _local1:int = 20;
        for each (_local2 in this.tabs) {
            _local2.x = _local1;
            _local1 = (_local1 + (_local2.width + 20));
        }
    }

    private function makeResetTimer():LeaderboardWeeklyResetTimer {
        var _local1:LeaderboardWeeklyResetTimer;
        _local1 = new LeaderboardWeeklyResetTimer();
        _local1.y = 72;
        _local1.x = 440;
        return (_local1);
    }

    private function onAlignTitle():void {
        this.title.x = (stage.stageWidth / 2);
        this.leftSword.x = ((((stage.stageWidth / 2) - (this.title.width / 2)) - this.leftSword.width) + 10);
        this.leftSword.y = 15;
        this.rightSword.x = (((stage.stageWidth / 2) + (this.title.width / 2)) - 10);
        this.rightSword.y = 15;
    }


}
}
