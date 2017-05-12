package kabam.rotmg.pets.view.dialogs.evolving.configuration {
import com.gskinner.motion.GTween;

import flash.display.DisplayObject;

import kabam.rotmg.pets.view.dialogs.evolving.TweenProxy;

public class ToOpaqueTween extends TweenProxy {

    public function ToOpaqueTween(_arg1:DisplayObject) {
        super(_arg1);
    }

    override public function start():void {
        var _local1:GTween = new GTween(target, 1, {"alpha": 0});
        _local1.onComplete = this.pauseComplete;
    }

    private function pauseComplete(_arg1:GTween):void {
        var _local2:GTween = new GTween(target, (1.4 / 2), {"alpha": 1});
        _local2.onComplete = this.tweenComplete;
    }

    private function tweenComplete(_arg1:GTween):void {
        onComplete();
    }


}
}
