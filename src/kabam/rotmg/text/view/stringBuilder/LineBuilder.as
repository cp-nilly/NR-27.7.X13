package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;

public class LineBuilder implements StringBuilder {

    public var key:String;
    public var tokens:Object;
    private var postfix:String = "";
    private var prefix:String = "";
    private var map:StringMap;


    public static function fromJSON(_arg1:String):LineBuilder {
        var _local2:Object;
        try {
            _local2 = JSON.parse(_arg1);
        }
        catch (e:Error) {
            _local2 = { "key":_arg1, "tokens":null };
        }
        return (new (LineBuilder)().setParams(_local2.key, _local2.tokens));
    }

    public static function getLocalizedStringFromKey(_arg1:String, _arg2:Object = null):String {
        var _local3:LineBuilder = new (LineBuilder)();
        _local3.setParams(_arg1, _arg2);
        var _local4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        _local3.setStringMap(_local4);
        return ((((_local3.getString() == "")) ? _arg1 : _local3.getString()));
    }

    public static function getLocalizedStringFromJSON(_arg1:String):String {
        var _local2:LineBuilder;
        var _local3:StringMap;
        if (_arg1.charAt(0) == "{") {
            _local2 = LineBuilder.fromJSON(_arg1);
            _local3 = StaticInjectorContext.getInjector().getInstance(StringMap);
            _local2.setStringMap(_local3);
            return (_local2.getString());
        }
        return (_arg1);
    }

    public static function returnStringReplace(_arg1:String, _arg2:Object = null, _arg3:String = "", _arg4:String = ""):String {
        var _local6:String;
        var _local7:String;
        var _local8:String;
        var _local5:String = stripCurlyBrackets(_arg1);
        for (_local6 in _arg2) {
            _local7 = _arg2[_local6];
            _local8 = (("{" + _local6) + "}");
            while (_local5.indexOf(_local8) != -1) {
                _local5 = _local5.replace(_local8, _local7);
            }
        }
        _local5 = _local5.replace(/\\n/g, "\n");
        return (((_arg3 + _local5) + _arg4));
    }

    public static function getLocalizedString2(_arg1:String, _arg2:Object = null):String {
        var _local3:LineBuilder = new (LineBuilder)();
        _local3.setParams(_arg1, _arg2);
        var _local4:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        _local3.setStringMap(_local4);
        return (_local3.getString());
    }

    private static function stripCurlyBrackets(_arg1:String):String {
        var _local2:Boolean = ((((!((_arg1 == null))) && ((_arg1.charAt(0) == "{")))) && ((_arg1.charAt((_arg1.length - 1)) == "}")));
        return (((_local2) ? _arg1.substr(1, (_arg1.length - 2)) : _arg1));
    }


    public function toJson():String {
        return (JSON.stringify({
            "key": this.key,
            "tokens": this.tokens
        }));
    }

    public function setParams(_arg1:String, _arg2:Object = null):LineBuilder {
        this.key = ((_arg1) || (""));
        this.tokens = _arg2;
        return (this);
    }

    public function setPrefix(_arg1:String):LineBuilder {
        this.prefix = _arg1;
        return (this);
    }

    public function setPostfix(_arg1:String):LineBuilder {
        this.postfix = _arg1;
        return (this);
    }

    public function setStringMap(_arg1:StringMap):void {
        this.map = _arg1;
    }

    public function getString():String {
        var _local3:String;
        var _local4:String;
        var _local5:String;
        var _local1:String = stripCurlyBrackets(this.key);
        var _local2:String = ((this.map.getValue(_local1)) || (""));
        for (_local3 in this.tokens) {
            _local4 = this.tokens[_local3];
            if ((((_local4.charAt(0) == "{")) && ((_local4.charAt((_local4.length - 1)) == "}")))) {
                _local4 = this.map.getValue(_local4.substr(1, (_local4.length - 2)));
            }
            _local5 = (("{" + _local3) + "}");
            while (_local2.indexOf(_local5) != -1) {
                _local2 = _local2.replace(_local5, _local4);
            }
        }
        _local2 = _local2.replace(/\\n/g, "\n");
        return (((this.prefix + _local2) + this.postfix));
    }


}
}
