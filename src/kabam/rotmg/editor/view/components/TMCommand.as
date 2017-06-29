package kabam.rotmg.editor.view.components {
import com.company.assembleegameclient.editor.Command;
import com.company.color.HSV;

import kabam.rotmg.editor.view.components.drawer.Pixel;

public class TMCommand extends Command {

    public var pixel_:Pixel;
    public var prevHSV_:HSV;
    public var newHSV_:HSV;

    public function TMCommand(_arg_1:Pixel, _arg_2:HSV, _arg_3:HSV) {
        this.pixel_ = _arg_1;
        this.prevHSV_ = (((_arg_2) != null) ? _arg_2.clone() : null);
        this.newHSV_ = (((_arg_3) != null) ? _arg_3.clone() : null);
    }

    override public function execute():void {
        this.pixel_.setHSV(this.newHSV_);
    }

    override public function unexecute():void {
        this.pixel_.setHSV(this.prevHSV_);
    }


}
}
