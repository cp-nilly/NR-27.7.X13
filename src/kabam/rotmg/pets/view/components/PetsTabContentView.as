package kabam.rotmg.pets.view.components {
import flash.display.Bitmap;
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetFamilyKeys;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.TabStripModel;

public class PetsTabContentView extends Sprite {

    public var petBitmap:Bitmap;
    private var petsContent:Sprite;
    public var petRarityTextField:TextFieldDisplayConcrete;
    private var tabTitleTextField:TextFieldDisplayConcrete;
    private var petFamilyTextField:TextFieldDisplayConcrete;
    private var petVO:PetVO;

    public function PetsTabContentView() {
        this.petsContent = new Sprite();
        this.petRarityTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
        this.tabTitleTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 15, true);
        this.petFamilyTextField = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 13, false);
        super();
    }

    public function init(_arg1:PetVO):void {
        this.petVO = _arg1;
        this.petBitmap = _arg1.getSkin();
        this.addChildren();
        this.addAbilities();
        this.positionChildren();
        this.updateTextFields();
        this.petsContent.name = TabStripModel.PETS;
        _arg1.updated.add(this.onUpdate);
    }

    private function onUpdate():void {
        this.updatePetBitmap();
        this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
    }

    private function updatePetBitmap():void {
        this.petsContent.removeChild(this.petBitmap);
        this.petBitmap = this.petVO.getSkin();
        this.petsContent.addChild(this.petBitmap);
    }

    private function addAbilities():void {
        var _local1:uint;
        var _local3:PetAbilityDisplay;
        var _local2:uint = 3;
        _local1 = 0;
        while (_local1 < _local2) {
            _local3 = new PetAbilityDisplay(this.petVO.abilityList[_local1], 171);
            _local3.x = 3;
            _local3.y = (72 + (17 * _local1));
            this.petsContent.addChild(_local3);
            _local1++;
        }
    }

    private function getNumAbilities():uint {
        var _local1:Boolean = (((this.petVO.getRarity() == PetRarityEnum.DIVINE.value)) || ((this.petVO.getRarity() == PetRarityEnum.LEGENDARY.value)));
        if (_local1) {
            return (2);
        }
        return (3);
    }

    private function updateTextFields():void {
        this.tabTitleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getName()));
        this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
        this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.getFamily())));
    }

    private function addChildren():void {
        this.petsContent.addChild(this.petBitmap);
        this.petsContent.addChild(this.tabTitleTextField);
        this.petsContent.addChild(this.petRarityTextField);
        this.petsContent.addChild(this.petFamilyTextField);
        addChild(this.petsContent);
    }

    private function positionChildren():void {
        this.petBitmap.x = (this.petBitmap.x - 8);
        this.petBitmap.y--;
        this.petsContent.x = 7;
        this.petsContent.y = 6;
        this.tabTitleTextField.x = 45;
        this.tabTitleTextField.y = 20;
        this.petRarityTextField.x = 45;
        this.petRarityTextField.y = 33;
        this.petFamilyTextField.x = 45;
        this.petFamilyTextField.y = 47;
    }


}
}
