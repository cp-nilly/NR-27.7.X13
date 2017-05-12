package kabam.rotmg.language.model {
import kabam.rotmg.text.model.DebugTextInfo;

public class DebugStringMap implements StringMap {

    [Inject]
    public var delegate:StringMap;
    [Inject]
    public var languageModel:LanguageModel;
    public var debugTextInfos:Vector.<DebugTextInfo>;

    public function DebugStringMap() {
        this.debugTextInfos = new Vector.<DebugTextInfo>();
        super();
    }

    public function hasKey(_arg1:String):Boolean {
        return (true);
    }

    public function getValue(_arg1:String):String {
        if (((!((_arg1 == ""))) && (this.isInvalid(_arg1)))) {
            return (_arg1);
        }
        return (this.delegate.getValue(_arg1));
    }

    private function isInvalid(_arg1:String):Boolean {
        return (((this.hasNo(_arg1)) || (this.hasWrongLanguage(_arg1))));
    }

    private function hasNo(_arg1:String):Boolean {
        return (!(this.delegate.hasKey(_arg1)));
    }

    private function pushDebugInfo(_arg1:String):void {
        var _local2:String = this.getLanguageFamily(_arg1);
        var _local3:DebugTextInfo = new DebugTextInfo();
        _local3.key = _arg1;
        _local3.hasKey = this.delegate.hasKey(_arg1);
        _local3.languageFamily = _local2;
        _local3.value = this.delegate.getValue(_arg1);
        this.debugTextInfos.push(_local3);
    }

    private function hasWrongLanguage(_arg1:String):Boolean {
        return (!((this.getLanguageFamily(_arg1) == this.languageModel.getLanguage())));
    }

    public function clear():void {
    }

    public function setValue(_arg1:String, _arg2:String, _arg3:String):void {
        this.delegate.setValue(_arg1, _arg2, _arg3);
    }

    public function getLanguageFamily(_arg1:String):String {
        return (this.delegate.getLanguageFamily(_arg1));
    }


}
}
