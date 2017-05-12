package kabam.rotmg.dailyLogin.tasks {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreObjectUtil;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;
import kabam.rotmg.dailyLogin.model.CalendarTypes;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;

import robotlegs.bender.framework.api.ILogger;

public class FetchPlayerCalendarTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var setLoadingMessage:SetLoadingMessageSignal;
    [Inject]
    public var dailyLoginModel:DailyLoginModel;
    [Inject]
    public var buildData:BuildData;
    private var requestData:Object;


    override protected function startTask():void {
        this.logger.info("FetchPlayerCalendarTask start");
        this.requestData = this.makeRequestData();
        this.sendRequest();
    }

    private function sendRequest():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/dailyLogin/fetchCalendar", this.requestData);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onCalendarUpdate(_arg2);
        }
        else {
            this.onTextError(_arg2);
        }
    }

    private function onCalendarUpdate(data:String):void {
        var xmlData:XML;
        try {
            xmlData = new XML(data);
        }
        catch (e:Error) {
            completeTask(true);
            return;
        }
        this.dailyLoginModel.clear();
        var serverTimestamp:Number = (parseFloat(xmlData.attribute("serverTime")) * 1000);
        this.dailyLoginModel.setServerTime(serverTimestamp);
        if (((!(Parameters.data_.calendarShowOnDay)) || ((Parameters.data_.calendarShowOnDay < this.dailyLoginModel.getTimestampDay())))) {
            this.dailyLoginModel.shouldDisplayCalendarAtStartup = true;
        }
        if (this.buildData.getEnvironment() == BuildEnvironment.LOCALHOST) {
        }
        if (((xmlData.hasOwnProperty("NonConsecutive")) && ((xmlData.NonConsecutive..Login.length() > 0)))) {
            this.parseCalendar(xmlData.NonConsecutive, CalendarTypes.NON_CONSECUTIVE, xmlData.attribute("nonconCurDay"));
        }
        if (((xmlData.hasOwnProperty("Consecutive")) && ((xmlData.Consecutive..Login.length() > 0)))) {
            this.parseCalendar(xmlData.Consecutive, CalendarTypes.CONSECUTIVE, xmlData.attribute("conCurDay"));
        }
        completeTask(true);
    }

    private function parseCalendar(_arg1:XMLList, _arg2:String, _arg3:String):void {
        var _local4:XML;
        var _local5:CalendarDayModel;
        for each (_local4 in _arg1..Login) {
            _local5 = this.getDayFromXML(_local4, _arg2);
            if (_local4.hasOwnProperty("key")) {
                _local5.claimKey = _local4.key;
            }
            this.dailyLoginModel.addDay(_local5, _arg2);
        }
        if (_arg3) {
            this.dailyLoginModel.setCurrentDay(_arg2, int(_arg3));
        }
        this.dailyLoginModel.setUserDay(_arg1.attribute("days"), _arg2);
        this.dailyLoginModel.calculateCalendar(_arg2);
    }

    private function getDayFromXML(_arg1:XML, _arg2:String):CalendarDayModel {
        return (new CalendarDayModel(_arg1.Days, _arg1.ItemId, _arg1.Gold, _arg1.ItemId.attribute("quantity"), _arg1.hasOwnProperty("Claimed"), _arg2));
    }

    private function onTextError(_arg1:String):void {
        completeTask(true);
    }

    public function makeRequestData():Object {
        var _local1:Object = {};
        _local1.game_net_user_id = this.account.gameNetworkUserId();
        _local1.game_net = this.account.gameNetwork();
        _local1.play_platform = this.account.playPlatform();
        _local1.do_login = Parameters.sendLogin_;
        MoreObjectUtil.addToObject(_local1, this.account.getCredentials());
        return (_local1);
    }


}
}
