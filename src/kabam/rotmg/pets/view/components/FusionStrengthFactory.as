package kabam.rotmg.pets.view.components {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class FusionStrengthFactory {

    private static const FONT_SIZE:int = 14;


    public static function makeRoundedBox():DisplayObjectContainer {
        var _local1:Sprite = new Sprite();
        _local1.graphics.beginFill(0x535353);
        _local1.graphics.drawRoundRect(0, 0, 222, 40, 10, 10);
        _local1.graphics.endFill();
        return (_local1);
    }

    public static function makeText():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local1.setStringBuilder(new LineBuilder().setParams("FusionStrength.text")).setAutoSize(TextFieldAutoSize.LEFT).setColor(FusionStrength.DEFAULT_COLOR);
        configureText(_local1);
        return (_local1);
    }

    public static function makeFusionText():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setAutoSize(TextFieldAutoSize.RIGHT);
        configureText(_local1);
        return (_local1);
    }

    private static function configureText(_arg1:TextFieldDisplayConcrete):void {
        _arg1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE).setSize(FONT_SIZE).setBold(true);
    }


}
}
