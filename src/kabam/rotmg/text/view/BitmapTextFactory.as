package kabam.rotmg.text.view {
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class BitmapTextFactory {

    private const glowFilter:GlowFilter = new GlowFilter(0, 1, 3, 3, 2, 1);

    public var padding:int = 0;
    private var textfield:TextFieldDisplayConcrete;

    public function BitmapTextFactory(_arg1:FontModel, _arg2:TextAndMapProvider) {
        this.textfield = new TextFieldDisplayConcrete();
        this.textfield.setFont(_arg1.getFont());
        this.textfield.setTextField(_arg2.getTextField());
        this.textfield.setStringMap(_arg2.getStringMap());
    }

    public function make(_arg1:StringBuilder, _arg2:int, _arg3:uint, _arg4:Boolean, _arg5:Matrix, _arg6:Boolean):BitmapData {
        this.configureTextfield(_arg2, _arg3, _arg4, _arg1);
        return (this.makeBitmapData(_arg6, _arg5));
    }

    private function configureTextfield(_arg1:int, _arg2:uint, _arg3:Boolean, _arg4:StringBuilder):void {
        this.textfield.setSize(_arg1).setColor(_arg2).setBold(_arg3).setAutoSize(TextFieldAutoSize.LEFT);
        this.textfield.setStringBuilder(_arg4);
    }

    private function makeBitmapData(_arg1:Boolean, _arg2:Matrix):BitmapData {
        var _local3:int = ((this.textfield.width + this.padding) + _arg2.tx);
        var _local4:int = (this.textfield.height + this.padding);
        var _local5:BitmapData = new BitmapDataSpy(_local3, _local4, true, 0);
        _local5.draw(this.textfield, _arg2);
        ((_arg1) && (_local5.applyFilter(_local5, _local5.rect, PointUtil.ORIGIN, this.glowFilter)));
        return (_local5);
    }


}
}
