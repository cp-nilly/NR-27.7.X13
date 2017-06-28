package kabam.rotmg.editor.view.components {
import com.company.color.HSV;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;

public class PaletteBox extends Sprite {

    public var size_:int;
    public var hsv_:HSV;
    public var readOnly_:Boolean = false;

    public function PaletteBox(_arg_1:int, _arg_2:HSV, _arg_3:Boolean) {
        this.size_ = _arg_1;
        this.hsv_ = new HSV();
        this.setColor(_arg_2);
        this.readOnly_ = _arg_3;
    }

    public function setColor(_arg_1:HSV):void {
        if (this.readOnly_) {
            return;
        }
        this.hsv_.h_ = _arg_1.h_;
        this.hsv_.s_ = _arg_1.s_;
        this.hsv_.v_ = _arg_1.v_;
        var _local_2:uint = MoreColorUtil.hsvToRgb(this.hsv_.h_, this.hsv_.s_, this.hsv_.v_);
        graphics.beginFill(_local_2);
        graphics.drawRect(0, 0, this.size_, this.size_);
        graphics.endFill();
    }


}
}
