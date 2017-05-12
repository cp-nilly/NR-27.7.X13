package kabam.rotmg.text.model {
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

public class FontModel {

    public static const MyriadPro:Class = FontModel_MyriadPro;
    public static const MyriadPro_Bold:Class = FontModel_MyriadPro_Bold;

    private var fontInfo:FontInfo;

    public function FontModel() {
        Font.registerFont(MyriadPro);
        Font.registerFont(MyriadPro_Bold);
        var _local1:Font = new MyriadPro();
        this.fontInfo = new FontInfo();
        this.fontInfo.setName(_local1.fontName);
    }

    public function getFont():FontInfo {
        return (this.fontInfo);
    }

    public function apply(_arg1:TextField, _arg2:int, _arg3:uint, _arg4:Boolean, _arg5:Boolean = false):TextFormat {
        var _local6:TextFormat = _arg1.defaultTextFormat;
        _local6.size = _arg2;
        _local6.color = _arg3;
        _local6.font = this.getFont().getName();
        _local6.bold = _arg4;
        if (_arg5) {
            _local6.align = "center";
        }
        _arg1.defaultTextFormat = _local6;
        _arg1.setTextFormat(_local6);
        return (_local6);
    }

    public function getFormat(_arg1:TextField, _arg2:int, _arg3:uint, _arg4:Boolean):TextFormat {
        var _local5:TextFormat = _arg1.defaultTextFormat;
        _local5.size = _arg2;
        _local5.color = _arg3;
        _local5.font = this.getFont().getName();
        _local5.bold = _arg4;
        return (_local5);
    }


}
}
