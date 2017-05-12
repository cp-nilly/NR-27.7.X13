package com.company.assembleegameclient.util {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.IEventDispatcher;

public class StageProxy implements IEventDispatcher {

    private static var stage3D:Stage3DProxy = null;

    protected var reference:DisplayObject;

    public function StageProxy(_arg1:DisplayObject) {
        this.reference = _arg1;
    }

    public function getStage():DisplayObjectContainer {
        return (this.reference.stage);
    }

    public function getStageWidth():Number {
        if (this.reference.stage != null) {
            return (this.reference.stage.stageWidth);
        }
        return (800);
    }

    public function getStageHeight():Number {
        if (this.reference.stage != null) {
            return (this.reference.stage.stageHeight);
        }
        return (600);
    }

    public function getFocus():InteractiveObject {
        return (this.reference.stage.focus);
    }

    public function setFocus(_arg1:InteractiveObject):void {
        this.reference.stage.focus = _arg1;
    }

    public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false, _arg4:int = 0, _arg5:Boolean = false):void {
        this.reference.stage.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
    }

    public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false):void {
        this.reference.stage.removeEventListener(_arg1, _arg2, _arg3);
    }

    public function dispatchEvent(_arg1:Event):Boolean {
        return (this.reference.stage.dispatchEvent(_arg1));
    }

    public function hasEventListener(_arg1:String):Boolean {
        return (this.reference.stage.hasEventListener(_arg1));
    }

    public function willTrigger(_arg1:String):Boolean {
        return (this.reference.stage.willTrigger(_arg1));
    }

    public function getQuality():String {
        return (this.reference.stage.quality);
    }

    public function setQuality(_arg1:String):void {
        this.reference.stage.quality = _arg1;
    }

    public function getStage3Ds(_arg1:int):Stage3DProxy {
        if (stage3D == null) {
            stage3D = new Stage3DProxy(this.reference.stage.stage3Ds[_arg1]);
        }
        return (stage3D);
    }


}
}
