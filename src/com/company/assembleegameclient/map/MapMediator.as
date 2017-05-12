package com.company.assembleegameclient.map {
import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapMediator extends Mediator {

    [Inject]
    public var view:Map;
    [Inject]
    public var queueStatusText:QueueStatusTextSignal;


    override public function initialize():void {
        this.queueStatusText.add(this.onQueuedStatusText);
    }

    override public function destroy():void {
        this.queueStatusText.remove(this.onQueuedStatusText);
    }

    private function onQueuedStatusText(_arg1:String, _arg2:uint):void {
        ((this.view.player_) && (this.queueText(_arg1, _arg2)));
    }

    private function queueText(_arg1:String, _arg2:uint):void {
        var _local3:QueuedStatusText = new QueuedStatusText(this.view.player_, new LineBuilder().setParams(_arg1), _arg2, 2000, 0);
        this.view.mapOverlay_.addQueuedText(_local3);
    }


}
}
