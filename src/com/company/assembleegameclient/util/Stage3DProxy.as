package com.company.assembleegameclient.util {
import flash.display.Stage3D;
import flash.events.Event;
import flash.events.IEventDispatcher;

import kabam.rotmg.stage3D.proxies.Context3DProxy;

public class Stage3DProxy implements IEventDispatcher {

    private static var context3D:Context3DProxy;

    private var stage3D:Stage3D;

    public function Stage3DProxy(_arg1:Stage3D) {
        this.stage3D = _arg1;
    }

    public function requestContext3D():void {
        this.stage3D.requestContext3D();
    }

    public function getContext3D():Context3DProxy {
        if (context3D == null) {
            context3D = new Context3DProxy(this.stage3D.context3D);
        }
        return (context3D);
    }

    public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false, _arg4:int = 0, _arg5:Boolean = false):void {
        this.stage3D.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
    }

    public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false):void {
        this.stage3D.removeEventListener(_arg1, _arg2, _arg3);
    }

    public function dispatchEvent(_arg1:Event):Boolean {
        return (this.stage3D.dispatchEvent(_arg1));
    }

    public function hasEventListener(_arg1:String):Boolean {
        return (this.stage3D.hasEventListener(_arg1));
    }

    public function willTrigger(_arg1:String):Boolean {
        return (this.stage3D.willTrigger(_arg1));
    }


}
}
