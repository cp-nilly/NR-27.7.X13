package kabam.rotmg.pets.view.components {
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;

import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

public class PopupWindowBackground extends Sprite {

    public static const HORIZONTAL_DIVISION:String = "HORIZONTAL_DIVISION";
    public static const VERTICAL_DIVISION:String = "VERTICAL_DIVISION";
    private static const BEVEL:int = 4;
    public static const TYPE_DEFAULT_GREY:int = 0;
    public static const TYPE_TRANSPARENT_WITH_HEADER:int = 1;
    public static const TYPE_TRANSPARENT_WITHOUT_HEADER:int = 2;
    public static const TYPE_DEFAULT_BLACK:int = 3;


    public function draw(_arg1:int, _arg2:int, _arg3:int = 0):void {
        var _local4:BevelRect = new BevelRect(_arg1, _arg2, BEVEL);
        var _local5:GraphicsHelper = new GraphicsHelper();
        graphics.lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3);
        if (_arg3 == TYPE_TRANSPARENT_WITH_HEADER) {
            graphics.lineStyle(1, 0x363636, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3);
            graphics.beginFill(0x363636, 1);
            _local5.drawBevelRect(1, 1, new BevelRect((_arg1 - 2), 29, BEVEL), graphics);
            graphics.endFill();
            graphics.beginFill(0x363636, 1);
            graphics.drawRect(1, 15, (_arg1 - 2), 15);
            graphics.endFill();
            graphics.lineStyle(2, 0xFFFFFF, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3);
            graphics.beginFill(0x363636, 0);
            _local5.drawBevelRect(0, 0, _local4, graphics);
            graphics.endFill();
        }
        else {
            if (_arg3 == TYPE_TRANSPARENT_WITHOUT_HEADER) {
                graphics.lineStyle(2, 0xFFFFFF, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3);
                graphics.beginFill(0x363636, 0);
                _local5.drawBevelRect(0, 0, _local4, graphics);
                graphics.endFill();
            }
            else {
                if (_arg3 == TYPE_DEFAULT_GREY) {
                    graphics.beginFill(0x363636);
                    _local5.drawBevelRect(0, 0, _local4, graphics);
                    graphics.endFill();
                }
                else {
                    if (_arg3 == TYPE_DEFAULT_BLACK) {
                        graphics.beginFill(0);
                        _local5.drawBevelRect(0, 0, _local4, graphics);
                        graphics.endFill();
                    }
                }
            }
        }
    }

    public function divide(_arg1:String, _arg2:int):void {
        if (_arg1 == HORIZONTAL_DIVISION) {
            this.divideHorizontally(_arg2);
        }
        else {
            if (_arg1 == VERTICAL_DIVISION) {
                this.divideVertically(_arg2);
            }
        }
    }

    private function divideHorizontally(_arg1:int):void {
        graphics.lineStyle();
        graphics.endFill();
        graphics.moveTo(1, _arg1);
        graphics.beginFill(0x666666, 1);
        graphics.drawRect(1, _arg1, (width - 2), 2);
    }

    private function divideVertically(_arg1:int):void {
        graphics.lineStyle();
        graphics.moveTo(_arg1, 1);
        graphics.lineStyle(2, 0x666666);
        graphics.lineTo(_arg1, (height - 1));
    }


}
}
