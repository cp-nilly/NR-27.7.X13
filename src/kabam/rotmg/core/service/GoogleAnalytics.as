package kabam.rotmg.core.service {
import com.company.googleanalytics.GA;
import com.google.analytics.GATracker;

import flash.display.Stage;

public class GoogleAnalytics {

    private var tracker:GATracker;


    public function init(_arg1:Stage, _arg2:String):void {
        this.tracker = new GATracker(_arg1, _arg2);
        GA.setTracker(this.tracker);
    }

    public function trackEvent(_arg1:String, _arg2:String, _arg3:String, _arg4:Number):Boolean {
        return (this.tracker.trackEvent(_arg1, _arg2, _arg3, _arg4));
    }

    public function trackPageView(_arg1:String):void {
        this.tracker.trackPageview(_arg1);
    }


}
}
