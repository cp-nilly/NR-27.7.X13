package kabam.rotmg.game.view.components {
import flash.display.DisplayObjectContainer;

public class QueuedStatusTextList {

    public var target:DisplayObjectContainer;
    private var head:QueuedStatusText;
    private var tail:QueuedStatusText;


    public function shift():void {
        this.target.removeChild(this.head);
        this.head = this.head.next;
        if (this.head) {
            this.target.addChild(this.head);
        }
        else {
            this.tail = null;
        }
    }

    public function append(_arg1:QueuedStatusText):void {
        _arg1.list = this;
        if (this.tail) {
            this.tail.next = _arg1;
            this.tail = _arg1;
        }
        else {
            this.head = (this.tail = _arg1);
            this.target.addChild(_arg1);
        }
    }


}
}
