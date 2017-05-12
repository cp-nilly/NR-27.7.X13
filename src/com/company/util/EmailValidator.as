package com.company.util {
public class EmailValidator {

    public static const EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;


    public static function isValidEmail(_arg1:String):Boolean {
        return (Boolean(_arg1.match(EMAIL_REGEX)));
    }


}
}
