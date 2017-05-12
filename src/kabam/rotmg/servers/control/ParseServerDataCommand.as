package kabam.rotmg.servers.control {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class ParseServerDataCommand {

    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var data:XML;


    public function execute():void {
        this.servers.setServers(this.makeListOfServers());
    }

    private function makeListOfServers():Vector.<Server> {
        var _local3:XML;
        var _local1:XMLList = this.data.child("Servers").child("Server");
        var _local2:Vector.<Server> = new <Server>[];
        for each (_local3 in _local1) {
            _local2.push(this.makeServer(_local3));
        }
        return (_local2);
    }

    private function makeServer(_arg1:XML):Server {
        return (new Server().setName(_arg1.Name).setAddress(_arg1.DNS).setPort(Parameters.PORT).setLatLong(Number(_arg1.Lat), Number(_arg1.Long)).setUsage(_arg1.Usage).setIsAdminOnly(_arg1.hasOwnProperty("AdminOnly")));
    }


}
}
