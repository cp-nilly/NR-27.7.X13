package kabam.rotmg.dialogs.model {
import com.company.assembleegameclient.parameters.Parameters;

import org.osflash.signals.Signal;

public class DialogsModel {

    private var popupPriority:Array;
    private var queue:Vector.<PopupQueueEntry>;

    public function DialogsModel() {
        this.popupPriority = [PopupNamesConfig.BEGINNERS_OFFER_POPUP, PopupNamesConfig.NEWS_POPUP, PopupNamesConfig.DAILY_LOGIN_POPUP, PopupNamesConfig.PACKAGES_OFFER_POPUP];
        this.queue = new Vector.<PopupQueueEntry>();
        super();
    }

    public function addPopupToStartupQueue(_arg1:String, _arg2:Signal, _arg3:int, _arg4:Object):void {
        if ((((_arg3 == -1)) || (this.canDisplayPopupToday(_arg1)))) {
            this.queue.push(new PopupQueueEntry(_arg1, _arg2, _arg3, _arg4));
            this.sortQueue();
        }
    }

    private function sortQueue():void {
        this.queue.sort(function (_arg1:PopupQueueEntry, _arg2:PopupQueueEntry) {
            var _local3:int = getPopupPriorityByName(_arg1.name);
            var _local4:int = getPopupPriorityByName(_arg2.name);
            if (_local3 < _local4) {
                return (-1);
            }
            return (1);
        });
    }

    public function flushStartupQueue():PopupQueueEntry {
        if (this.queue.length == 0) {
            return (null);
        }
        var _local1:PopupQueueEntry = this.queue.shift();
        Parameters.data_[_local1.name] = new Date().time;
        return (_local1);
    }

    public function canDisplayPopupToday(_arg1:String):Boolean {
        var _local2:int;
        var _local3:int;
        if (!Parameters.data_[_arg1]) {
            return (true);
        }
        _local2 = Math.floor((Number(Parameters.data_[_arg1]) / 86400000));
        _local3 = Math.floor((new Date().time / 86400000));
        return ((_local3 > _local2));
    }

    public function getPopupPriorityByName(_arg1:String):int {
        var _local2:int = this.popupPriority.indexOf(_arg1);
        if (_local2 < 0) {
            _local2 = int.MAX_VALUE;
        }
        return (_local2);
    }


}
}
