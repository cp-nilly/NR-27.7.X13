package kabam.rotmg.pets.data {
public class PetSkinGroupVO {

    public var textKey:String;
    public var icons:Array;
    public var petRarityEnum:PetRarityEnum;
    public var selectedPetSkinID:int;

    public function PetSkinGroupVO(_arg1:String, _arg2:Array, _arg3:PetRarityEnum, _arg4:int) {
        this.textKey = _arg1;
        this.icons = _arg2;
        this.petRarityEnum = _arg3;
        this.selectedPetSkinID = _arg4;
    }

}
}
