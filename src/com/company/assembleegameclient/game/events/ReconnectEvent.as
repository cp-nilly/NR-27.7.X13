package com.company.assembleegameclient.game.events {
import flash.events.Event;
import flash.utils.ByteArray;

import kabam.rotmg.servers.api.Server;

public class ReconnectEvent extends Event {

    public static const RECONNECT:String = "RECONNECT_EVENT";

    public var server_:Server;
    public var gameId_:int;
    public var createCharacter_:Boolean;
    public var charId_:int;
    public var keyTime_:int;
    public var key_:ByteArray;
    public var isFromArena_:Boolean;

    public function ReconnectEvent(_arg1:Server, _arg2:int, _arg3:Boolean, _arg4:int, _arg5:int, _arg6:ByteArray, _arg7:Boolean) {
        super(RECONNECT);
        this.server_ = _arg1;
        this.gameId_ = _arg2;
        this.createCharacter_ = _arg3;
        this.charId_ = _arg4;
        this.keyTime_ = _arg5;
        this.key_ = _arg6;
        this.isFromArena_ = _arg7;
    }

    override public function clone():Event {
        return (new ReconnectEvent(this.server_, this.gameId_, this.createCharacter_, this.charId_, this.keyTime_, this.key_, this.isFromArena_));
    }

    override public function toString():String {
        return (formatToString(RECONNECT, "server_", "gameId_", "charId_", "keyTime_", "key_", "isFromArena_"));
    }


}
}
