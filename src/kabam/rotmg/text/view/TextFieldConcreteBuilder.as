package kabam.rotmg.text.view {
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class TextFieldConcreteBuilder {

    private var _containerWidth:int = -1;
    private var _containerMargin:int = -1;


    public function getLocalizedTextObject(_arg1:String, _arg2:int = -1, _arg3:int = -1, _arg4:int = 16, _arg5:int = 0xFFFFFF, _arg6:int = -1, _arg7:int = -1):TextFieldDisplayConcrete {
        var _local8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local8.setStringBuilder(new LineBuilder().setParams(_arg1));
        return (this.defaultFormatTFDC(_local8, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7));
    }

    public function getLiteralTextObject(_arg1:String, _arg2:int = -1, _arg3:int = -1, _arg4:int = 16, _arg5:int = 0xFFFFFF, _arg6:int = -1, _arg7:int = -1):TextFieldDisplayConcrete {
        var _local8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local8.setStringBuilder(new StaticStringBuilder(_arg1));
        return (this.defaultFormatTFDC(_local8, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7));
    }

    public function getBlankFormattedTextObject(_arg1:String, _arg2:int = -1, _arg3:int = -1, _arg4:int = 16, _arg5:int = 0xFFFFFF, _arg6:int = -1, _arg7:int = -1):TextFieldDisplayConcrete {
        var _local8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        return (this.defaultFormatTFDC(_local8, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7));
    }

    public function formatExistingTextObject(_arg1:TextFieldDisplayConcrete, _arg2:int = -1, _arg3:int = -1, _arg4:int = 16, _arg5:int = 0xFFFFFF, _arg6:int = -1, _arg7:int = -1):TextFieldDisplayConcrete {
        return (this.defaultFormatTFDC(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7));
    }

    private function defaultFormatTFDC(_arg1:TextFieldDisplayConcrete, _arg2:int = -1, _arg3:int = -1, _arg4:int = 16, _arg5:int = 0xFFFFFF, _arg6:int = -1, _arg7:int = -1):TextFieldDisplayConcrete {
        _arg1.setSize(_arg4).setColor(_arg5);
        if (((!((_arg6 == -1))) && (!((_arg7 == -1))))) {
            _arg1.setTextWidth((_arg6 - (_arg7 * 2)));
        }
        else {
            if (((!((this.containerWidth == -1))) && (!((this.containerMargin == -1))))) {
                _arg1.setTextWidth((this.containerWidth - (this.containerMargin * 2)));
            }
        }
        _arg1.setBold(true);
        _arg1.setWordWrap(true);
        _arg1.setMultiLine(true);
        _arg1.setAutoSize(TextFieldAutoSize.CENTER);
        _arg1.setHorizontalAlign(TextFormatAlign.CENTER);
        _arg1.filters = [new DropShadowFilter(0, 0, 0)];
        if (_arg2 != -1) {
            _arg1.x = _arg2;
        }
        if (_arg3 != -1) {
            _arg1.y = _arg3;
        }
        return (_arg1);
    }

    public function get containerWidth():int {
        return (this._containerWidth);
    }

    public function set containerWidth(_arg1:int):void {
        this._containerWidth = _arg1;
    }

    public function get containerMargin():int {
        return (this._containerMargin);
    }

    public function set containerMargin(_arg1:int):void {
        this._containerMargin = _arg1;
    }


}
}
