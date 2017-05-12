package kabam.rotmg.pets.view {
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.PetSkinGroupVO;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;
import kabam.rotmg.pets.view.components.slot.FeedFuseSlot;
import kabam.rotmg.pets.view.dialogs.PetItem;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class PetSkinGroup extends Sprite {

    private const SPACING:uint = 55;
    public const initComplete:Signal = new Signal();

    private var rarityTextField:TextFieldDisplayConcrete;
    private var upperContainer:Sprite;
    private var lowerContainer:Sprite;
    private var numUpper:uint = 0;
    private var numLower:uint = 0;
    private var petSkinGroupVO:PetSkinGroupVO;
    private var selectedSlot:FeedFuseSlot;
    private var slots:Vector.<FeedFuseSlot>;
    public var skinSelected:Signal;
    public var disabled:Boolean = false;
    public var index:uint;

    public function PetSkinGroup(_arg1:uint) {
        this.rarityTextField = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);
        this.upperContainer = new Sprite();
        this.lowerContainer = new Sprite();
        this.slots = new Vector.<FeedFuseSlot>();
        this.skinSelected = new Signal(PetVO);
        super();
        this.index = _arg1;
    }

    public function init(_arg1:PetSkinGroupVO):void {
        this.petSkinGroupVO = _arg1;
        this.rarityTextField.setStringBuilder(new LineBuilder().setParams(_arg1.textKey));
        this.createIconSquares();
        this.addChildren();
        this.positionChildren();
        this.initComplete.dispatch();
    }

    private function positionChildren():void {
        this.upperContainer.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.upperContainer.width) / 2);
        this.lowerContainer.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.lowerContainer.width) / 2);
        this.lowerContainer.y = 50;
    }

    private function addChildren():void {
        addChild(this.rarityTextField);
        addChild(this.upperContainer);
        addChild(this.lowerContainer);
    }

    private function createIconSquares():void {
        var _local1:uint;
        var _local3:PetIcon;
        var _local4:PetItem;
        var _local5:FeedFuseSlot;
        var _local6:NativeSignal;
        var _local2:uint = this.petSkinGroupVO.icons.length;
        _local1 = 0;
        while (_local1 < _local2) {
            _local3 = this.createPetIcon(this.petSkinGroupVO.icons[_local1], 48);
            _local4 = new PetItem();
            _local4.setPetIcon(_local3);
            _local5 = new FeedFuseSlot();
            _local5.mouseChildren = false;
            _local5.setIcon(_local4);
            _local6 = new NativeSignal(_local5, MouseEvent.CLICK, MouseEvent);
            _local6.add(this.onSkinClicked);
            if ((_local1 < 4)) {
                this.addToUpper(_local5);
            }
            else {
                this.addToLower(_local5);
            }
            this.slots.push(_local5);
            if (this.disabled) {
                _local4.disable();
                _local5.mouseChildren = false;
                _local5.mouseEnabled = false;
            }
            _local1++;
        }
    }

    private function createPetIcon(_arg1:PetVO, _arg2:int):PetIcon {
        var _local3:PetIconFactory = new PetIconFactory();
        var _local4:PetIcon = _local3.create(_arg1, _arg2);
        _local4.setTooltipEnabled(false);
        return (_local4);
    }

    private function onSkinClicked(_arg1:MouseEvent):void {
        this.skinSelected.dispatch(PetItem(_arg1.target.getIcon()).getPetVO());
    }

    private function addToUpper(_arg1:Sprite):void {
        _arg1.x = (this.SPACING * this.numUpper);
        this.upperContainer.addChild(_arg1);
        this.numUpper++;
    }

    private function addToLower(_arg1:Sprite):void {
        _arg1.x = (this.SPACING * this.numLower);
        this.lowerContainer.addChild(_arg1);
        this.numLower++;
    }

    public function onSlotSelected(_arg1:int):void {
        var _local2:FeedFuseSlot;
        var _local3:int;
        var _local4:uint;
        while (_local4 < this.slots.length) {
            _local2 = FeedFuseSlot(this.slots[_local4]);
            _local3 = PetItem(_local2.getIcon()).getPetVO().getSkinID();
            _local2.highlight((_local3 == _arg1));
            _local4++;
        }
    }


}
}
