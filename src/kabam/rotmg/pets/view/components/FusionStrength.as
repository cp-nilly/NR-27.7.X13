package kabam.rotmg.pets.view.components {
import flash.display.Sprite;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class FusionStrength extends Sprite {

    public static const MAXED_COLOR:uint = 8768801;
    public static const BAD_COLOR:uint = 0xFF0000;
    public static const DEFAULT_COLOR:int = 0xB3B3B3;
    public static const LOW:String = "FusionStrength.Low";
    public static const BAD:String = "FusionStrength.Bad";
    public static const GOOD:String = "FusionStrength.Good";
    public static const GREAT:String = "FusionStrength.Great";
    public static const FANTASTIC:String = "FusionStrength.Fantastic";
    public static const MAXED:String = "FusionStrength.Maxed";
    public static const NONE:String = "FusionStrength.None";
    private static const PADDING:Number = 16;

    public var fusionText:TextFieldDisplayConcrete;

    public function FusionStrength():void {
        addChild(FusionStrengthFactory.makeRoundedBox());
        this.addText();
        this.addFusionText();
    }

    private static function getKeyFor(_arg1:Number):String {
        if (isMaxed(_arg1)) {
            return (MAXED);
        }
        if (_arg1 > 0.8) {
            return (FANTASTIC);
        }
        if (_arg1 > 0.6) {
            return (GREAT);
        }
        if (_arg1 > 0.4) {
            return (GOOD);
        }
        if (_arg1 > 0.2) {
            return (LOW);
        }
        return (BAD);
    }

    private static function isMaxed(_arg1:Number):Boolean {
        return ((Math.abs((_arg1 - 1)) < 0.001));
    }

    private static function isBad(_arg1:Number):Boolean {
        return ((_arg1 < 0.2));
    }


    public function reset():void {
        this.fusionText.setStringBuilder(new LineBuilder().setParams(NONE));
        this.fusionText.setColor(DEFAULT_COLOR);
    }

    private function addText():void {
        var _local1:TextFieldDisplayConcrete = FusionStrengthFactory.makeText();
        _local1.x = PADDING;
        _local1.y = this.getMiddle();
        addChild(_local1);
    }

    private function addFusionText():void {
        this.fusionText = FusionStrengthFactory.makeFusionText();
        this.fusionText.x = (width - PADDING);
        this.fusionText.y = this.getMiddle();
        this.fusionText.setStringBuilder(new LineBuilder().setParams(NONE));
        this.fusionText.setColor(DEFAULT_COLOR);
        addChild(this.fusionText);
    }

    private function getMiddle():Number {
        return ((height / 2));
    }

    public function setFusionStrength(_arg1:Number):void {
        var _local2:String = getKeyFor(_arg1);
        this.fusionText.setStringBuilder(new LineBuilder().setParams(_local2));
        this.colorText(_arg1);
    }

    private function colorText(_arg1:Number):void {
        if (isMaxed(_arg1)) {
            this.fusionText.setColor(MAXED_COLOR);
        }
        else {
            if (isBad(_arg1)) {
                this.fusionText.setColor(BAD_COLOR);
            }
            else {
                this.fusionText.setColor(DEFAULT_COLOR);
            }
        }
    }


}
}
