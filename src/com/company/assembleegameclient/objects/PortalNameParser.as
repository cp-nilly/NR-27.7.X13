package com.company.assembleegameclient.objects {
import kabam.rotmg.text.view.stringBuilder.PatternBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class PortalNameParser {

    public static const NAME_PARSER:RegExp = /(.+)\s\((.+)\)/;


    public function parse(_arg1:String):String {
        var _local2:Array = _arg1.match(NAME_PARSER);
        if (_local2 == null) {
            return (this.wrapNameWithBracesIfRequired(_arg1));
        }
        return (this.makePatternFromParts(_local2));
    }

    private function wrapNameWithBracesIfRequired(_arg1:String):String {
        if ((((_arg1.charAt(0) == "{")) && ((_arg1.charAt((_arg1.length - 1)) == "}")))) {
            return (_arg1);
        }
        return ((("{" + _arg1) + "}"));
    }

    private function makePatternFromParts(_arg1:Array):String {
        var _local2 = (("{" + _arg1[1]) + "}");
        if (_arg1.length > 1) {
            _local2 = (_local2 + ((" (" + _arg1[2]) + ")"));
        }
        return (_local2);
    }

    public function makeBuilder(_arg1:String):StringBuilder {
        return (new PatternBuilder().setPattern(this.parse(_arg1)));
    }


}
}
