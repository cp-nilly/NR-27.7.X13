package kabam.rotmg.packages.services {
import kabam.rotmg.packages.model.PackageInfo;

import org.osflash.signals.Signal;

public class PackageModel {

    public var numSpammed:int = 0;
    public var dataChanged:Signal;
    private var models:Object;
    private var initialized:Boolean;

    public function PackageModel() {
        this.dataChanged = new Signal();
        super();
    }

    public function getInitialized():Boolean {
        return (this.initialized);
    }

    public function getPackageById(_arg1:int):PackageInfo {
        return (this.models[_arg1]);
    }

    public function hasPackage(_arg1:int):Boolean {
        return ((_arg1 in this.models));
    }

    public function setPackages(_arg1:Array):void {
        var _local2:PackageInfo;
        this.models = {};
        for each (_local2 in _arg1) {
            _local2.dataChanged.add(this.onDataChanged);
            this.models[_local2.packageID] = _local2;
        }
        this.initialized = true;
        this.dataChanged.dispatch();
    }

    private function onDataChanged():void {
        this.dataChanged.dispatch();
    }

    public function canPurchasePackage(_arg1:int):Boolean {
        var _local2:PackageInfo = this.models[_arg1];
        return (((_local2) && (_local2.canPurchase())));
    }

    public function getPriorityPackage():PackageInfo {
        var _local2:PackageInfo;
        var _local1:PackageInfo;
        for each (_local2 in this.models) {
            if ((((_local1 == null)) || ((_local2.priority < _local1.priority)))) {
                _local1 = _local2;
            }
        }
        return (_local2);
    }

    public function hasPackages():Boolean {
        var _local1:Object;
        for each (_local1 in this.models) {
            return (true);
        }
        return (false);
    }


}
}
