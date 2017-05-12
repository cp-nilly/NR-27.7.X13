package kabam.rotmg.core.commands {
import flash.display.DisplayObjectContainer;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.service.GoogleAnalytics;

public class SetupAnalyticsCommand {

    [Inject]
    public var contextView:DisplayObjectContainer;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var analytics:GoogleAnalytics;


    public function execute():void {
        this.analytics.init(this.contextView.stage, this.setup.getAnalyticsCode());
    }


}
}
