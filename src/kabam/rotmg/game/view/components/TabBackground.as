package kabam.rotmg.game.view.components {
import flash.display.Sprite;

public class TabBackground extends Sprite {

    public function TabBackground(_arg1:Number = 28, _arg2:Number = 35) {
        graphics.beginFill(TabConstants.TAB_COLOR);
        graphics.drawRoundRect(0, 0, _arg1, _arg2, TabConstants.TAB_CORNER_RADIUS, TabConstants.TAB_CORNER_RADIUS);
        graphics.endFill();
    }

}
}
