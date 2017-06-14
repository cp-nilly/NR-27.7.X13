package kabam.rotmg.account.core {
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.BuyCharacterSlotTask;
import kabam.rotmg.account.core.view.BuyingDialog;
import kabam.rotmg.account.core.view.PurchaseConfirmationDialog;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.ui.view.CharacterSlotNeedGoldDialog;

public class BuyCharacterSlotCommand {

    [Inject]
    public var price:int;
    [Inject]
    public var task:BuyCharacterSlotTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var account:Account;


    public function execute():void {
        if (this.isSlotUnaffordable()) {
            this.promptToGetMoreGold();
        }
        else {
            this.purchaseSlot();
        }
    }

    private function isSlotUnaffordable():Boolean {
        return ((this.model.getCredits() < this.model.getNextCharSlotPrice()));
    }

    private function promptToGetMoreGold():void {
        this.openDialog.dispatch(new CharacterSlotNeedGoldDialog());
    }

    private function purchaseSlot():void {
        this.openDialog.dispatch(new PurchaseConfirmationDialog(this.purchaseConfirmed));
    }

    private function purchaseConfirmed():void {
        this.openDialog.dispatch(new BuyingDialog());
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(new BranchingTask(this.task, this.makeSuccessTask(), this.makeFailureTask()));
        _local1.add(new DispatchSignalTask(this.closeDialog));
        this.monitor.add(_local1);
        _local1.start();
    }

    private function makeSuccessTask():Task {
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(new DispatchSignalTask(this.setScreen, new CharacterSelectionAndNewsScreen()));
        return (_local1);
    }

    private function makeFailureTask():Task {
        return (new DispatchSignalTask(this.openDialog, new ErrorDialog("Unable to complete character slot purchase")));
    }


}
}
