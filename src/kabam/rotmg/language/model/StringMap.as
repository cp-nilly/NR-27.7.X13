package kabam.rotmg.language.model {
public interface StringMap {

    function clear():void;

    function setValue(_arg1:String, _arg2:String, _arg3:String):void;

    function hasKey(_arg1:String):Boolean;

    function getValue(_arg1:String):String;

    function getLanguageFamily(_arg1:String):String;

}
}
