package com.company.util {
public class DateFormatterReplacement {

    private const months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    public var formatString:String;


    public function format(_arg1:Date):String {
        var _local2:String = this.formatString;
        _local2 = _local2.replace("D", _arg1.date);
        _local2 = _local2.replace("YYYY", _arg1.fullYear);
        return (_local2.replace("MMMM", this.months[_arg1.month]));
    }


}
}
