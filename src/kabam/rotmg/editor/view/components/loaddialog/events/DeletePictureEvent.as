package kabam.rotmg.editor.view.components.loaddialog.events {
import flash.events.Event;

public class DeletePictureEvent extends Event {

    public static const DELETE_PICTURE_EVENT:String = "DELETE_PICTURE_EVENT";

    public var name_:String;
    public var id_:String;

    public function DeletePictureEvent(_arg_1:String, _arg_2:String) {
        super(DELETE_PICTURE_EVENT, true);
        this.name_ = _arg_1;
        this.id_ = _arg_2;
    }

}
}
