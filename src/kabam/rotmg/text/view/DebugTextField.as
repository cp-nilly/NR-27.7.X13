package kabam.rotmg.text.view {
import flash.text.TextField;

import kabam.rotmg.language.model.DebugStringMap;
import kabam.rotmg.text.model.DebugTextInfo;

public class DebugTextField extends TextField {

    public static const WRONG_LANGUAGE_COLOR:uint = 977663;
    public static const INVALID_KEY_COLOR:uint = 15874138;

    public var debugStringMap:DebugStringMap;


    override public function set text(_arg1:String):void {
        super.text = this.getText(_arg1);
    }

    override public function set htmlText(_arg1:String):void {
        super.htmlText = this.getText(_arg1);
    }

    public function getText(_arg1:String):String {
        var _local2:DebugTextInfo;
        if (this.debugStringMap.debugTextInfos.length) {
            _local2 = this.debugStringMap.debugTextInfos[0];
            if (_local2.hasKey) {
                this.setBackground(WRONG_LANGUAGE_COLOR);
            }
            else {
                this.setBackground(INVALID_KEY_COLOR);
            }
            return (_local2.key);
        }
        return (_arg1);
    }

    private function setBackground(_arg1:uint):void {
        background = true;
        backgroundColor = _arg1;
    }


}
}
