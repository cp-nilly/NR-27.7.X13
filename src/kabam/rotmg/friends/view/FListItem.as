package kabam.rotmg.friends.view {
import flash.display.Sprite;

import kabam.rotmg.friends.model.FriendVO;

import org.osflash.signals.Signal;

public class FListItem extends Sprite {

    public var actionSignal:Signal;

    public function FListItem() {
        this.actionSignal = new Signal(String, String);
        super();
    }

    protected function init(_arg1:Number, _arg2:Number):void {
    }

    public function update(_arg1:FriendVO, _arg2:String):void {
    }

    public function destroy():void {
    }


}
}
