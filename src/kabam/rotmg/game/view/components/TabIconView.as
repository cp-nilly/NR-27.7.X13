package kabam.rotmg.game.view.components {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class TabIconView extends TabView {

    private var background:Sprite;
    private var icon:Bitmap;

    public function TabIconView(_arg1:int, _arg2:Sprite, _arg3:Bitmap) {
        super(_arg1);
        this.initBackground(_arg2);
        if (_arg3) {
            this.initIcon(_arg3);
        }
    }

    private function initBackground(_arg1:Sprite):void {
        this.background = _arg1;
        addChild(_arg1);
    }

    private function initIcon(_arg1:Bitmap):void {
        this.icon = _arg1;
        _arg1.x = (_arg1.x - 5);
        _arg1.y = (_arg1.y - 11);
        addChild(_arg1);
    }

    override public function setSelected(_arg1:Boolean):void {
        var _local2:ColorTransform = this.background.transform.colorTransform;
        _local2.color = ((_arg1) ? TabConstants.BACKGROUND_COLOR : TabConstants.TAB_COLOR);
        this.background.transform.colorTransform = _local2;
    }


}
}
