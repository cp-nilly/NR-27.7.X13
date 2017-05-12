package com.company.assembleegameclient.mapeditor {
import flash.events.Event;

public class SubmitJMEvent extends Event {

    public static const SUBMIT_JM_EVENT:String = "SUBMIT_JM_EVENT";

    public var mapJSON_:String;
    public var mapInfo_:Object;

    public function SubmitJMEvent(_arg1:String, _arg2:Object) {
        super(SUBMIT_JM_EVENT);
        this.mapJSON_ = _arg1;
        this.mapInfo_ = _arg2;
    }

}
}
