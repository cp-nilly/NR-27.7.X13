package kabam.rotmg.ui.commands {
import com.company.assembleegameclient.account.ui.NewChooseNameFrame;

import flash.display.Sprite;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.view.ChooseNameRegisterDialog;

public class ChooseNameCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        var _local1:Sprite;
        if (this.account.isRegistered()) {
            _local1 = new NewChooseNameFrame();
        }
        else {
            _local1 = new ChooseNameRegisterDialog();
        }
        this.openDialog.dispatch(_local1);
    }


}
}
