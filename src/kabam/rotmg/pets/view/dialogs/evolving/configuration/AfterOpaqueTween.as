package kabam.rotmg.pets.view.dialogs.evolving.configuration {
import com.gskinner.motion.GTween;

import flash.display.DisplayObject;

import kabam.rotmg.pets.view.dialogs.evolving.TweenProxy;

public class AfterOpaqueTween extends TweenProxy {

    public function AfterOpaqueTween(_arg1:DisplayObject) {
        super(_arg1);
    }

    override public function start():void {
        var _local1:GTween = new GTween(target, 1, {"alpha": 1});
        _local1.onComplete = this.pauseComplete;
    }

    private function pauseComplete(_arg1:GTween):void {
        new GTween(target, 1, {"alpha": 0});
    }


}
}
