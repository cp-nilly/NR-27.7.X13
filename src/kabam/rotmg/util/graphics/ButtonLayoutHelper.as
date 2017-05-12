package kabam.rotmg.util.graphics {
import flash.display.DisplayObject;
import flash.errors.IllegalOperationError;
import flash.geom.Rectangle;

public class ButtonLayoutHelper {


    public function layout(_arg1:int, ..._args):void {
        var _local3:int = _args.length;
        switch (_local3) {
            case 1:
                this.centerButton(_arg1, _args[0]);
                return;
            case 2:
                this.twoButtons(_arg1, _args[0], _args[1]);
                return;
            default:
                throw (new IllegalOperationError("Currently unable to layout more than 2 buttons"));
        }
    }

    private function centerButton(_arg1:int, _arg2:DisplayObject):void {
        var _local3:Rectangle = _arg2.getRect(_arg2);
        _arg2.x = (((_arg1 - _local3.width) * 0.5) - _local3.left);
    }

    private function twoButtons(_arg1:int, _arg2:DisplayObject, _arg3:DisplayObject):void {
        var _local5:Rectangle;
        var _local4:Rectangle = _arg2.getRect(_arg2);
        _local5 = _arg3.getRect(_arg3);
        _arg2.x = int((((_arg1 - (2 * _arg2.width)) * 0.25) - _local4.left));
        _arg3.x = int(((((3 * _arg1) - (2 * _arg3.width)) * 0.25) - _local5.left));
    }


}
}
