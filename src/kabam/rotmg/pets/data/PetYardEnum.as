package kabam.rotmg.pets.data {
public class PetYardEnum {

    public static const PET_YARD_ONE:PetYardEnum = new PetYardEnum("Yard Upgrader 1", 1, PetRarityEnum.COMMON);
    public static const PET_YARD_TWO:PetYardEnum = new PetYardEnum("Yard Upgrader 2", 2, PetRarityEnum.UNCOMMON);
    public static const PET_YARD_THREE:PetYardEnum = new PetYardEnum("Yard Upgrader 3", 3, PetRarityEnum.RARE);
    public static const PET_YARD_FOUR:PetYardEnum = new PetYardEnum("Yard Upgrader 4", 4, PetRarityEnum.LEGENDARY);
    public static const PET_YARD_FIVE:PetYardEnum = new PetYardEnum("Yard Upgrader 5", 5, PetRarityEnum.DIVINE);
    public static const MAX_ORDINAL:int = 5;

    public var value:String;
    public var ordinal:int;
    public var rarity:PetRarityEnum;

    public function PetYardEnum(_arg1:*, _arg2:int, _arg3:PetRarityEnum) {
        this.value = _arg1;
        this.ordinal = _arg2;
        this.rarity = _arg3;
    }

    public static function get list():Array {
        return ([PET_YARD_ONE, PET_YARD_TWO, PET_YARD_THREE, PET_YARD_FOUR, PET_YARD_FIVE]);
    }

    public static function selectByValue(_arg1:String):PetYardEnum {
        var _local2:PetYardEnum;
        var _local3:PetYardEnum;
        for each (_local3 in PetYardEnum.list) {
            if (_arg1 == _local3.value) {
                _local2 = _local3;
            }
        }
        return (_local2);
    }

    public static function selectByOrdinal(_arg1:int):PetYardEnum {
        var _local2:PetYardEnum;
        var _local3:PetYardEnum;
        for each (_local3 in PetYardEnum.list) {
            if (_arg1 == _local3.ordinal) {
                _local2 = _local3;
            }
        }
        return (_local2);
    }


}
}
