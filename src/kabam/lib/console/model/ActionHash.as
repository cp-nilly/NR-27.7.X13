package kabam.lib.console.model {
import org.osflash.signals.Signal;

final class ActionHash {

    private var signalMap:Object;
    private var descriptionMap:Object;

    public function ActionHash() {
        this.signalMap = {};
        this.descriptionMap = {};
    }

    public function register(_arg1:String, _arg2:String, _arg3:Signal):void {
        this.signalMap[_arg1] = _arg3;
        this.descriptionMap[_arg1] = _arg2;
    }

    public function getNames():Vector.<String> {
        var _local2:String;
        var _local1:Vector.<String> = new <String>[];
        for (_local2 in this.signalMap) {
            _local1.push(((_local2 + " - ") + this.descriptionMap[_local2]));
        }
        return (_local1);
    }

    public function execute(_arg1:String):void {
        var _local2:Array = _arg1.split(" ");
        if (_local2.length == 0) {
            return;
        }
        var _local3:String = _local2.shift();
        var _local4:Signal = this.signalMap[_local3];
        if (!_local4) {
            return;
        }
        if (_local2.length > 0) {
            _local4.dispatch.apply(this, _local2.join(" ").split(","));
        }
        else {
            _local4.dispatch.apply(this);
        }
    }

    public function has(_arg1:String):Boolean {
        var _local2:Array = _arg1.split(" ");
        return ((((_local2.length > 0)) && (!((this.signalMap[_local2[0]] == null)))));
    }


}
}
