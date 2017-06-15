package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.ui.Scrollbar;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.ButtonFactory;
import kabam.rotmg.ui.view.components.MenuOptionsBar;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class ServersScreen extends Sprite {

    private var selectServerText_:TextFieldDisplayConcrete;
    private var lines_:Shape;
    private var content_:Sprite;
    private var serverBoxes_:ServerBoxes;
    private var scrollBar_:Scrollbar;
    private var servers:Vector.<Server>;
    public var gotoTitle:Signal;

    public function ServersScreen() {
        addChild(new ScreenBase());
        this.gotoTitle = new Signal();
        addChild(new ScreenBase());
        addChild(new AccountScreen());
    }

    private function onScrollBarChange(_arg1:Event):void {
        this.serverBoxes_.y = (8 - (this.scrollBar_.pos() * (this.serverBoxes_.height - 400)));
    }

    public function initialize(_arg1:Vector.<Server>):void {
        this.servers = _arg1;
        this.makeSelectServerText();
        this.makeLines();
        this.makeContainer();
        this.makeServerBoxes();
        (((this.serverBoxes_.height > 400)) && (this.makeScrollbar()));
        this.makeMenuBar();
    }

    private function makeMenuBar():void {
        var _local1:MenuOptionsBar = new MenuOptionsBar();
        var _local2:TitleMenuOption = ButtonFactory.getDoneButton();
        _local1.addButton(_local2, MenuOptionsBar.CENTER);
        _local2.clicked.add(this.onDone);
        addChild(_local1);
    }

    private function makeScrollbar():void {
        this.scrollBar_ = new Scrollbar(16, 400);
        this.scrollBar_.x = ((800 - this.scrollBar_.width) - 4);
        this.scrollBar_.y = 104;
        this.scrollBar_.setIndicatorSize(400, this.serverBoxes_.height);
        this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
        addChild(this.scrollBar_);
    }

    private function makeServerBoxes():void {
        this.serverBoxes_ = new ServerBoxes(this.servers);
        this.serverBoxes_.y = 8;
        this.serverBoxes_.addEventListener(Event.COMPLETE, this.onDone);
        this.content_.addChild(this.serverBoxes_);
    }

    private function makeContainer():void {
        this.content_ = new Sprite();
        this.content_.x = 4;
        this.content_.y = 100;
        var _local1:Shape = new Shape();
        _local1.graphics.beginFill(0xFFFFFF);
        _local1.graphics.drawRect(0, 0, 776, 430);
        _local1.graphics.endFill();
        this.content_.addChild(_local1);
        this.content_.mask = _local1;
        addChild(this.content_);
    }

    private function makeLines():void {
        this.lines_ = new Shape();
        var _local1:Graphics = this.lines_.graphics;
        _local1.clear();
        _local1.lineStyle(2, 0x545454);
        _local1.moveTo(0, 100);
        _local1.lineTo(stage.stageWidth, 100);
        _local1.lineStyle();
        addChild(this.lines_);
    }

    private function makeSelectServerText():void {
        this.selectServerText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3).setBold(true);
        this.selectServerText_.setStringBuilder(new LineBuilder().setParams(TextKey.SERVERS_SELECT));
        this.selectServerText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.selectServerText_.x = 18;
        this.selectServerText_.y = 72;
        addChild(this.selectServerText_);
    }

    private function onDone():void {
        this.gotoTitle.dispatch();
    }


}
}
