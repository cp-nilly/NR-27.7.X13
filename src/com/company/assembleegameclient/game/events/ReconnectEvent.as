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

    public function ReconnectEvent(
            svr:Server, gameId:int, createCharacter:Boolean,
            charId:int, keyTime:int, key:ByteArray, fromArena:Boolean) {
        super(RECONNECT);
        this.server_ = svr;
        this.gameId_ = gameId;
        this.createCharacter_ = createCharacter;
        this.charId_ = charId;
        this.keyTime_ = keyTime;
        this.key_ = key;
        this.isFromArena_ = fromArena;
    }

    override public function clone():Event {
        return (new ReconnectEvent(this.server_, this.gameId_, this.createCharacter_, this.charId_, this.keyTime_, this.key_, this.isFromArena_));
    }

    override public function toString():String {
        return (formatToString(RECONNECT, "server_", "gameId_", "charId_", "keyTime_", "key_", "isFromArena_"));
    }


}
}
