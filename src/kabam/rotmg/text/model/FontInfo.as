package kabam.rotmg.text.model {
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class FontInfo {

    private static const renderingFontSize:Number = 200;
    private static const GUTTER:Number = 2;

    protected var name:String;
    private var textColor:uint = 0;
    private var xHeightRatio:Number;
    private var verticalSpaceRatio:Number;


    public function setName(_arg1:String):void {
        this.name = _arg1;
        this.computeRatiosByRendering();
    }

    public function getName():String {
        return (this.name);
    }

    public function getXHeight(_arg1:Number):Number {
        return ((this.xHeightRatio * _arg1));
    }

    public function getVerticalSpace(_arg1:Number):Number {
        return ((this.verticalSpaceRatio * _arg1));
    }

    private function computeRatiosByRendering():void {
        var _local1:TextField = this.makeTextField();
        var _local2:BitmapData = new BitmapDataSpy(_local1.width, _local1.height);
        _local2.draw(_local1);
        var _local3:uint = 0xFFFFFF;
        var _local4:Rectangle = _local2.getColorBoundsRect(_local3, this.textColor, true);
        this.xHeightRatio = this.deNormalize(_local4.height);
        this.verticalSpaceRatio = this.deNormalize(((_local1.height - _local4.bottom) - GUTTER));
    }

    private function makeTextField():TextField {
        var _local1:TextField = new TextField();
        _local1.autoSize = TextFieldAutoSize.LEFT;
        _local1.text = "x";
        _local1.textColor = this.textColor;
        _local1.setTextFormat(new TextFormat(this.name, renderingFontSize));
        return (_local1);
    }

    private function deNormalize(_arg1:Number):Number {
        return ((_arg1 / renderingFontSize));
    }


}
}
