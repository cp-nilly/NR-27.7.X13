package kabam.rotmg.editor.view.components.drawer {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class FrameSelector extends Sprite {

    public static const STAND:String = "Stand";
    public static const WALK1:String = "Walk 1";
    public static const WALK2:String = "Walk 2";
    public static const ATTACK1:String = "Attack 1";
    public static const ATTACK2:String = "Attack 2";
    public static const FRAMES:Vector.<String> = new <String>[STAND, WALK1, WALK2, ATTACK1, ATTACK2];

    public var buttons_:Vector.<FrameButton>;
    public var selected_:FrameButton = null;

    public function FrameSelector() {
        var _local_2:String;
        var _local_3:FrameButton;
        this.buttons_ = new Vector.<FrameButton>();
        super();
        var _local_1:int;
        for each (_local_2 in FRAMES) {
            _local_3 = new FrameButton(_local_2);
            _local_3.addEventListener(MouseEvent.CLICK, this.onClick);
            _local_3.x = _local_1;
            _local_1 = (_local_1 + (_local_3.width + 5));
            addChild(_local_3);
            this.buttons_.push(_local_3);
        }
        this.setSelected(this.buttons_[0]);
    }

    public function getSelected():String {
        return (this.selected_.label_);
    }

    private function setSelected(_arg_1:FrameButton):void {
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg_1;
        this.selected_.setSelected(true);
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function onClick(_arg_1:MouseEvent):void {
        var _local_2:FrameButton = (_arg_1.target as FrameButton);
        this.setSelected(_local_2);
    }


}
}
