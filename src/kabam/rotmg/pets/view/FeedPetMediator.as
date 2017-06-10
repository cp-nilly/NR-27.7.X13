package kabam.rotmg.pets.view {
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.messaging.impl.outgoing.PetUpgradeRequest;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.pets.controller.PetFeedResultSignal;
import kabam.rotmg.pets.controller.UpgradePetSignal;
import kabam.rotmg.pets.data.FeedPetRequestVO;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.dialogs.PetPickerDialog;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FeedPetMediator extends Mediator {

    [Inject]
    public var view:FeedPetView;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var petFeedResult:PetFeedResultSignal;
    [Inject]
    public var upgradePet:UpgradePetSignal;
    [Inject]
    public var injector:Injector;


    override public function initialize():void {
        this.view.init();
        var _local1:PetVO = ((this.petSlotsState.leftSlotPetVO) ? this.petSlotsState.leftSlotPetVO : this.petsModel.getActivePet());
        this.view.setAbilityMeterLabels(((_local1) ? _local1.abilityList : null), ((_local1) ? _local1.getMaxAbilityPower() : 0));
        this.view.openPetPicker.add(this.onOpenPetPicker);
        this.view.closed.add(this.onClosed);
        this.view.goldPurchase.add(this.onGoldPurchase);
        this.view.famePurchase.add(this.onFamePurchase);
        this.petFeedResult.add(this.onPetFeedResult);
    }

    private function onPetFeedResult():void {
        this.view.resetFeed();
    }

    override public function destroy():void {
        this.view.openPetPicker.remove(this.onOpenPetPicker);
        this.view.goldPurchase.remove(this.onGoldPurchase);
        this.view.famePurchase.remove(this.onFamePurchase);
    }

    private function onClosed():void {
        this.petSlotsState.clear();
        this.view.closed.remove(this.onClosed);
    }

    private function onOpenPetPicker():void {
        this.petSlotsState.caller = FeedPetView;
        this.openDialog.dispatch(this.injector.getInstance(PetPickerDialog));
    }

    private function onGoldPurchase(_arg1:int):void {
        var _local2:SlotObjectData;
        _local2 = new SlotObjectData();
        _local2.objectId_ = this.petSlotsState.rightSlotOwnerId;
        _local2.objectType_ = this.petSlotsState.rightSlotItemId;
        _local2.slotId_ = this.petSlotsState.rightSlotId;
        var _local3:FeedPetRequestVO = new FeedPetRequestVO(this.petSlotsState.leftSlotPetVO.getID(), _local2, PetUpgradeRequest.GOLD_PAYMENT_TYPE);
        this.upgradePet.dispatch(_local3);
    }

    private function onFamePurchase(_arg1:int):void {
        var _local2:SlotObjectData = new SlotObjectData();
        _local2.objectId_ = this.petSlotsState.rightSlotOwnerId;
        _local2.objectType_ = this.petSlotsState.rightSlotItemId;
        _local2.slotId_ = this.petSlotsState.rightSlotId;
        var _local3:FeedPetRequestVO = new FeedPetRequestVO(this.petSlotsState.leftSlotPetVO.getID(), _local2, PetUpgradeRequest.FAME_PAYMENT_TYPE);
        this.upgradePet.dispatch(_local3);
    }


}
}
