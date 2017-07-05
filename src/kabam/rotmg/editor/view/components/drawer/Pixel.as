package kabam.rotmg.editor.view.components.drawer {
import com.company.color.HSV;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;

public class Pixel extends Sprite {

    public var size_:int;
    public var hsv_:HSV = null;
    private var allowTrans_:Boolean;

    public function Pixel(_arg_1:int, _arg_2:Boolean) {
        this.size_ = _arg_1;
        this.allowTrans_ = _arg_2;
        this.redraw();
    }

    public function setHSV(_arg_1:HSV):void {
        this.hsv_ = (((_arg_1) != null) ? this.hsv_ = _arg_1.clone() : null);
        this.redraw();
    }

    public function getColor():uint {
        return ((((this.hsv_ == null)) ? 0 : MoreColorUtil.hsvToRgb(this.hsv_.h_, this.hsv_.s_, this.hsv_.v_)));
    }

    public function redraw():void {
        graphics.clear();
        if (this.hsv_ == null) {
            graphics.beginFill(0, ((this.allowTrans_) ? 0 : 1));
        }
        else {
            graphics.beginFill(MoreColorUtil.hsvToRgb(this.hsv_.h_, this.hsv_.s_, this.hsv_.v_));
        }
        graphics.drawRect(0, 0, this.size_, this.size_);
        graphics.endFill();
    }


}
}
