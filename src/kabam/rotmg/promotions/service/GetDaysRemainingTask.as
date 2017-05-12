package kabam.rotmg.promotions.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.promotions.model.BeginnersPackageModel;

public class GetDaysRemainingTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:BeginnersPackageModel;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/getBeginnerPackageTimeLeft", this.account.getCredentials());
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        this.onDaysRemainingResponse(_arg2);
    }

    private function onDaysRemainingResponse(_arg1:String):void {
        var _local2:int = new XML(_arg1)[0];
        this.model.setBeginnersOfferSecondsLeft(_local2);
        completeTask((_local2 > 0));
    }


}
}
