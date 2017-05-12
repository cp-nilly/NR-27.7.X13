package kabam.rotmg.account.securityQuestions.signals {
import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsData;

import org.osflash.signals.Signal;

public class SaveSecurityQuestionsSignal extends Signal {

    public function SaveSecurityQuestionsSignal() {
        super(SecurityQuestionsData);
    }

}
}
