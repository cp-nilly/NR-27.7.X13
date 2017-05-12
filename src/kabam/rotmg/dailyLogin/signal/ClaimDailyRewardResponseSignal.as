package kabam.rotmg.dailyLogin.signal {
import kabam.rotmg.dailyLogin.message.ClaimDailyRewardResponse;

import org.osflash.signals.Signal;

public class ClaimDailyRewardResponseSignal extends Signal {

    public function ClaimDailyRewardResponseSignal() {
        super(ClaimDailyRewardResponse);
    }

}
}
