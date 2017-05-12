package kabam.rotmg.dailyLogin.model {
public class DailyLoginModel {

    public static const DAY_IN_MILLISECONDS:Number = (((24 * 60) * 60) * 1000);//86400000

    public var shouldDisplayCalendarAtStartup:Boolean;
    public var currentDisplayedCaledar:String;
    private var serverTimestamp:Number;
    private var serverMeasureTime:Number;
    private var daysConfig:Object;
    private var userDayConfig:Object;
    private var currentDayConfig:Object;
    private var maxDayConfig:Object;
    private var _initialized:Boolean;
    private var _currentDay:int = -1;
    private var sortAsc:Function;

    public function DailyLoginModel() {
        this.daysConfig = {};
        this.userDayConfig = {};
        this.currentDayConfig = {};
        this.maxDayConfig = {};
        this.sortAsc = function (_arg1:CalendarDayModel, _arg2:CalendarDayModel):Number {
            if (_arg1.dayNumber < _arg2.dayNumber) {
                return (-1);
            }
            if (_arg1.dayNumber > _arg2.dayNumber) {
                return (1);
            }
            return (0);
        };
        super();
        this.clear();
    }

    public function setServerTime(_arg1:Number):void {
        this.serverTimestamp = _arg1;
        this.serverMeasureTime = new Date().getTime();
    }

    public function hasCalendar(_arg1:String):Boolean {
        return ((this.daysConfig[_arg1].length > 0));
    }

    public function getServerTime():Date {
        var _local1:Date = new Date();
        _local1.setTime((this.serverTimestamp + (_local1.getTime() - this.serverMeasureTime)));
        return (_local1);
    }

    public function getTimestampDay():int {
        return (Math.floor((this.getServerTime().getTime() / DailyLoginModel.DAY_IN_MILLISECONDS)));
    }

    private function getDayCount(_arg1:int, _arg2:int):int {
        var _local3:Date = new Date(_arg1, _arg2, 0);
        return (_local3.getDate());
    }

    public function get daysLeftToCalendarEnd():int {
        var _local1:Date = this.getServerTime();
        var _local2:int = _local1.getDate();
        var _local3:int = this.getDayCount(_local1.fullYear, (_local1.month + 1));
        return ((_local3 - _local2));
    }

    public function addDay(_arg1:CalendarDayModel, _arg2:String):void {
        this._initialized = true;
        this.daysConfig[_arg2].push(_arg1);
    }

    public function setUserDay(_arg1:int, _arg2:String):void {
        this.userDayConfig[_arg2] = _arg1;
    }

    public function calculateCalendar(_arg1:String):void {
        var _local6:CalendarDayModel;
        var _local2:Vector.<CalendarDayModel> = this.sortCalendar(this.daysConfig[_arg1]);
        var _local3:int = _local2.length;
        this.daysConfig[_arg1] = _local2;
        this.maxDayConfig[_arg1] = _local2[(_local3 - 1)].dayNumber;
        var _local4:Vector.<CalendarDayModel> = new Vector.<CalendarDayModel>();
        var _local5:int = 1;
        while (_local5 <= this.maxDayConfig[_arg1]) {
            _local6 = this.getDayByNumber(_arg1, _local5);
            if (_local5 == this.userDayConfig[_arg1]) {
                _local6.isCurrent = true;
            }
            _local4.push(_local6);
            _local5++;
        }
        this.daysConfig[_arg1] = _local4;
    }

    private function getDayByNumber(_arg1:String, _arg2:int):CalendarDayModel {
        var _local3:CalendarDayModel;
        for each (_local3 in this.daysConfig[_arg1]) {
            if (_local3.dayNumber == _arg2) {
                return (_local3);
            }
        }
        return (new CalendarDayModel(_arg2, -1, 0, 0, false, _arg1));
    }

    public function getDaysConfig(_arg1:String):Vector.<CalendarDayModel> {
        return (this.daysConfig[_arg1]);
    }

    public function getMaxDays(_arg1:String):int {
        return (this.maxDayConfig[_arg1]);
    }

    public function get overallMaxDays():int {
        var _local2:int;
        var _local1:int;
        for each (_local2 in this.maxDayConfig) {
            if (_local2 > _local1) {
                _local1 = _local2;
            }
        }
        return (_local1);
    }

    public function markAsClaimed(_arg1:int, _arg2:String):void {
        this.daysConfig[_arg2][(_arg1 - 1)].isClaimed = true;
    }

    private function sortCalendar(_arg1:Vector.<CalendarDayModel>):Vector.<CalendarDayModel> {
        return (_arg1.sort(this.sortAsc));
    }

    public function get initialized():Boolean {
        return (this._initialized);
    }

    public function clear():void {
        this.daysConfig[CalendarTypes.CONSECUTIVE] = new Vector.<CalendarDayModel>();
        this.daysConfig[CalendarTypes.NON_CONSECUTIVE] = new Vector.<CalendarDayModel>();
        this.daysConfig[CalendarTypes.UNLOCK] = new Vector.<CalendarDayModel>();
        this.shouldDisplayCalendarAtStartup = false;
    }

    public function getCurrentDay(_arg1:String):int {
        return (this.currentDayConfig[_arg1]);
    }

    public function setCurrentDay(_arg1:String, _arg2:int):void {
        this.currentDayConfig[_arg1] = _arg2;
    }


}
}
