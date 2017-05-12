package kabam.rotmg.util.components {
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;

import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

public class DialogBackground extends Sprite {

    private static const BEVEL:int = 4;


    public function draw(_arg1:int, _arg2:int):void {
        var _local3:BevelRect = new BevelRect(_arg1, _arg2, BEVEL);
        var _local4:GraphicsHelper = new GraphicsHelper();
        graphics.lineStyle(1, 0xFFFFFF, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3);
        graphics.beginFill(0x363636);
        _local4.drawBevelRect(0, 0, _local3, graphics);
        graphics.endFill();
    }


}
}
