package kabam.lib.util {
public class DateValidator {

    private static const DAYS_IN_MONTH:Vector.<int> = Vector.<int>([31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]);
    private static const FEBRUARY:int = 2;

    private var thisYear:int;

    public function DateValidator() {
        this.thisYear = new Date().getFullYear();
    }

    public function isValidMonth(_arg1:int):Boolean {
        return ((((_arg1 > 0)) && ((_arg1 <= 12))));
    }

    public function isValidDay(_arg1:int, _arg2:int = -1, _arg3:int = -1):Boolean {
        return ((((_arg1 > 0)) && ((_arg1 <= this.getDaysInMonth(_arg2, _arg3)))));
    }

    public function getDaysInMonth(_arg1:int = -1, _arg2:int = -1):int {
        if (_arg1 == -1) {
            return (31);
        }
        return ((((_arg1 == FEBRUARY)) ? this.getDaysInFebruary(_arg2) : DAYS_IN_MONTH[(_arg1 - 1)]));
    }

    private function getDaysInFebruary(_arg1:int):int {
        if ((((_arg1 == -1)) || (this.isLeapYear(_arg1)))) {
            return (29);
        }
        return (28);
    }

    public function isLeapYear(_arg1:int):Boolean {
        var _local2 = ((_arg1 % 4) == 0);
        var _local3 = ((_arg1 % 100) == 0);
        var _local4 = ((_arg1 % 400) == 0);
        return (((_local2) && (((!(_local3)) || (_local4)))));
    }

    public function isValidDate(_arg1:int, _arg2:int, _arg3:int, _arg4:int):Boolean {
        return (((((this.isValidYear(_arg3, _arg4)) && (this.isValidMonth(_arg1)))) && (this.isValidDay(_arg2, _arg1, _arg3))));
    }

    public function isValidYear(_arg1:int, _arg2:int):Boolean {
        return ((((_arg1 <= this.thisYear)) && ((_arg1 > (this.thisYear - _arg2)))));
    }


}
}
