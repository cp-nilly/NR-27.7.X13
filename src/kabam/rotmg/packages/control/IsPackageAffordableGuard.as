package kabam.rotmg.packages.control {
import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.packages.model.PackageInfo;

import robotlegs.bender.framework.api.IGuard;

public class IsPackageAffordableGuard implements IGuard {

    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var openMoneyWindow:OpenMoneyWindowSignal;
    [Inject]
    public var packageInfo:PackageInfo;


    public function approve():Boolean {
        var _local1 = (this.playerModel.getCredits() >= this.packageInfo.price);
        if (!_local1) {
            this.openMoneyWindow.dispatch();
        }
        return (_local1);
    }


}
}
