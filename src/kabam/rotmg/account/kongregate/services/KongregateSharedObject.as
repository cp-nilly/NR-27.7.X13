package kabam.rotmg.account.kongregate.services {
import com.company.assembleegameclient.util.GUID;

import flash.net.SharedObject;

public class KongregateSharedObject {

    private var guid:String;


    public function getGuestGUID():String {
        return ((this.guid = ((this.guid) || (this.makeGuestGUID()))));
    }

    private function makeGuestGUID():String {
        var _local1:String;
        var _local2:SharedObject;
        try {
            _local2 = SharedObject.getLocal("KongregateRotMG", "/");
            if (_local2.data.hasOwnProperty("GuestGUID")) {
                _local1 = _local2.data["GuestGUID"];
            }
        }
        catch (error:Error) {
        }
        if (_local1 == null) {
            _local1 = GUID.create();
            try {
                _local2 = SharedObject.getLocal("KongregateRotMG", "/");
                _local2.data["GuestGUID"] = _local1;
                _local2.flush();
            }
            catch (error:Error) {
            }
        }
        return (_local1);
    }


}
}
