package kabam.rotmg.dailyLogin.view {
import flash.display.Sprite;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;

public class CalendarView extends Sprite {


    public function init(_arg1:Vector.<CalendarDayModel>, _arg2:int, _arg3:int):void {
        var _local7:CalendarDayModel;
        var _local8:int;
        var _local9:CalendarDayBox;
        var _local4:int;
        var _local5:int;
        var _local6:int;
        for each (_local7 in _arg1) {
            _local9 = new CalendarDayBox(_local7, _arg2, ((_local4 + 1) == _arg3));
            addChild(_local9);
            _local9.x = (_local5 * CalendarSettings.BOX_WIDTH);
            if (_local5 > 0) {
                _local9.x = (_local9.x + (_local5 * CalendarSettings.BOX_MARGIN));
            }
            _local9.y = (_local6 * CalendarSettings.BOX_HEIGHT);
            if (_local6 > 0) {
                _local9.y = (_local9.y + (_local6 * CalendarSettings.BOX_MARGIN));
            }
            _local5++;
            if ((++_local4 % CalendarSettings.NUMBER_OF_COLUMNS) == 0) {
                _local5 = 0;
                _local6++;
            }
        }
        _local8 = ((CalendarSettings.BOX_WIDTH * CalendarSettings.NUMBER_OF_COLUMNS) + ((CalendarSettings.NUMBER_OF_COLUMNS - 1) * CalendarSettings.BOX_MARGIN));
        this.x = ((this.parent.width - _local8) / 2);
        this.y = (CalendarSettings.DAILY_LOGIN_TABS_PADDING + CalendarSettings.TABS_HEIGHT);
    }


}
}
