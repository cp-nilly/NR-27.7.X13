package kabam.rotmg.account.web.view {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;

public class FormField extends Sprite {

    protected static const BACKGROUND_COLOR:uint = 0x333333;
    protected static const ERROR_BORDER_COLOR:uint = 16549442;
    protected static const NORMAL_BORDER_COLOR:uint = 0x454545;
    protected static const TEXT_COLOR:uint = 0xB3B3B3;


    public function getHeight():Number {
        return (0);
    }

    protected function drawSimpleTextBackground(_arg1:BaseSimpleText, _arg2:int, _arg3:int, _arg4:Boolean):void {
        var _local5:uint = ((_arg4) ? ERROR_BORDER_COLOR : NORMAL_BORDER_COLOR);
        graphics.lineStyle(2, _local5, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(BACKGROUND_COLOR, 1);
        graphics.drawRect(((_arg1.x - _arg2) - 5), (_arg1.y - _arg3), (_arg1.width + (_arg2 * 2)), (_arg1.height + (_arg3 * 2)));
        graphics.endFill();
        graphics.lineStyle();
    }


}
}
