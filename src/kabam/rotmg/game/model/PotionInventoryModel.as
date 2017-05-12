package kabam.rotmg.game.model {
import flash.utils.Dictionary;

import kabam.rotmg.ui.model.PotionModel;

import org.osflash.signals.Signal;

public class PotionInventoryModel {

    public static const HEALTH_POTION_ID:int = 2594;
    public static const HEALTH_POTION_SLOT:int = 254;
    public static const MAGIC_POTION_ID:int = 2595;
    public static const MAGIC_POTION_SLOT:int = 0xFF;

    public var potionModels:Dictionary;
    public var updatePosition:Signal;

    public function PotionInventoryModel() {
        this.potionModels = new Dictionary();
        this.updatePosition = new Signal(int);
    }

    public static function getPotionSlot(_arg1:int):int {
        switch (_arg1) {
            case HEALTH_POTION_ID:
                return (HEALTH_POTION_SLOT);
            case MAGIC_POTION_ID:
                return (MAGIC_POTION_SLOT);
        }
        return (-1);
    }


    public function initializePotionModels(_arg1:XML):void {
        var _local6:int;
        var _local7:PotionModel;
        var _local2:int = _arg1.PotionPurchaseCooldown;
        var _local3:int = _arg1.PotionPurchaseCostCooldown;
        var _local4:int = _arg1.MaxStackablePotions;
        var _local5:Array = new Array();
        for each (_local6 in _arg1.PotionPurchaseCosts.cost) {
            _local5.push(_local6);
        }
        _local7 = new PotionModel();
        _local7.purchaseCooldownMillis = _local2;
        _local7.priceCooldownMillis = _local3;
        _local7.maxPotionCount = _local4;
        _local7.objectId = HEALTH_POTION_ID;
        _local7.position = 0;
        _local7.costs = _local5;
        this.potionModels[_local7.position] = _local7;
        _local7.update.add(this.update);
        _local7 = new PotionModel();
        _local7.purchaseCooldownMillis = _local2;
        _local7.priceCooldownMillis = _local3;
        _local7.maxPotionCount = _local4;
        _local7.objectId = MAGIC_POTION_ID;
        _local7.position = 1;
        _local7.costs = _local5;
        this.potionModels[_local7.position] = _local7;
        _local7.update.add(this.update);
    }

    public function getPotionModel(_arg1:uint):PotionModel {
        var _local2:String;
        for (_local2 in this.potionModels) {
            if (this.potionModels[_local2].objectId == _arg1) {
                return (this.potionModels[_local2]);
            }
        }
        return (null);
    }

    private function update(_arg1:int):void {
        this.updatePosition.dispatch(_arg1);
    }


}
}
