package com.company.assembleegameclient.game.events {
import flash.events.Event;

import kabam.rotmg.messaging.impl.incoming.NameResult;

public class NameResultEvent extends Event {

    public static const NAMERESULTEVENT:String = "NAMERESULTEVENT";

    public var m_:NameResult;

    public function NameResultEvent(_arg1:NameResult) {
        super(NAMERESULTEVENT);
        this.m_ = _arg1;
    }

}
}
