package kabam.rotmg.account.kongregate.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.RelayLoginTask;
import kabam.rotmg.account.kongregate.signals.KongregateAlreadyRegisteredSignal;
import kabam.rotmg.account.kongregate.view.KongregateApi;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class KongregateRelayAPILoginTask extends BaseTask implements RelayLoginTask {

    public static const ALREADY_REGISTERED:String = "Kongregate account already registered";

    [Inject]
    public var account:Account;
    [Inject]
    public var api:KongregateApi;
    [Inject]
    public var data:AccountData;
    [Inject]
    public var alreadyRegistered:KongregateAlreadyRegisteredSignal;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/kongregate/internalRegister", this.makeDataPacket());
    }

    private function makeDataPacket():Object {
        var _local1:Object = this.api.getAuthentication();
        _local1.guid = this.account.getUserId();
        return (_local1);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (_arg1) {
            this.onInternalRegisterDone(_arg2);
        }
        else {
            if (_arg2 == ALREADY_REGISTERED) {
                this.alreadyRegistered.dispatch(this.data);
            }
        }
        completeTask(_arg1, _arg2);
    }

    private function onInternalRegisterDone(_arg1:String):void {
        var _local2:XML = new XML(_arg1);
        this.account.updateUser(_local2.GUID, _local2.Secret, "");
        this.account.setPlatformToken(_local2.PlatformToken);
    }


}
}
