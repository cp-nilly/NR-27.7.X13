package kabam.rotmg.errors.control {
import com.company.util.CapabilitiesUtil;

import flash.events.ErrorEvent;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.api.ApplicationSetup;

public class ReportErrorToAppEngineCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var event:ErrorEvent;
    private var error;


    public function execute():void {
        this.event.preventDefault();
        this.error = this.event["error"];
        this.getMessage();
        var _local1:Array = [];
        _local1.push(("Build: " + this.setup.getBuildLabel()));
        _local1.push(("message: " + this.getMessage()));
        _local1.push(("stackTrace: " + this.getStackTrace()));
        _local1.push(CapabilitiesUtil.getHumanReadable());
        this.client.setSendEncrypted(false);
        this.client.sendRequest("/clientError/add", {
            "text": _local1.join("\n"),
            "guid": this.account.getUserId()
        });
    }

    private function getMessage():String {
        if ((this.error is Error)) {
            return (this.error.message);
        }
        if (this.event != null) {
            return (this.event.text);
        }
        if (this.error != null) {
            return (this.error.toString());
        }
        return ("(empty)");
    }

    private function getStackTrace():String {
        return ((((this.error is Error)) ? Error(this.error).getStackTrace() : "(empty)"));
    }


}
}
