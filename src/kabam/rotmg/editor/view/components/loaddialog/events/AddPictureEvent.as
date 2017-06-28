package kabam.rotmg.editor.view.components.loaddialog.events {
import flash.display.BitmapData;
import flash.events.Event;

public class AddPictureEvent extends Event {

    public static const ADD_PICTURE_EVENT:String = "ADD_PICTURE_EVENT";

    public var bitmapData_:BitmapData;

    public function AddPictureEvent(_arg_1:BitmapData) {
        super(ADD_PICTURE_EVENT, true);
        this.bitmapData_ = _arg_1;
    }

}
}
