package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;

import flash.display.Sprite;

import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.game.view.components.QueuedStatusTextList;

public class MapOverlay extends Sprite {

    private const speechBalloons:Object = {};
    private const queuedText:Object = {};

    public function MapOverlay() {
        mouseEnabled = true;
        mouseChildren = true;
    }

    public function addSpeechBalloon(_arg1:SpeechBalloon):void {
        var _local2:int = _arg1.go_.objectId_;
        var _local3:SpeechBalloon = this.speechBalloons[_local2];
        if (((_local3) && (contains(_local3)))) {
            removeChild(_local3);
        }
        this.speechBalloons[_local2] = _arg1;
        addChild(_arg1);
    }

    public function addStatusText(_arg1:CharacterStatusText):void {
        addChild(_arg1);
    }

    public function addQueuedText(_arg1:QueuedStatusText):void {
        var _local2:int = _arg1.go_.objectId_;
        var _local3:QueuedStatusTextList = (this.queuedText[_local2] = ((this.queuedText[_local2]) || (this.makeQueuedStatusTextList())));
        _local3.append(_arg1);
    }

    private function makeQueuedStatusTextList():QueuedStatusTextList {
        var _local1:QueuedStatusTextList = new QueuedStatusTextList();
        _local1.target = this;
        return (_local1);
    }

    public function draw(_arg1:Camera, _arg2:int):void {
        var _local4:IMapOverlayElement;
        var _local3:int;
        while (_local3 < numChildren) {
            _local4 = (getChildAt(_local3) as IMapOverlayElement);
            if (((!(_local4)) || (_local4.draw(_arg1, _arg2)))) {
                _local3++;
            }
            else {
                _local4.dispose();
            }
        }
    }


}
}
