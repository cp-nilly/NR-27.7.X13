package kabam.rotmg.account.core.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class PurchaseConfirmationDialog extends Dialog {

    public var confirmedHandler:Function;

    public function PurchaseConfirmationDialog(_arg1:*) {
        super("Purchase confirmation", "Continue with purchase?", "Yes", "No", null);
        this.confirmedHandler = _arg1;
    }

}
}
