package kabam.rotmg.arena.model {
import flash.display.BitmapData;

import kabam.rotmg.pets.data.PetVO;

public class ArenaLeaderboardEntry {

    public var playerBitmap:BitmapData;
    public var name:String;
    public var pet:PetVO;
    public var slotTypes:Vector.<int>;
    public var equipment:Vector.<int>;
    public var runtime:Number;
    public var currentWave:int;
    public var guildName:String;
    public var guildRank:int;
    public var rank:int = -1;
    public var isPersonalRecord:Boolean = false;


    public function isEqual(_arg1:ArenaLeaderboardEntry):Boolean {
        return ((((((_arg1.name == this.name)) && ((this.runtime == _arg1.runtime)))) && ((this.currentWave == _arg1.currentWave))));
    }

    public function isBetterThan(_arg1:ArenaLeaderboardEntry):Boolean {
        return ((((this.currentWave > _arg1.currentWave)) || ((((this.currentWave == _arg1.currentWave)) && ((this.runtime < _arg1.runtime))))));
    }


}
}
