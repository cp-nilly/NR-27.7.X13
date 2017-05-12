package kabam.rotmg.account.web.view {
import kabam.rotmg.account.ui.components.DateField;

public class DateFieldValidator {


    public static function getPlayerAge(_arg1:DateField):uint {
        var _local2:Date = new Date(getBirthDate(_arg1));
        var _local3:Date = new Date();
        var _local4:uint = (Number(_local3.fullYear) - Number(_local2.fullYear));
        if ((((_local2.month > _local3.month)) || ((((_local2.month == _local3.month)) && ((_local2.date > _local3.date)))))) {
            _local4--;
        }
        return (_local4);
    }

    public static function getBirthDate(_arg1:DateField):Number {
        var _local2:String = ((((_arg1.months.text + "/") + _arg1.days.text) + "/") + _arg1.years.text);
        return (Date.parse(_local2));
    }


}
}
