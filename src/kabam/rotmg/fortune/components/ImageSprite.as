package kabam.rotmg.fortune.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

public class ImageSprite extends Sprite {

    public var displayOb_:DisplayObject;

    public function ImageSprite(_arg1:DisplayObject, _arg2:Number, _arg3:Number) {
        this.displayOb_ = _arg1;
        addChild(_arg1);
        this.width = _arg2;
        this.height = _arg3;
    }

    public function setXPos(_arg1:Number):void {
        this.x = (_arg1 - (this.width / 2));
    }

    public function setYPos(_arg1:Number):void {
        this.y = (_arg1 - (this.height / 2));
    }

    public function getCenterX():Number {
        return ((this.x + (this.width / 2)));
    }

    public function getCenterY():Number {
        return ((this.y + (this.height / 2)));
    }


}
}
