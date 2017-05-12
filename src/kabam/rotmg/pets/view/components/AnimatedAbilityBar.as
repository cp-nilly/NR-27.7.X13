package kabam.rotmg.pets.view.components {
import com.gskinner.motion.GTween;

import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.ColorTransform;

import org.osflash.signals.Signal;

public class AnimatedAbilityBar extends Sprite {

    public const animating:Signal = new Signal(Boolean);
    public const filledUp:Signal = new Signal();
    private const NORMAL_BAR_COLOR:uint = 0xB3B3B3;
    private const FILLING_BAR_COLOR:uint = 1572859;
    private const BACKGROUND_BAR_COLOR:uint = 0x565656;

    private var animatedBar:Shape;
    private var backgroundBar:Shape;
    private var maxPoints:int = 0;
    public var currentPoints:int = -1;
    private var maxWidth:int = 0;
    private var barHeight:int = 0;

    public function AnimatedAbilityBar(_arg1:int, _arg2:int) {
        this.animatedBar = new Shape();
        this.backgroundBar = new Shape();
        super();
        this.maxWidth = _arg1;
        this.barHeight = _arg2;
        this.backgroundBar.graphics.beginFill(this.BACKGROUND_BAR_COLOR, 1);
        this.backgroundBar.graphics.drawRect(0, 0, _arg1, _arg2);
        addChild(this.backgroundBar);
        addChild(this.animatedBar);
    }

    public function reset():void {
        this.currentPoints = 0;
        this.animatedBar.graphics.clear();
        this.animatedBar.graphics.beginFill(this.NORMAL_BAR_COLOR, 1);
        this.animatedBar.graphics.drawRect(0, 0, 1, this.barHeight);
        this.animatedBar.width = 1;
    }

    public function fill():void {
        if (this.currentPoints == this.maxPoints) {
            this.reset();
            this.filledUp.dispatch();
            return;
        }
        var _local1:Number = this.maxWidth;
        this.setBarColor(this.FILLING_BAR_COLOR);
        var _local2:GTween = new GTween(this.animatedBar, 1, {"width": _local1});
        _local2.onComplete = this.filled;
    }

    private function filled(_arg1:GTween):void {
        this.filledUp.dispatch();
    }

    public function setBarColor(_arg1:uint):void {
        var _local2:ColorTransform = this.animatedBar.transform.colorTransform;
        _local2.color = _arg1;
        this.animatedBar.transform.colorTransform = _local2;
    }

    public function setMaxPointValue(_arg1:int):void {
        this.maxPoints = _arg1;
        this.adjustFilledBar();
    }

    public function setCurrentPointValue(_arg1:int):void {
        var _local2:Number;
        if (this.currentPoints == -1) {
            this.currentPoints = _arg1;
            _local2 = this.getBarWidth();
            this.animatedBar.graphics.beginFill(this.NORMAL_BAR_COLOR, 1);
            this.animatedBar.graphics.drawRect(0, 0, _local2, this.barHeight);
        }
        this.currentPoints = _arg1;
        this.adjustFilledBar();
    }

    private function adjustFilledBar():void {
        var _local2:GTween;
        var _local1:int = this.getBarWidth();
        if (((((!((this.currentPoints == -1))) && (!((this.currentPoints == 0))))) && (!((_local1 == Math.round(this.animatedBar.width)))))) {
            this.animating.dispatch(true);
            this.setBarColor(this.FILLING_BAR_COLOR);
            _local2 = new GTween(this.animatedBar, 2, {"width": _local1});
            _local2.onComplete = this.handleTweenComplete;
        }
    }

    private function getBarWidth():int {
        var _local1:int = ((this.currentPoints * this.maxWidth) / this.maxPoints);
        return (((isNaN(_local1)) ? 1 : Math.round(Math.max(1, Math.min(this.maxWidth, _local1)))));
    }

    public function handleTweenComplete(_arg1:GTween):void {
        this.setBarColor(this.NORMAL_BAR_COLOR);
        this.animating.dispatch(false);
    }


}
}
