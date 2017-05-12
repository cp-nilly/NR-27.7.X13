package kabam.rotmg.tooltips.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class TooltipsView extends Sprite {

    private var toolTip:DisplayObject;


    public function show(_arg1:DisplayObject):void {
        this.hide();
        this.toolTip = _arg1;
        if (_arg1) {
            addChild(_arg1);
        }
    }

    public function hide():void {
        if (((this.toolTip) && (this.toolTip.parent))) {
            this.toolTip.parent.removeChild(this.toolTip);
        }
        this.toolTip = null;
    }


}
}
