package kabam.rotmg.editor.view.components {
import com.company.color.HSV;

import flash.events.Event;

public class ColorEvent extends Event {

    public static const COLOR_EVENT:String = "COLOR_EVENT";

    public var hsv_:HSV;

    public function ColorEvent(_arg_1:HSV) {
        super(COLOR_EVENT);
        this.hsv_ = _arg_1;
    }

}
}
