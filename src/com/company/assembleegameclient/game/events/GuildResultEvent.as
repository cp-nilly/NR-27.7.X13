package com.company.assembleegameclient.game.events {
import flash.events.Event;

public class GuildResultEvent extends Event {

    public static const EVENT:String = "GUILDRESULTEVENT";

    public var success_:Boolean;
    public var errorKey:String;
    public var errorTokens:Object;

    public function GuildResultEvent(_arg1:Boolean, _arg2:String, _arg3:Object) {
        super(EVENT);
        this.success_ = _arg1;
        this.errorKey = _arg2;
        this.errorTokens = _arg3;
    }

}
}
