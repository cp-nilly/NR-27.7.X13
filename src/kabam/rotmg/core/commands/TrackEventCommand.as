package kabam.rotmg.core.commands {
import kabam.rotmg.core.service.GoogleAnalytics;
import kabam.rotmg.core.service.TrackingData;

public class TrackEventCommand {

    [Inject]
    public var analytics:GoogleAnalytics;
    [Inject]
    public var vo:TrackingData;


    public function execute():void {
        this.analytics.trackEvent(this.vo.category, this.vo.action, this.vo.label, this.vo.value);
    }


}
}
