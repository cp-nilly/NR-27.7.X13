package kabam.rotmg.pets.view {
import com.company.assembleegameclient.util.StageProxy;

import flash.display.Sprite;

import kabam.rotmg.pets.view.dialogs.ClearsPetSlots;

public class PetInteractionView extends Sprite implements ClearsPetSlots {

    public var stageProxy:StageProxy;

    public function PetInteractionView() {
        this.stageProxy = new StageProxy(this);
    }

    protected function positionThis():void {
        this.x = ((this.stageProxy.getStageWidth() - this.width) * 0.5);
        this.y = ((this.stageProxy.getStageHeight() - this.height) * 0.5);
    }


}
}
