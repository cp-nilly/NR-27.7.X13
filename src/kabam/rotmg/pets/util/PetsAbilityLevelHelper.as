package kabam.rotmg.pets.util {
import kabam.rotmg.util.GeometricSeries;

public class PetsAbilityLevelHelper {

    private static const levelToPoints:GeometricSeries = new GeometricSeries(20, 1.08);


    public static function getTotalAbilityPointsForLevel(_arg1:int):Number {
        return (levelToPoints.getSummation(_arg1));
    }

    public static function getCurrentPointsForLevel(_arg1:int, _arg2:int):Number {
        var _local3:Number = getTotalAbilityPointsForLevel((_arg2 - 1));
        return ((_arg1 - _local3));
    }

    public static function getAbilityPointsforLevel(_arg1:int):Number {
        return (levelToPoints.getTerm((_arg1 - 1)));
    }


}
}
