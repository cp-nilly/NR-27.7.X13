package kabam.rotmg.language.model {
import flash.net.SharedObject;
import flash.utils.Dictionary;

public class CookieLanguageModel implements LanguageModel {

    public static const DEFAULT_LOCALE:String = "en";

    private var cookie:SharedObject;
    private var language:String;
    private var availableLanguages:Dictionary;

    public function CookieLanguageModel() {
        this.availableLanguages = this.makeAvailableLanguages();
        super();
        try {
            this.cookie = SharedObject.getLocal("RotMG", "/");
        }
        catch (error:Error) {
        }
    }

    public function getLanguage():String {
        return ((this.language = ((this.language) || (this.readLanguageFromCookie()))));
    }

    private function readLanguageFromCookie():String {
        return (((this.cookie.data.locale) || (DEFAULT_LOCALE)));
    }

    public function setLanguage(_arg1:String):void {
        this.language = _arg1;
        try {
            this.cookie.data.locale = _arg1;
            this.cookie.flush();
        }
        catch (error:Error) {
        }
    }

    public function getLanguageFamily():String {
        return (this.getLanguage().substr(0, 2).toLowerCase());
    }

    public function getLanguageNames():Vector.<String> {
        var _local2:String;
        var _local1:Vector.<String> = new Vector.<String>();
        for (_local2 in this.availableLanguages) {
            _local1.push(_local2);
        }
        return (_local1);
    }

    public function getLanguageCodeForName(_arg1:String):String {
        return (this.availableLanguages[_arg1]);
    }

    public function getNameForLanguageCode(_arg1:String):String {
        var _local2:String;
        var _local3:String;
        for (_local3 in this.availableLanguages) {
            if (this.availableLanguages[_local3] == _arg1) {
                _local2 = _local3;
            }
        }
        return (_local2);
    }

    private function makeAvailableLanguages():Dictionary {
        var _local1:Dictionary = new Dictionary();
        _local1["Languages.English"] = "en";
        _local1["Languages.French"] = "fr";
        _local1["Languages.Spanish"] = "es";
        _local1["Languages.Italian"] = "it";
        _local1["Languages.German"] = "de";
        _local1["Languages.Turkish"] = "tr";
        _local1["Languages.Russian"] = "ru";
        return (_local1);
    }


}
}
