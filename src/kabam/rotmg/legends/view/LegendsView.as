package kabam.rotmg.legends.view {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.legends.model.Legend;
import kabam.rotmg.legends.model.Timespan;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class LegendsView extends Sprite {

    public const timespanChanged:Signal = new Signal(Timespan);
    public const showDetail:Signal = new Signal(Legend);
    public const close:Signal = new Signal();
    private const items:Vector.<LegendListItem> = new <LegendListItem>[];
    private const tabs:Object = {};

    private var title:TextFieldDisplayConcrete;
    private var loadingBanner:TextFieldDisplayConcrete;
    private var noLegendsBanner:TextFieldDisplayConcrete;
    private var mainContainer:Sprite;
    private var closeButton:TitleMenuOption;
    private var scrollBar:Scrollbar;
    private var listContainer:Sprite;
    private var selectedTab:LegendsTab;
    private var legends:Vector.<Legend>;
    private var count:int;

    public function LegendsView() {
        this.makeScreenBase();
        this.makeTitleText();
        this.makeLoadingBanner();
        this.makeNoLegendsBanner();
        this.makeMainContainer();
        this.makeScreenGraphic();
        this.makeLines();
        this.makeScrollbar();
        this.makeTimespanTabs();
        this.makeCloseButton();
    }

    private function makeScreenBase():void {
        addChild(new ScreenBase());
    }

    private function makeTitleText():void {
        this.title = new TextFieldDisplayConcrete().setSize(32).setColor(0xB3B3B3);
        this.title.setAutoSize(TextFieldAutoSize.CENTER);
        this.title.setBold(true);
        this.title.setStringBuilder(new LineBuilder().setParams(TextKey.SCREENS_LEGENDS));
        this.title.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.title.x = (400 - (this.title.width / 2));
        this.title.y = 24;
        addChild(this.title);
    }

    private function makeLoadingBanner():void {
        this.loadingBanner = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
        this.loadingBanner.setBold(true);
        this.loadingBanner.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.loadingBanner.setStringBuilder(new LineBuilder().setParams(TextKey.LOADING_TEXT));
        this.loadingBanner.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.loadingBanner.x = (800 / 2);
        this.loadingBanner.y = (600 / 2);
        this.loadingBanner.visible = false;
        addChild(this.loadingBanner);
    }

    private function makeNoLegendsBanner():void {
        this.noLegendsBanner = new TextFieldDisplayConcrete().setSize(22).setColor(0xB3B3B3);
        this.noLegendsBanner.setBold(true);
        this.noLegendsBanner.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.noLegendsBanner.setStringBuilder(new LineBuilder().setParams(TextKey.EMPTY_LEGENDS_LIST));
        this.noLegendsBanner.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.noLegendsBanner.x = (800 / 2);
        this.noLegendsBanner.y = (600 / 2);
        this.noLegendsBanner.visible = false;
        addChild(this.noLegendsBanner);
    }

    private function makeMainContainer():void {
        var _local1:Shape;
        _local1 = new Shape();
        var _local2:Graphics = _local1.graphics;
        _local2.beginFill(0);
        _local2.drawRect(0, 0, LegendListItem.WIDTH, 430);
        _local2.endFill();
        this.mainContainer = new Sprite();
        this.mainContainer.x = 10;
        this.mainContainer.y = 110;
        this.mainContainer.addChild(_local1);
        this.mainContainer.mask = _local1;
        addChild(this.mainContainer);
    }

    private function makeScreenGraphic():void {
        addChild(new ScreenGraphic());
    }

    private function makeLines():void {
        var _local1:Shape = new Shape();
        addChild(_local1);
        var _local2:Graphics = _local1.graphics;
        _local2.lineStyle(2, 0x545454);
        _local2.moveTo(0, 100);
        _local2.lineTo(800, 100);
    }

    private function makeScrollbar():void {
        this.scrollBar = new Scrollbar(16, 400);
        this.scrollBar.x = ((800 - this.scrollBar.width) - 4);
        this.scrollBar.y = 104;
        addChild(this.scrollBar);
    }

    private function makeTimespanTabs():void {
        var _local1:Vector.<Timespan> = Timespan.TIMESPANS;
        var _local2:int = _local1.length;
        var _local3:int;
        while (_local3 < _local2) {
            this.makeTab(_local1[_local3], _local3);
            _local3++;
        }
    }

    private function makeTab(_arg1:Timespan, _arg2:int):LegendsTab {
        var _local3:LegendsTab = new LegendsTab(_arg1);
        this.tabs[_arg1.getId()] = _local3;
        _local3.x = (20 + (_arg2 * 90));
        _local3.y = 70;
        _local3.selected.add(this.onTabSelected);
        addChild(_local3);
        return (_local3);
    }

    private function onTabSelected(_arg1:LegendsTab):void {
        if (this.selectedTab != _arg1) {
            this.updateTabAndSelectTimespan(_arg1);
        }
    }

    private function updateTabAndSelectTimespan(_arg1:LegendsTab):void {
        this.updateTabs(_arg1);
        this.timespanChanged.dispatch(this.selectedTab.getTimespan());
    }

    private function updateTabs(_arg1:LegendsTab):void {
        ((this.selectedTab) && (this.selectedTab.setIsSelected(false)));
        this.selectedTab = _arg1;
        this.selectedTab.setIsSelected(true);
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

    private function onCloseClick(_arg1:MouseEvent):void {
        this.close.dispatch();
    }

    public function clear():void {
        ((this.listContainer) && (this.clearLegendsList()));
        this.listContainer = null;
        this.scrollBar.visible = false;
    }

    private function clearLegendsList():void {
        var _local1:LegendListItem;
        for each (_local1 in this.items) {
            _local1.selected.remove(this.onItemSelected);
        }
        this.items.length = 0;
        this.mainContainer.removeChild(this.listContainer);
        this.listContainer = null;
    }

    public function setLegendsList(_arg1:Timespan, _arg2:Vector.<Legend>):void {
        this.clear();
        this.updateTabs(this.tabs[_arg1.getId()]);
        this.listContainer = new Sprite();
        this.legends = _arg2;
        this.count = _arg2.length;
        this.items.length = this.count;
        this.noLegendsBanner.visible = (this.count == 0);
        this.makeItemsFromLegends();
        this.mainContainer.addChild(this.listContainer);
        this.updateScrollbar();
    }

    private function makeItemsFromLegends():void {
        var _local1:int;
        while (_local1 < this.count) {
            this.items[_local1] = this.makeItemFromLegend(_local1);
            _local1++;
        }
    }

    private function makeItemFromLegend(_arg1:int):LegendListItem {
        var _local2:Legend = this.legends[_arg1];
        _local2.place = (_arg1 + 1);
        var _local3:LegendListItem = new LegendListItem(_local2);
        _local3.y = (_arg1 * LegendListItem.HEIGHT);
        _local3.selected.add(this.onItemSelected);
        this.listContainer.addChild(_local3);
        return (_local3);
    }

    private function updateScrollbar():void {
        if (this.listContainer.height > 400) {
            this.scrollBar.visible = true;
            this.scrollBar.setIndicatorSize(400, this.listContainer.height);
            this.scrollBar.addEventListener(Event.CHANGE, this.onScrollBarChange);
            this.positionScrollbarToDisplayFocussedLegend();
        }
        else {
            this.scrollBar.removeEventListener(Event.CHANGE, this.onScrollBarChange);
            this.scrollBar.visible = false;
        }
    }

    private function positionScrollbarToDisplayFocussedLegend():void {
        var _local2:int;
        var _local3:int;
        var _local1:Legend = this.getLegendFocus();
        if (_local1) {
            _local2 = this.legends.indexOf(_local1);
            _local3 = ((_local2 + 0.5) * LegendListItem.HEIGHT);
            this.scrollBar.setPos(((_local3 - 200) / (this.listContainer.height - 400)));
        }
    }

    private function getLegendFocus():Legend {
        var _local1:Legend;
        var _local2:Legend;
        for each (_local2 in this.legends) {
            if (_local2.isFocus) {
                _local1 = _local2;
                break;
            }
        }
        return (_local1);
    }

    private function onItemSelected(_arg1:Legend):void {
        this.showDetail.dispatch(_arg1);
    }

    private function onScrollBarChange(_arg1:Event):void {
        this.listContainer.y = (-(this.scrollBar.pos()) * (this.listContainer.height - 400));
    }

    public function showLoading():void {
        this.loadingBanner.visible = true;
    }

    public function hideLoading():void {
        this.loadingBanner.visible = false;
    }


}
}
