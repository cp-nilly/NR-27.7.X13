package kabam.rotmg.pets.view {
import kabam.rotmg.pets.controller.reskin.UpdateSelectedPetForm;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetSkinGroupVO;
import kabam.rotmg.pets.data.PetVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetSkinGroupMediator extends Mediator {

    [Inject]
    public var view:PetSkinGroup;
    [Inject]
    public var petFormModel:PetFormModel;
    [Inject]
    public var updateSelectedPetForm:UpdateSelectedPetForm;


    override public function initialize():void {
        var _local1:PetSkinGroupVO = this.petFormModel.petSkinGroupVOs[this.view.index];
        var _local2:PetRarityEnum = _local1.petRarityEnum;
        this.updateSelectedPetForm.add(this.onUpdateSelectedPetForm);
        this.view.skinSelected.add(this.onSkinSelected);
        this.view.disabled = this.isSelectedPetRarerThan(_local2);
        this.view.init(_local1);
    }

    private function onSkinSelected(_arg1:PetVO):void {
        this.petFormModel.setSelectedSkin(_arg1.getSkinID());
        this.updateSelectedPetForm.dispatch();
    }

    private function onUpdateSelectedPetForm():void {
        this.view.onSlotSelected(this.petFormModel.getSelectedSkin());
    }

    private function isSelectedPetRarerThan(_arg1:PetRarityEnum):Boolean {
        var _local2:PetVO = this.petFormModel.getSelectedPet();
        var _local3:PetRarityEnum = PetRarityEnum.selectByValue(_local2.getRarity());
        var _local4:int = _local3.ordinal;
        return ((_arg1.ordinal > _local4));
    }


}
}
