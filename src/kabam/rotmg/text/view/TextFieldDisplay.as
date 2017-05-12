package kabam.rotmg.text.view {
import flash.text.TextField;

import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.FontInfo;

public interface TextFieldDisplay {

    function setTextField(_arg1:TextField):void;

    function setStringMap(_arg1:StringMap):void;

    function setFont(_arg1:FontInfo):void;

}
}
