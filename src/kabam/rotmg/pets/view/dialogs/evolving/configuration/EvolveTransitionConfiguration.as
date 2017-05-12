package kabam.rotmg.pets.view.dialogs.evolving.configuration {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class EvolveTransitionConfiguration {


    public static function makeBackground():DisplayObject {
        var _local1:Sprite = new Sprite();
        _local1.graphics.beginFill(0xFFFFFF);
        _local1.graphics.drawRect(0, 0, 262, 183);
        _local1.graphics.endFill();
        return (_local1);
    }


}
}
