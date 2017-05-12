package com.company.assembleegameclient.mapeditor {
import flash.events.Event;

public class MapTestEvent extends Event {

    public static const MAP_TEST:String = "MAP_TEST_EVENT";

    public var mapJSON_:String;

    public function MapTestEvent(_arg1:String) {
        super(MAP_TEST);
        this.mapJSON_ = _arg1;
    }

}
}
