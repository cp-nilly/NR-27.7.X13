package kabam.rotmg.assets.model {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Animation extends Sprite {

    private const DEFAULT_SPEED:int = 200;
    private const bitmap:Bitmap = makeBitmap();
    private const frames:Vector.<BitmapData> = new <BitmapData>[];
    private const timer:Timer = makeTimer();

    private var started:Boolean;
    private var index:int;
    private var count:uint;
    private var disposed:Boolean;


    private function makeBitmap():Bitmap {
        var _local1:Bitmap = new Bitmap();
        addChild(_local1);
        return (_local1);
    }

    private function makeTimer():Timer {
        var _local1:Timer = new Timer(this.DEFAULT_SPEED);
        _local1.addEventListener(TimerEvent.TIMER, this.iterate);
        return (_local1);
    }

    public function getSpeed():int {
        return (this.timer.delay);
    }

    public function setSpeed(_arg1:int):void {
        this.timer.delay = _arg1;
    }

    public function setFrames(..._args):void {
        var _local2:BitmapData;
        this.frames.length = 0;
        this.index = 0;
        for each (_local2 in _args) {
            this.count = this.frames.push(_local2);
        }
        if (this.started) {
            this.start();
        }
        else {
            this.iterate();
        }
    }

    public function addFrame(_arg1:BitmapData):void {
        this.count = this.frames.push(_arg1);
        ((this.started) && (this.start()));
    }

    public function start():void {
        if (((!(this.started)) && ((this.count > 0)))) {
            this.timer.start();
            this.iterate();
        }
        this.started = true;
    }

    public function stop():void {
        ((this.started) && (this.timer.stop()));
        this.started = false;
    }

    private function iterate(_arg1:TimerEvent = null):void {
        this.index = (++this.index % this.count);
        this.bitmap.bitmapData = this.frames[this.index];
    }

    public function dispose():void {
        var _local1:BitmapData;
        this.disposed = true;
        this.stop();
        this.index = 0;
        this.count = 0;
        this.frames.length = 0;
        for each (_local1 in this.frames) {
            _local1.dispose();
        }
    }

    public function isStarted():Boolean {
        return (this.started);
    }

    public function isDisposed():Boolean {
        return (this.disposed);
    }


}
}
