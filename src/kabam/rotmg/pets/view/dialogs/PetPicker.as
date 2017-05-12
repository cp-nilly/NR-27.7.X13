package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.PetVO;

import org.osflash.signals.Signal;

public class PetPicker extends GridList implements ClearsPetSlots {

    [Inject]
    public var petIconFactory:PetItemFactory;
    public var petPicked:Signal;
    private var petItems:Vector.<PetItem>;
    private var petSize:int;
    private var items:Vector.<PetItem>;
    public var doDisableUsed:Boolean = true;

    public function PetPicker() {
        this.petPicked = new PetVOSignal();
        this.items = new Vector.<PetItem>();
        super();
    }

    private static function sortByFirstAbilityPoints(_arg1:PetItem, _arg2:PetItem):int {
        var _local3:int = _arg1.getPetVO().abilityList[0].points;
        var _local4:int = _arg2.getPetVO().abilityList[0].points;
        return ((_local4 - _local3));
    }


    public function setPets(_arg1:Vector.<PetVO>):void {
        this.makePetItems(_arg1);
        this.addToGridList();
        setItems(this.items);
        this.setCorners();
    }

    private function addToGridList():void {
        var _local1:PetItem;
        for each (_local1 in this.petItems) {
            this.items.push(_local1);
        }
    }

    private function makePetItems(_arg1:Vector.<PetVO>):void {
        var _local2:PetVO;
        this.petItems = new Vector.<PetItem>();
        for each (_local2 in _arg1) {
            this.addPet(_local2);
        }
        this.petItems.sort(sortByFirstAbilityPoints);
    }

    private function setCorners():void {
        this.setPetItemState(getTopLeft(), PetItem.TOP_LEFT);
        this.setPetItemState(getTopRight(), PetItem.TOP_RIGHT);
        this.setPetItemState(getBottomLeft(), PetItem.BOTTOM_LEFT);
        this.setPetItemState(getBottomRight(), PetItem.BOTTOM_RIGHT);
    }

    private function setPetItemState(_arg1:DisplayObject, _arg2:String):void {
        if (_arg1) {
            PetItem(_arg1).setBackground(_arg2);
        }
    }

    public function setPetSize(_arg1:int):void {
        this.petSize = _arg1;
    }

    public function getPets():Vector.<PetItem> {
        return (this.petItems);
    }

    public function getPet(_arg1:int):PetItem {
        return (this.petItems[_arg1]);
    }

    public function filterFusible(_arg1:PetVO):void {
        var _local3:PetVO;
        var _local2:int;
        while (_local2 < this.petItems.length) {
            _local3 = this.petItems[_local2].getPetVO();
            if (!this.isFusible(_arg1, _local3)) {
                this.petItems[_local2].disable();
            }
            _local2++;
        }
    }

    public function filterUsedPetVO(_arg1:PetVO):void {
        var _local3:PetVO;
        var _local2:int;
        while (_local2 < this.petItems.length) {
            _local3 = this.petItems[_local2].getPetVO();
            if (_local3.getID() == _arg1.getID()) {
                this.petItems[_local2].disable();
            }
            _local2++;
        }
    }

    private function isFusible(_arg1:PetVO, _arg2:PetVO):Boolean {
        return ((((_arg1.getRarity() == _arg2.getRarity())) && ((((_arg1.getFamily() == "Unknown")) || ((_arg1.getFamily() == _arg2.getFamily()))))));
    }

    private function addPet(petVO:PetVO):void {
        var pet:Disableable;
        var pet_clickHandler:Function;
        pet_clickHandler = function (_arg1:MouseEvent):void {
            if (pet.isEnabled()) {
                petPicked.dispatch(petVO);
            }
        };
        pet = this.petIconFactory.create(petVO, this.petSize);
        this.petItems.push(pet);
        pet.addEventListener(MouseEvent.CLICK, pet_clickHandler);
    }


}
}
