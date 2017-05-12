package com.company.util {
public class MoreDateUtil {


    public static function getDayStringInPT():String {
        var _local1:Date = new Date();
        var _local2:Number = _local1.getTime();
        _local2 = (_local2 + (((_local1.timezoneOffset - 420) * 60) * 1000));
        _local1.setTime(_local2);
        var _local3:DateFormatterReplacement = new DateFormatterReplacement();
        _local3.formatString = "MMMM D, YYYY";
        return (_local3.format(_local1));
    }


}
}
