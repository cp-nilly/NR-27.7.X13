package com.company.assembleegameclient.ui.guild {
import flash.events.Event;

public class GuildPlayerListEvent extends Event {

    public static const SET_RANK:String = "SET_RANK";
    public static const REMOVE_MEMBER:String = "REMOVE_MEMBER";

    public var name_:String;
    public var rank_:int;

    public function GuildPlayerListEvent(_arg1:String, _arg2:String, _arg3:int = -1) {
        super(_arg1, true);
        this.name_ = _arg2;
        this.rank_ = _arg3;
    }

}
}
