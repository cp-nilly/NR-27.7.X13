package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.Sprite;

import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.data.PetFamilyKeys;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.TabStripModel;

public class PetTooltip extends ToolTip {

    private const petsContent:Sprite = new Sprite();
    private const titleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
    private const petRarityTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
    private const petFamilyTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xB3B3B3, 12, false);
    private const lineBreak:LineBreakDesign = PetsViewAssetFactory.returnTooltipLineBreak();

    private var petBitmap:Bitmap;
    private var petVO:PetVO;

    public function PetTooltip(_arg1:PetVO) {
        this.petVO = _arg1;
        super(0x363636, 1, 0xFFFFFF, 1, true);
        this.petsContent.name = TabStripModel.PETS;
    }

    public function init():void {
        this.petBitmap = this.petVO.getSkin();
        this.addChildren();
        this.addAbilities();
        this.positionChildren();
        this.updateTextFields();
    }

    private function updateTextFields():void {
        this.titleTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getName()));
        this.petRarityTextField.setStringBuilder(new LineBuilder().setParams(this.petVO.getRarity()));
        this.petFamilyTextField.setStringBuilder(new LineBuilder().setParams(PetFamilyKeys.getTranslationKey(this.petVO.getFamily())));
    }

    private function addChildren():void {
        this.clearChildren();
        this.petsContent.graphics.beginFill(0, 0);
        this.petsContent.graphics.drawRect(0, 0, PetsConstants.TOOLTIP_WIDTH, PetsConstants.TOOLTIP_HEIGHT);
        this.petsContent.addChild(this.petBitmap);
        this.petsContent.addChild(this.titleTextField);
        this.petsContent.addChild(this.petRarityTextField);
        this.petsContent.addChild(this.petFamilyTextField);
        this.petsContent.addChild(this.lineBreak);
        if (!contains(this.petsContent)) {
            addChild(this.petsContent);
        }
    }

    private function clearChildren():void {
        this.petsContent.graphics.clear();
        while (this.petsContent.numChildren > 0) {
            this.petsContent.removeChildAt(0);
        }
    }

    private function addAbilities():void {
        var _local1:uint;
        var _local3:AbilityVO;
        var _local4:PetAbilityDisplay;
        var _local2:uint = 3;
        _local1 = 0;
        while (_local1 < _local2) {
            _local3 = this.petVO.abilityList[_local1];
            _local4 = new PetAbilityDisplay(_local3, 174);
            _local4.x = 8;
            _local4.y = (86 + (17 * _local1));
            this.petsContent.addChild(_local4);
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

    private function positionChildren():void {
        this.titleTextField.x = 55;
        this.titleTextField.y = 21;
        this.petRarityTextField.x = 55;
        this.petRarityTextField.y = 35;
        this.petFamilyTextField.x = 55;
        this.petFamilyTextField.y = 48;
    }


}
}
