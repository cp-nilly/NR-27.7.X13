package kabam.rotmg.pets.util {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.DropShadowFilter;
import flash.text.TextFormatAlign;

import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.FeedFuseArrow;
import kabam.rotmg.pets.view.components.FusionStrength;
import kabam.rotmg.pets.view.components.PetAbilityMeter;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PetFuser;
import kabam.rotmg.pets.view.components.PetsButtonBar;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetsViewAssetFactory {


    public static function returnWindowBackground(_arg1:uint, _arg2:uint):PopupWindowBackground {
        var _local3:PopupWindowBackground = new PopupWindowBackground();
        _local3.draw(_arg1, _arg2);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_ONE_POS_Y);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_TWO_POS_Y);
        return (_local3);
    }

    public static function returnFuserWindowBackground():PopupWindowBackground {
        var _local1:PopupWindowBackground = new PopupWindowBackground();
        _local1.draw(PetsConstants.WINDOW_BACKGROUND_WIDTH, PetsConstants.FUSER_WINDOW_BACKGROUND_HEIGHT);
        _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.WINDOW_LINE_ONE_POS_Y);
        _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, PetsConstants.FUSER_WINDOW_LINE_TWO_POS_Y);
        return (_local1);
    }

    public static function returnFameOrGoldButtonBar(_arg1:String, _arg2:uint):FameOrGoldBuyButtons {
        var _local3:FameOrGoldBuyButtons = new FameOrGoldBuyButtons();
        _local3.y = _arg2;
        _local3.setPrefix(_arg1);
        return (_local3);
    }

    public static function returnButtonBar():PetsButtonBar {
        var _local1:PetsButtonBar;
        _local1 = new PetsButtonBar();
        _local1.y = (PetsConstants.WINDOW_BACKGROUND_HEIGHT - 35);
        return (_local1);
    }

    private static function returnAbilityMeter():PetAbilityMeter {
        var _local1:PetAbilityMeter = new PetAbilityMeter();
        _local1.y = PetsConstants.METER_START_POSITION_Y;
        return (_local1);
    }

    public static function returnAbilityMeters():Vector.<PetAbilityMeter> {
        return (Vector.<PetAbilityMeter>([returnAbilityMeter(), returnAbilityMeter(), returnAbilityMeter()]));
    }

    public static function returnFuseDescriptionTextfield():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete();
        _local1.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FUSER_DESCRIPTION));
        _local1.setTextWidth((PetsConstants.WINDOW_BACKGROUND_WIDTH - 20)).setWordWrap(true).setHorizontalAlign(TextFormatAlign.CENTER).setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(0xB3B3B3);
        _local1.y = 42;
        return (_local1);
    }

    public static function returnPetSlotTitle():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete();
        _local1.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(0xB3B3B3).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(100);
        _local1.filters = [new DropShadowFilter(0, 0, 0)];
        _local1.y = PetsConstants.PET_SLOT_TITLE_Y;
        return (_local1);
    }

    public static function returnMediumCenteredTextfield(_arg1:uint, _arg2:uint):TextFieldDisplayConcrete {
        var _local3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local3.setSize(PetsConstants.MEDIUM_TEXT_SIZE).setColor(_arg1).setBold(true).setHorizontalAlign(TextFormatAlign.CENTER).setWordWrap(true).setTextWidth(_arg2);
        return (_local3);
    }

    public static function returnPetFeeder():PetFeeder {
        var _local1:PetFeeder = new PetFeeder();
        _local1.y = PetsConstants.PET_WINDOW_TOOL_Y_POS;
        return (_local1);
    }

    public static function returnPetFuser():PetFuser {
        var _local1:PetFuser = new PetFuser();
        _local1.y = (PetsConstants.PET_WINDOW_TOOL_Y_POS + 50);
        return (_local1);
    }

    public static function returnPetFeederArrow():FeedFuseArrow {
        var _local1:FeedFuseArrow;
        _local1 = new FeedFuseArrow();
        _local1.x = PetsConstants.PET_FEEDER_ARROW_X;
        _local1.y = PetsConstants.PET_FEEDER_ARROW_Y;
        return (_local1);
    }

    public static function returnPetFeederRightSlot():FoodFeedFuseSlot {
        var _local1:FoodFeedFuseSlot = new FoodFeedFuseSlot();
        _local1.x = (PetsConstants.PET_FEEDER_ARROW_X + 35);
        _local1.hideOuterSlot(true);
        return (_local1);
    }

    public static function returnPetFuserRightSlot():PetFeedFuseSlot {
        var _local1:PetFeedFuseSlot;
        _local1 = new PetFeedFuseSlot();
        _local1.x = (PetsConstants.PET_FEEDER_ARROW_X + 35);
        _local1.hideOuterSlot(true);
        _local1.showFamily = true;
        return (_local1);
    }

    public static function returnPetSlotShape(_arg1:uint, _arg2:uint, _arg3:int, _arg4:Boolean, _arg5:Boolean, _arg6:int = 2):Shape {
        var _local7:Shape = new Shape();
        ((_arg4) && (_local7.graphics.beginFill(0x464646, 1)));
        ((_arg5) && (_local7.graphics.lineStyle(_arg6, _arg2)));
        _local7.graphics.drawRoundRect(0, _arg3, _arg1, _arg1, 16, 16);
        _local7.x = ((100 - _arg1) * 0.5);
        return (_local7);
    }

    public static function returnCloseButton(_arg1:int):DialogCloseButton {
        var _local2:DialogCloseButton;
        _local2 = new DialogCloseButton();
        _local2.y = 4;
        _local2.x = ((_arg1 - _local2.width) - 5);
        return (_local2);
    }

    public static function returnTooltipLineBreak():LineBreakDesign {
        var _local1:LineBreakDesign;
        _local1 = new LineBreakDesign(173, 0);
        _local1.x = 5;
        _local1.y = 64;
        return (_local1);
    }

    public static function returnBitmap(_arg1:uint, _arg2:uint = 80):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg1, _arg2, true)));
    }

    public static function returnInteractionBitmap():Bitmap {
        return (getBitmapForItem(6466));
    }

    public static function returnCaretakerBitmap(_arg1:uint):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg1, 80, true, true, 10)));
    }

    private static function getBitmapForItem(_arg1:uint):Bitmap {
        var _local2:Bitmap = new Bitmap();
        var _local3:XML = ObjectLibrary.xmlLibrary_[_arg1];
        var _local4:int = 5;
        if (_local3.hasOwnProperty("ScaleValue")) {
            _local4 = _local3.ScaleValue;
        }
        var _local5:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg1, 80, true, true, _local4);
        _local5 = BitmapUtil.cropToBitmapData(_local5, 4, 4, (_local5.width - 8), (_local5.height - 8));
        return (new Bitmap(_local5));
    }

    public static function returnFusionStrength():FusionStrength {
        var _local1:FusionStrength = new FusionStrength();
        _local1.y = PetsConstants.FUSION_STRENGTH_Y_POS;
        _local1.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - _local1.width) * 0.5);
        return (_local1);
    }

    public static function returnTopAlignedTextfield(_arg1:int, _arg2:int, _arg3:Boolean, _arg4:Boolean = false):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local5.setSize(_arg2).setColor(_arg1).setBold(_arg3);
        _local5.filters = ((_arg4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local5);
    }

    public static function returnTextfield(_arg1:int, _arg2:int, _arg3:Boolean, _arg4:Boolean = false):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local5.setSize(_arg2).setColor(_arg1).setBold(_arg3);
        _local5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        _local5.filters = ((_arg4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local5);
    }

    public static function returnYardUpgradeWindowBackground(_arg1:uint, _arg2:uint):PopupWindowBackground {
        var _local3:PopupWindowBackground = new PopupWindowBackground();
        _local3.draw(_arg1, _arg2);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 212);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 349);
        return (_local3);
    }

    public static function returnEggHatchWindowBackground(_arg1:uint, _arg2:uint):PopupWindowBackground {
        var _local3:PopupWindowBackground = new PopupWindowBackground();
        _local3.draw(_arg1, _arg2);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        _local3.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 206);
        return (_local3);
    }


}
}
