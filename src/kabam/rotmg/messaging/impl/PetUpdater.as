package kabam.rotmg.messaging.impl {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.Pet;
import com.company.assembleegameclient.util.ConditionEffect;

import kabam.rotmg.messaging.impl.data.StatData;
import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;

public class PetUpdater {

    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var gameSprite:AGameSprite;


    public function updatePetVOs(_arg1:Pet, _arg2:Vector.<StatData>):void {
        var _local4:StatData;
        var _local5:AbilityVO;
        var _local6:*;
        var _local3:PetVO = ((_arg1.vo) || (this.createPetVO(_arg1, _arg2)));
        if (_local3 == null) {
            return;
        }
        for each (_local4 in _arg2) {
            _local6 = _local4.statValue_;
            if (_local4.statType_ == StatData.TEXTURE_STAT) {
                _local3.setSkin(_local6);
            }
            switch (_local4.statType_) {
                case StatData.PET_INSTANCEID_STAT:
                    _local3.setID(_local6);
                    break;
                case StatData.PET_NAME_STAT:
                    _local3.setName(_local4.strStatValue_);
                    break;
                case StatData.PET_TYPE_STAT:
                    _local3.setType(_local6);
                    break;
                case StatData.PET_RARITY_STAT:
                    _local3.setRarity(_local6);
                    break;
                case StatData.PET_MAXABILITYPOWER_STAT:
                    _local3.setMaxAbilityPower(_local6);
                    break;
                case StatData.PET_FAMILY_STAT:
                    break;
                case StatData.PET_FIRSTABILITY_POINT_STAT:
                    _local5 = _local3.abilityList[0];
                    _local5.points = _local6;
                    break;
                case StatData.PET_SECONDABILITY_POINT_STAT:
                    _local5 = _local3.abilityList[1];
                    _local5.points = _local6;
                    break;
                case StatData.PET_THIRDABILITY_POINT_STAT:
                    _local5 = _local3.abilityList[2];
                    _local5.points = _local6;
                    break;
                case StatData.PET_FIRSTABILITY_POWER_STAT:
                    _local5 = _local3.abilityList[0];
                    _local5.level = _local6;
                    break;
                case StatData.PET_SECONDABILITY_POWER_STAT:
                    _local5 = _local3.abilityList[1];
                    _local5.level = _local6;
                    break;
                case StatData.PET_THIRDABILITY_POWER_STAT:
                    _local5 = _local3.abilityList[2];
                    _local5.level = _local6;
                    break;
                case StatData.PET_FIRSTABILITY_TYPE_STAT:
                    _local5 = _local3.abilityList[0];
                    _local5.type = _local6;
                    break;
                case StatData.PET_SECONDABILITY_TYPE_STAT:
                    _local5 = _local3.abilityList[1];
                    _local5.type = _local6;
                    break;
                case StatData.PET_THIRDABILITY_TYPE_STAT:
                    _local5 = _local3.abilityList[2];
                    _local5.type = _local6;
                    break;
            }
            if (_local5) {
                _local5.updated.dispatch(_local5);
            }
        }
    }

    private function createPetVO(_arg1:Pet, _arg2:Vector.<StatData>):PetVO {
        var _local3:StatData;
        var _local4:PetVO;
        for each (_local3 in _arg2) {
            if (_local3.statType_ == StatData.PET_INSTANCEID_STAT) {
                _local4 = this.petsModel.getCachedVOOnly(_local3.statValue_);
                _arg1.vo = ((_local4) ? _local4 : ((this.gameSprite.map.isPetYard) ? this.petsModel.getPetVO(_local3.statValue_) : new PetVO(_local3.statValue_)));
                return (_arg1.vo);
            }
        }
        return (null);
    }

    public function updatePet(_arg1:Pet, _arg2:Vector.<StatData>):void {
        var _local3:StatData;
        var _local4:*;
        for each (_local3 in _arg2) {
            _local4 = _local3.statValue_;
            if (_local3.statType_ == StatData.TEXTURE_STAT) {
                _arg1.setSkin(_local4);
            }
            if (_local3.statType_ == StatData.SIZE_STAT) {
                _arg1.size_ = _local4;
            }
            if (_local3.statType_ == StatData.CONDITION_STAT) {
                _arg1.condition_[ConditionEffect.CE_FIRST_BATCH] = _local4;
            }
        }
    }


}
}
