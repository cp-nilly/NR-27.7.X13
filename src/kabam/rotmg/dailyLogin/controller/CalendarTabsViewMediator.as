package kabam.rotmg.dailyLogin.controller {
import flash.events.MouseEvent;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.CalendarTypes;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.dailyLogin.view.CalendarTabButton;
import kabam.rotmg.dailyLogin.view.CalendarTabsView;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CalendarTabsViewMediator extends Mediator {

    [Inject]
    public var view:CalendarTabsView;
    [Inject]
    public var model:DailyLoginModel;
    private var tabs:Vector.<CalendarTabButton>;


    override public function initialize():void {
        var _local2:CalendarTabButton;
        this.tabs = new Vector.<CalendarTabButton>();
        this.view.init(CalendarSettings.getTabsRectangle(this.model.overallMaxDays));
        var _local1 = "";
        if (this.model.hasCalendar(CalendarTypes.NON_CONSECUTIVE)) {
            _local1 = CalendarTypes.NON_CONSECUTIVE;
            this.tabs.push(this.view.addCalendar("Login Calendar", CalendarTypes.NON_CONSECUTIVE, "Unlock rewards the more days you login. Logins do not need to be in consecutive days. You must claim all rewards before the end of the event."));
        }
        if (this.model.hasCalendar(CalendarTypes.CONSECUTIVE)) {
            if (_local1 == "") {
                _local1 = CalendarTypes.CONSECUTIVE;
            }
            this.tabs.push(this.view.addCalendar("Login Streak", CalendarTypes.CONSECUTIVE, "Login on consecutive days to keep your streak alive. The more consecutive days you login, the more rewards you can unlock. If you miss a day, you start over. All rewards must be claimed by the end of the event."));
        }
        for each (_local2 in this.tabs) {
            _local2.addEventListener(MouseEvent.CLICK, this.onTabChange);
        }
        this.view.drawTabs();
        if (_local1 != "") {
            this.model.currentDisplayedCaledar = _local1;
            this.view.selectTab(_local1);
        }
    }

    private function onTabChange(_arg1:MouseEvent):void {
        _arg1.stopImmediatePropagation();
        _arg1.stopPropagation();
        var _local2:CalendarTabButton = (_arg1.currentTarget as CalendarTabButton);
        if (_local2 != null) {
            this.model.currentDisplayedCaledar = _local2.calendarType;
            this.view.selectTab(_local2.calendarType);
        }
    }

    override public function destroy():void {
        var _local1:CalendarTabButton;
        for each (_local1 in this.tabs) {
            _local1.removeEventListener(MouseEvent.CLICK, this.onTabChange);
        }
        this.tabs = new Vector.<CalendarTabButton>();
        super.destroy();
    }


}
}
