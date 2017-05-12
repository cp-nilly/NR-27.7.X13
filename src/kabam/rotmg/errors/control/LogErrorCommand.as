package kabam.rotmg.errors.control {
import flash.events.ErrorEvent;

import robotlegs.bender.framework.api.ILogger;

public class LogErrorCommand {

    [Inject]
    public var logger:ILogger;
    [Inject]
    public var event:ErrorEvent;


    public function execute():void {
        this.logger.error(this.event.text);
        if (((this.event["error"]) && ((this.event["error"] is Error)))) {
            this.logErrorObject(this.event["error"]);
        }
    }

    private function logErrorObject(_arg1:Error):void {
        this.logger.error(_arg1.message);
        this.logger.error(_arg1.getStackTrace());
    }


}
}
