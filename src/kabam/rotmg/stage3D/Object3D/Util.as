package kabam.rotmg.stage3D.Object3D {
import flash.geom.Matrix3D;
import flash.utils.ByteArray;

public class Util {


    public static function perspectiveProjection(_arg1:Number = 90, _arg2:Number = 1, _arg3:Number = 1, _arg4:Number = 0x0800):Matrix3D {
        var _local5:Number = (_arg3 * Math.tan(((_arg1 * Math.PI) / 360)));
        var _local6:Number = -(_local5);
        var _local7:Number = (_local6 * _arg2);
        var _local8:Number = (_local5 * _arg2);
        var _local9:Number = ((2 * _arg3) / (_local8 - _local7));
        var _local10:Number = ((2 * _arg3) / (_local5 - _local6));
        var _local11:Number = ((_local8 + _local7) / (_local8 - _local7));
        var _local12:Number = ((_local5 + _local6) / (_local5 - _local6));
        var _local13:Number = (-((_arg4 + _arg3)) / (_arg4 - _arg3));
        var _local14:Number = ((-2 * (_arg4 * _arg3)) / (_arg4 - _arg3));
        return (new Matrix3D(Vector.<Number>([_local9, 0, 0, 0, 0, _local10, 0, 0, _local11, _local12, _local13, -1, 0, 0, _local14, 0])));
    }

    public static function readString(_arg1:ByteArray, _arg2:int):String {
        var _local5:uint;
        var _local3 = "";
        var _local4:int;
        while (_local4 < _arg2) {
            _local5 = _arg1.readUnsignedByte();
            if (_local5 === 0) {
                _arg1.position = (_arg1.position + Math.max(0, (_arg2 - (_local4 + 1))));
                break;
            }
            _local3 = (_local3 + String.fromCharCode(_local5));
            _local4++;
        }
        return (_local3);
    }

    public static function upperPowerOfTwo(_arg1:uint):uint {
        _arg1--;
        _arg1 = (_arg1 | (_arg1 >> 1));
        _arg1 = (_arg1 | (_arg1 >> 2));
        _arg1 = (_arg1 | (_arg1 >> 4));
        _arg1 = (_arg1 | (_arg1 >> 8));
        _arg1 = (_arg1 | (_arg1 >> 16));
        return ((_arg1 + 1));
    }


}
}
