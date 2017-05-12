package kabam.rotmg.pets.data {
public class UpgradePetYardRequestVO implements IUpgradePetRequestVO {

    public var objectID:int;
    public var paymentTransType:int;

    public function UpgradePetYardRequestVO(_arg1:int, _arg2:int) {
        this.objectID = _arg1;
        this.paymentTransType = _arg2;
    }

}
}
