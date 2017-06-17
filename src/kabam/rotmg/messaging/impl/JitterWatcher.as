package kabam.rotmg.messaging.impl {
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.utils.getTimer;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class JitterWatcher extends Sprite {

    private static const lineBuilder:LineBuilder = new LineBuilder();

    private var text_:TextFieldDisplayConcrete = null;
    private var lastRecord_:int = -1;
    private var ticks_:Vector.<int>;
    private var sum_:int;

    public function JitterWatcher() {
        this.ticks_ = new Vector.<int>();
        super();
        this.text_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
        this.text_.setAutoSize(TextFieldAutoSize.LEFT);
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.text_);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function record():void {
        var currentTime:int = getTimer();
        if (this.lastRecord_ == -1) {
            this.lastRecord_ = currentTime;
            return;
        }
        var dx:int = currentTime - this.lastRecord_;
        this.ticks_.push(dx);
        this.sum_ = this.sum_ + dx;
        if (this.ticks_.length > 50) {
            var fdx:int = this.ticks_.shift();
            this.sum_ = this.sum_ - fdx;
        }
        this.lastRecord_ = currentTime;
    }

    private function onAddedToStage(_arg1:Event):void {
        stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(_arg1:Event):void {
        this.text_.setStringBuilder(lineBuilder.setParams(TextKey.JITTERWATCHER_DESC, {"jitter": this.jitter()}));
    }

    private function jitter():Number {
        var numSamples:int = this.ticks_.length;
        if (numSamples == 0) {
            return 0;
        }
        var avg:Number = this.sum_ / numSamples;
        var sqrSum:Number = 0;
        for each (var dx:int in this.ticks_) {
            sqrSum = sqrSum + (dx - avg) * (dx - avg);
        }
        return int(Math.sqrt(sqrSum / numSamples) * 10) / 10;
    }


}
}
