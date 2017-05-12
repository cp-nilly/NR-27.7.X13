package kabam.rotmg.util.graphics {
import flash.display.Graphics;

public class GraphicsHelper {


    public function drawBevelRect(_arg1:int, _arg2:int, _arg3:BevelRect, _arg4:Graphics):void {
        var _local5:int = (_arg1 + _arg3.width);
        var _local6:int = (_arg2 + _arg3.height);
        var _local7:int = _arg3.bevel;
        if (_arg3.topLeftBevel) {
            _arg4.moveTo(_arg1, (_arg2 + _local7));
            _arg4.lineTo((_arg1 + _local7), _arg2);
        }
        else {
            _arg4.moveTo(_arg1, _arg2);
        }
        if (_arg3.topRightBevel) {
            _arg4.lineTo((_local5 - _local7), _arg2);
            _arg4.lineTo(_local5, (_arg2 + _local7));
        }
        else {
            _arg4.lineTo(_local5, _arg2);
        }
        if (_arg3.bottomRightBevel) {
            _arg4.lineTo(_local5, (_local6 - _local7));
            _arg4.lineTo((_local5 - _local7), _local6);
        }
        else {
            _arg4.lineTo(_local5, _local6);
        }
        if (_arg3.bottomLeftBevel) {
            _arg4.lineTo((_arg1 + _local7), _local6);
            _arg4.lineTo(_arg1, (_local6 - _local7));
        }
        else {
            _arg4.lineTo(_arg1, _local6);
        }
    }


}
}
