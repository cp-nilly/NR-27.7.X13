package kabam.rotmg.account.web.view {
import flash.display.Sprite;

public class ProgressBar extends Sprite {

    private static const BEVEL:int = 4;

    private var _w:Number = 100;
    private var _h:Number = 10;
    private var backbar:Sprite;
    private var fillbar:Sprite;

    public function ProgressBar(_arg1:Number, _arg2:Number) {
        this._w = _arg1;
        this._h = _arg2;
        this.backbar = new Sprite();
        this.fillbar = new Sprite();
        addChild(this.backbar);
        addChild(this.fillbar);
        this.update(0);
    }

    public function update(_arg1:Number):void {
        this.drawRectToSprite(this.fillbar, 0xFFFFFF, ((_arg1 * 0.01) * this._w));
        this.drawRectToSprite(this.backbar, 0, this._w);
    }

    private function drawRectToSprite(_arg1:Sprite, _arg2:uint, _arg3:Number):Sprite {
        _arg1.graphics.clear();
        _arg1.graphics.beginFill(_arg2);
        _arg1.graphics.drawRect(0, 0, _arg3, this._h);
        _arg1.graphics.endFill();
        return (_arg1);
    }


}
}
