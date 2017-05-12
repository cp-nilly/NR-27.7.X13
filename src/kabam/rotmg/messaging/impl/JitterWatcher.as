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
        var _local3:int;
        var _local1:int = getTimer();
        if (this.lastRecord_ == -1) {
            this.lastRecord_ = _local1;
            return;
        }
        var _local2:int = (_local1 - this.lastRecord_);
        this.ticks_.push(_local2);
        this.sum_ = (this.sum_ + _local2);
        if (this.ticks_.length > 50) {
            _local3 = this.ticks_.shift();
            this.sum_ = (this.sum_ - _local3);
        }
        this.lastRecord_ = _local1;
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
        var _local4:int;
        var _local1:int = this.ticks_.length;
        if (_local1 == 0) {
            return (0);
        }
        var _local2:Number = (this.sum_ / _local1);
        var _local3:Number = 0;
        for each (_local4 in this.ticks_) {
            _local3 = (_local3 + ((_local4 - _local2) * (_local4 - _local2)));
        }
        return (Math.sqrt((_local3 / _local1)));
    }


}
}
