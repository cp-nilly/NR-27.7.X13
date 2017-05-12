package kabam.rotmg.packages.view {
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class BusyIndicator extends Sprite {

    private const pinwheel:Sprite = makePinWheel();
    private const innerCircleMask:Sprite = makeInner();
    private const quarterCircleMask:Sprite = makeQuarter();
    private const timer:Timer = new Timer(25);
    private const radius:int = 22;
    private const color:uint = 0xFFFFFF;

    public function BusyIndicator() {
        x = (y = this.radius);
        this.addChildren();
        addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
    }

    private function makePinWheel():Sprite {
        var _local1:Sprite;
        _local1 = new Sprite();
        _local1.blendMode = BlendMode.LAYER;
        _local1.graphics.beginFill(this.color);
        _local1.graphics.drawCircle(0, 0, this.radius);
        _local1.graphics.endFill();
        return (_local1);
    }

    private function makeInner():Sprite {
        var _local1:Sprite = new Sprite();
        _local1.blendMode = BlendMode.ERASE;
        _local1.graphics.beginFill((0xFFFFFF * 0.6));
        _local1.graphics.drawCircle(0, 0, (this.radius / 2));
        _local1.graphics.endFill();
        return (_local1);
    }

    private function makeQuarter():Sprite {
        var _local1:Sprite = new Sprite();
        _local1.graphics.beginFill(0xFFFFFF);
        _local1.graphics.drawRect(0, 0, this.radius, this.radius);
        _local1.graphics.endFill();
        return (_local1);
    }

    private function addChildren():void {
        this.pinwheel.addChild(this.innerCircleMask);
        this.pinwheel.addChild(this.quarterCircleMask);
        this.pinwheel.mask = this.quarterCircleMask;
        addChild(this.pinwheel);
    }

    private function onAdded(_arg1:Event):void {
        this.timer.addEventListener(TimerEvent.TIMER, this.updatePinwheel);
        this.timer.start();
    }

    private function onRemoved(_arg1:Event):void {
        this.timer.stop();
        this.timer.removeEventListener(TimerEvent.TIMER, this.updatePinwheel);
    }

    private function updatePinwheel(_arg1:TimerEvent):void {
        this.quarterCircleMask.rotation = (this.quarterCircleMask.rotation + 20);
    }


}
}
