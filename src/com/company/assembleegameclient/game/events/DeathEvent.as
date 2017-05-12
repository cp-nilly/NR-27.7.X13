package com.company.assembleegameclient.game.events {
import com.company.assembleegameclient.objects.Player;

import flash.display.BitmapData;
import flash.events.Event;

public class DeathEvent extends Event {

    public static const DEATH:String = "DEATH";

    public var background_:BitmapData;
    public var player_:Player;
    public var accountId_:int;
    public var charId_:int;

    public function DeathEvent(_arg1:BitmapData, _arg2:int, _arg3:int) {
        super(DEATH);
        this.background_ = _arg1;
        this.accountId_ = _arg2;
        this.charId_ = _arg3;
    }

}
}
