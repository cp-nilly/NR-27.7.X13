package kabam.rotmg.promotions.view.components {
import flash.display.Sprite;

public class TransparentButton extends Sprite {

    public function TransparentButton(_arg1:int, _arg2:int, _arg3:int, _arg4:int) {
        graphics.beginFill(0, 0);
        graphics.drawRect(0, 0, _arg3, _arg4);
        graphics.endFill();
        this.x = _arg1;
        this.y = _arg2;
        buttonMode = true;
    }

}
}
