package kabam.rotmg.pets.view.components {
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

import org.osflash.signals.Signal;

public class CaretakerQueryDialogCategoryItem extends Sprite {

    private static const WIDTH:int = (CaretakerQueryDialog.WIDTH - 40);
    private static const HEIGHT:int = 40;
    private static const BEVEL:int = 2;
    private static const OUT:uint = 0x5C5C5C;
    private static const OVER:uint = 0x7F7F7F;

    private const helper:GraphicsHelper = new GraphicsHelper();
    private const rect:BevelRect = new BevelRect(WIDTH, HEIGHT, BEVEL);
    private const background:Shape = makeBackground();
    private const textfield:TextFieldDisplayConcrete = makeTextfield();
    public const textChanged:Signal = textfield.textChanged;

    public var info:String;

    public function CaretakerQueryDialogCategoryItem(_arg1:String, _arg2:String) {
        this.info = _arg2;
        this.textfield.setStringBuilder(new LineBuilder().setParams(_arg1));
        this.makeInteractive();
    }

    private function makeBackground():Shape {
        var _local1:Shape = new Shape();
        this.drawBackground(_local1, OUT);
        addChild(_local1);
        return (_local1);
    }

    private function drawBackground(_arg1:Shape, _arg2:uint):void {
        _arg1.graphics.clear();
        _arg1.graphics.beginFill(_arg2);
        this.helper.drawBevelRect(0, 0, this.rect, _arg1.graphics);
        _arg1.graphics.endFill();
    }

    private function makeTextfield():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE).setPosition((WIDTH / 2), (HEIGHT / 2));
        _local1.mouseEnabled = false;
        addChild(_local1);
        return (_local1);
    }

    private function makeInteractive():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        this.drawBackground(this.background, OVER);
    }

    private function onMouseOut(_arg1:MouseEvent):void {
        this.drawBackground(this.background, OUT);
    }


}
}
