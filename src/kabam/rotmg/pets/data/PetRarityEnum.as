package kabam.rotmg.pets.data {
public class PetRarityEnum {

    public static const COMMON:PetRarityEnum = new PetRarityEnum("Pets.common", 0);
    public static const UNCOMMON:PetRarityEnum = new PetRarityEnum("Pets.uncommon", 1);
    public static const RARE:PetRarityEnum = new PetRarityEnum("Pets.rare", 2);
    public static const LEGENDARY:PetRarityEnum = new PetRarityEnum("Pets.legendary", 3);
    public static const DIVINE:PetRarityEnum = new PetRarityEnum("Pets.divine", 4);
    public static const MAX_ORDINAL:int = 4;

    public var value:String;
    public var ordinal:int;

    public function PetRarityEnum(_arg1:*, _arg2:int) {
        this.value = _arg1;
        this.ordinal = _arg2;
    }

    public static function get list():Array {
        return ([COMMON, UNCOMMON, RARE, LEGENDARY, DIVINE]);
    }

    public static function selectByValue(_arg1:String):PetRarityEnum {
        var _local2:PetRarityEnum;
        var _local3:PetRarityEnum;
        for each (_local3 in PetRarityEnum.list) {
            if (_arg1 == _local3.value) {
                _local2 = _local3;
            }
        }
        return (_local2);
    }

    public static function selectByOrdinal(_arg1:int):PetRarityEnum {
        var _local2:PetRarityEnum;
        var _local3:PetRarityEnum;
        for each (_local3 in PetRarityEnum.list) {
            if (_arg1 == _local3.ordinal) {
                _local2 = _local3;
            }
        }
        return (_local2);
    }


}
}
