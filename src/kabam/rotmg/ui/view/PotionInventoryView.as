package kabam.rotmg.ui.view {
import flash.display.Sprite;

import kabam.rotmg.ui.view.components.PotionSlotView;

public class PotionInventoryView extends Sprite {

    private static const LEFT_BUTTON_CUTS:Array = [1, 0, 0, 1];
    private static const RIGHT_BUTTON_CUTS:Array = [0, 1, 1, 0];
    private static const BUTTON_SPACE:int = 4;

    private const cuts:Array = [LEFT_BUTTON_CUTS, RIGHT_BUTTON_CUTS];

    public function PotionInventoryView() {
        var _local2:PotionSlotView;
        super();
        var _local1:int;
        while (_local1 < 2) {
            _local2 = new PotionSlotView(this.cuts[_local1], _local1);
            _local2.x = (_local1 * (PotionSlotView.BUTTON_WIDTH + BUTTON_SPACE));
            addChild(_local2);
            _local1++;
        }
    }

}
}
