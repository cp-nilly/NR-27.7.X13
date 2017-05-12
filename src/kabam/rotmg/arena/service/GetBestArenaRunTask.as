package kabam.rotmg.arena.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.arena.model.BestArenaRunModel;

public class GetBestArenaRunTask extends BaseTask {

    private static const REQUEST:String = "arena/getPersonalBest";

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var bestRunModel:BestArenaRunModel;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(REQUEST, this.makeRequestObject());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.updateBestRun(_arg2)));
        completeTask(_arg1, _arg2);
    }

    private function updateBestRun(_arg1:String):void {
        var _local2:XML = XML(_arg1);
        this.bestRunModel.entry.runtime = _local2.Record.Time;
        this.bestRunModel.entry.currentWave = _local2.Record.WaveNumber;
    }

    private function makeRequestObject():Object {
        return (this.account.getCredentials());
    }


}
}
