package kabam.rotmg.pets.data {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.objects.ObjectLibrary;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.pets.controller.NotifyActivePetUpdated;

public class PetsModel {

    [Inject]
    public var notifyActivePetUpdated:NotifyActivePetUpdated;
    [Inject]
    public var playerModel:PlayerModel;
    private var hash:Object;
    private var pets:Vector.<PetVO>;
    private var yardXmlData:XML;
    private var type:int;
    private var activePet:PetVO;

    public function PetsModel() {
        this.hash = {};
        this.pets = new Vector.<PetVO>();
        super();
    }

    public function getPetVO(_arg1:int):PetVO {
        var _local2:PetVO;
        if (this.hash[_arg1] != null) {
            return (this.hash[_arg1]);
        }
        _local2 = new PetVO(_arg1);
        this.pets.push(_local2);
        this.hash[_arg1] = _local2;
        return (_local2);
    }

    public function getCachedVOOnly(_arg1:int):PetVO {
        return (this.hash[_arg1]);
    }

    public function getAllPets():Vector.<PetVO> {
        return (this.pets);
    }

    public function addPet(_arg1:PetVO):void {
        this.pets.push(_arg1);
    }

    public function setActivePet(_arg1:PetVO):void {
        this.activePet = _arg1;
        var _local2:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        if (_local2) {
            _local2.setPetVO(this.activePet);
        }
        this.notifyActivePetUpdated.dispatch();
    }

    public function getActivePet():PetVO {
        return (this.activePet);
    }

    public function removeActivePet():void {
        var _local1:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        if (_local1) {
            _local1.setPetVO(null);
        }
        this.activePet = null;
        this.notifyActivePetUpdated.dispatch();
    }

    public function getPet(_arg1:int):PetVO {
        var _local2:int = this.getPetIndex(_arg1);
        if (_local2 == -1) {
            return (null);
        }
        return (this.pets[_local2]);
    }

    private function getPetIndex(_arg1:int):int {
        var _local2:PetVO;
        var _local3:uint;
        while (_local3 < this.pets.length) {
            _local2 = this.pets[_local3];
            if (_local2.getID() == _arg1) {
                return (_local3);
            }
            _local3++;
        }
        return (-1);
    }

    public function setPetYardType(_arg1:int):void {
        this.type = _arg1;
        this.yardXmlData = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(_arg1));
    }

    public function getPetYardRarity():uint {
        return (PetYardEnum.selectByValue(this.yardXmlData.@id).rarity.ordinal);
    }

    public function getPetYardType():int {
        return (((this.yardXmlData) ? PetYardEnum.selectByValue(this.yardXmlData.@id).ordinal : 1));
    }

    public function isMapNameYardName(_arg1:AbstractMap):Boolean {
        return (((_arg1.name_) && ((_arg1.name_.substr(0, 8) == "Pet Yard"))));
    }

    public function getPetYardUpgradeFamePrice():int {
        return (int(this.yardXmlData.Fame));
    }

    public function getPetYardUpgradeGoldPrice():int {
        return (int(this.yardXmlData.Price));
    }

    public function getPetYardObjectID():int {
        return (this.type);
    }

    public function deletePet(_arg1:int):void {
        this.pets.splice(this.getPetIndex(_arg1), 1);
    }

    public function clearPets():void {
        this.hash = {};
        this.pets = new Vector.<PetVO>();
        this.removeActivePet();
    }


}
}
