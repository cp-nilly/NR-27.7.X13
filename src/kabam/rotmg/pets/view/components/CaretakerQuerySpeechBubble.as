package kabam.rotmg.pets.view.components {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import flashx.textLayout.formats.VerticalAlign;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

public class CaretakerQuerySpeechBubble extends Sprite {

    private const WIDTH:int = 174;
    private const HEIGHT:int = 42;
    private const BEVEL:int = 4;
    private const POINT:int = 6;

    public function CaretakerQuerySpeechBubble(_arg1:String) {
        addChild(this.makeBubble());
        addChild(this.makeText(_arg1));
    }

    private function makeBubble():Shape {
        var _local1:Shape = new Shape();
        this.drawBubble(_local1);
        return (_local1);
    }

    private function drawBubble(_arg1:Shape):void {
        var _local2:GraphicsHelper = new GraphicsHelper();
        var _local3:BevelRect = new BevelRect(this.WIDTH, this.HEIGHT, this.BEVEL);
        var _local4:int = (this.HEIGHT / 2);
        _arg1.graphics.beginFill(0xE0E0E0);
        _local2.drawBevelRect(0, 0, _local3, _arg1.graphics);
        _arg1.graphics.endFill();
        _arg1.graphics.beginFill(0xE0E0E0);
        _arg1.graphics.moveTo(0, (_local4 - this.POINT));
        _arg1.graphics.lineTo(-(this.POINT), _local4);
        _arg1.graphics.lineTo(0, (_local4 + this.POINT));
        _arg1.graphics.endFill();
    }

    private function makeText(_arg1:String):TextFieldDisplayConcrete {
        var _local2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(VerticalAlign.MIDDLE).setPosition((this.WIDTH / 2), (this.HEIGHT / 2));
        _local2.setStringBuilder(new LineBuilder().setParams(_arg1));
        return (_local2);
    }


}
}
