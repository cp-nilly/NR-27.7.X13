package kabam.rotmg.servers.model {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.servers.api.LatLong;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class LiveServerModel implements ServerModel {

    private const servers:Vector.<Server> = new <Server>[];

    [Inject]
    public var model:PlayerModel;
    private var _descendingFlag:Boolean;


    public function setServers(_arg1:Vector.<Server>):void {
        var _local2:Server;
        this.servers.length = 0;
        for each (_local2 in _arg1) {
            this.servers.push(_local2);
        }
        this._descendingFlag = false;
        this.servers.sort(this.compareServerName);
    }

    public function getServers():Vector.<Server> {
        return (this.servers);
    }

    public function getServer():Server {
        var _local6:Server;
        var _local7:int;
        var _local8:Number;
        var _local1:Boolean = this.model.isAdmin();
        var _local2:LatLong = this.model.getMyPos();
        var _local3:Server;
        var _local4:Number = Number.MAX_VALUE;
        var _local5:int = int.MAX_VALUE;
        for each (_local6 in this.servers) {
            if (!((_local6.isFull()) && (!(_local1)))) {
                if (_local6.name == Parameters.data_.preferredServer) {
                    return (_local6);
                }
                _local7 = _local6.priority();
                _local8 = LatLong.distance(_local2, _local6.latLong);
                if ((((_local7 < _local5)) || ((((_local7 == _local5)) && ((_local8 < _local4)))))) {
                    _local3 = _local6;
                    _local4 = _local8;
                    _local5 = _local7;
                }
            }
        }
        return (_local3);
    }

    public function getServerNameByAddress(_arg1:String):String {
        var _local2:Server;
        for each (_local2 in this.servers) {
            if (_local2.address == _arg1) {
                return (_local2.name);
            }
        }
        return ("");
    }

    public function isServerAvailable():Boolean {
        return ((this.servers.length > 0));
    }

    private function compareServerName(_arg1:Server, _arg2:Server):int {
        if (_arg1.name < _arg2.name) {
            return (((this._descendingFlag) ? -1 : 1));
        }
        if (_arg1.name > _arg2.name) {
            return (((this._descendingFlag) ? 1 : -1));
        }
        return (0);
    }


}
}
