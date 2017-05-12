package kabam.display.LoaderInfo {
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.EventDispatcher;

public class LoaderInfoProxyConcrete extends EventDispatcher implements LoaderInfoProxy {

    private var _loaderInfo:LoaderInfo;


    override public function toString():String {
        return (this._loaderInfo.toString());
    }

    override public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false, _arg4:int = 0, _arg5:Boolean = false):void {
        this._loaderInfo.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
    }

    override public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean = false):void {
        this._loaderInfo.removeEventListener(_arg1, _arg2, _arg3);
    }

    override public function dispatchEvent(_arg1:Event):Boolean {
        return (this._loaderInfo.dispatchEvent(_arg1));
    }

    override public function hasEventListener(_arg1:String):Boolean {
        return (this._loaderInfo.hasEventListener(_arg1));
    }

    override public function willTrigger(_arg1:String):Boolean {
        return (this._loaderInfo.willTrigger(_arg1));
    }

    public function set loaderInfo(_arg1:LoaderInfo):void {
        this._loaderInfo = _arg1;
    }


}
}
