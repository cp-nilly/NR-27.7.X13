package kabam.rotmg.legends.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.legends.model.Legend;
import kabam.rotmg.legends.model.LegendFactory;
import kabam.rotmg.legends.model.LegendsModel;
import kabam.rotmg.legends.model.Timespan;

public class GetLegendsListTask extends BaseTask {

    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var model:LegendsModel;
    [Inject]
    public var factory:LegendFactory;
    [Inject]
    public var timespan:Timespan;
    public var charId:int;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/fame/list", this.makeRequestObject());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.updateFameListData(_arg2)));
        completeTask(_arg1, _arg2);
    }

    private function updateFameListData(_arg1:String):void {
        var _local2:Vector.<Legend> = this.factory.makeLegends(XML(_arg1));
        this.model.setLegendList(_local2);
    }

    private function makeRequestObject():Object {
        var _local1:Object = {};
        _local1.timespan = this.timespan.getId();
        _local1.accountId = this.player.getAccountId();
        _local1.charId = this.charId;
        return (_local1);
    }


}
}
