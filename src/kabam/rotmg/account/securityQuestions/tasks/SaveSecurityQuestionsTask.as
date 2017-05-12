package kabam.rotmg.account.securityQuestions.tasks {
import com.company.util.MoreObjectUtil;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsData;
import kabam.rotmg.appengine.api.AppEngineClient;

public class SaveSecurityQuestionsTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var data:SecurityQuestionsData;
    [Inject]
    public var client:AppEngineClient;


    override protected function startTask():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/account/saveSecurityQuestions", this.makeDataPacket());
    }

    private function makeDataPacket():Object {
        var _local1:Object = {};
        _local1.answers = this.data.answers.join("|");
        MoreObjectUtil.addToObject(_local1, this.account.getCredentials());
        return (_local1);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        _arg1 = ((_arg1) || ((_arg2 == "<Success/>")));
        completeTask(_arg1, _arg2);
    }


}
}
