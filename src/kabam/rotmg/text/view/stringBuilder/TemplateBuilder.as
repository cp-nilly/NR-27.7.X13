package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.language.model.StringMap;

public class TemplateBuilder implements StringBuilder {

    private var template:String;
    private var tokens:Object;
    private var postfix:String = "";
    private var prefix:String = "";
    private var provider:StringMap;


    public function setTemplate(_arg1:String, _arg2:Object = null):TemplateBuilder {
        this.template = _arg1;
        this.tokens = _arg2;
        return (this);
    }

    public function setPrefix(_arg1:String):TemplateBuilder {
        this.prefix = _arg1;
        return (this);
    }

    public function setPostfix(_arg1:String):TemplateBuilder {
        this.postfix = _arg1;
        return (this);
    }

    public function setStringMap(_arg1:StringMap):void {
        this.provider = _arg1;
    }

    public function getString():String {
        var _local2:String;
        var _local3:String;
        var _local1:String = this.template;
        for (_local2 in this.tokens) {
            _local3 = this.tokens[_local2];
            if ((((_local3.charAt(0) == "{")) && ((_local3.charAt((_local3.length - 1)) == "}")))) {
                _local3 = this.provider.getValue(_local3.substr(1, (_local3.length - 2)));
            }
            _local1 = _local1.replace((("{" + _local2) + "}"), _local3);
        }
        _local1 = _local1.replace(/\\n/g, "\n");
        return (((this.prefix + _local1) + this.postfix));
    }


}
}
