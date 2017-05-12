package kabam.rotmg.core.service {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.core.signals.AppInitDataReceivedSignal;

import robotlegs.bender.framework.api.ILogger;

public class RequestAppInitTask extends BaseTask {

    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var appInitConfigData:AppInitDataReceivedSignal;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/app/init", {"game_net": this.account.gameNetwork()});
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        var _local3:XML = XML(_arg2);
        ((_arg1) && (this.appInitConfigData.dispatch(_local3)));
        this.initDynamicSettingsClass(_local3);
        completeTask(_arg1, _arg2);
    }

    private function initDynamicSettingsClass(_arg1:XML):void {
        if (_arg1 != null) {
            DynamicSettings.xml = _arg1;
        }
    }


}
}
