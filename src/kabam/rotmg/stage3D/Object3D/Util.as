package kabam.rotmg.stage3D.Object3D {
import flash.geom.Matrix3D;
import flash.utils.ByteArray;

public class Util {


    public static function perspectiveProjection(fov:Number = 90, scale:Number = 1, zn:Number = 1, _arg4:Number = 0x0800):Matrix3D {
        var p:Vector.<Number> = new Vector.<Number>(16, true);

        var vh2:Number = zn * Math.tan((fov * Math.PI) / 360);
        var vh1:Number = -vh2;
        var vw1:Number = (vh1 * scale);
        var vw2:Number = (vh2 * scale);
        var w:Number = (2 * zn) / (vw2 - vw1);
        var h:Number = (2 * zn) / (vh2 - vh1);
        var _local11:Number = (vw2 + vw1) / (vw2 - vw1);
        var _local12:Number = (vh2 + vh1) / (vh2 - vh1);
        var q:Number = -(_arg4 + zn) / (_arg4 - zn);
        var _local14:Number = (-2 * _arg4 * zn) / (_arg4 - zn);

        p[0] = w;
        p[1] = 0;
        p[2] = 0;
        p[3] = 0;

        p[4] = 0;
        p[5] = h;
        p[6] = 0;
        p[7] = 0;

        p[8] = _local11;
        p[9] = _local12;
        p[10] = q;
        p[11] = -1;

        p[12] = 0;
        p[13] = 0;
        p[14] = _local14;
        p[15] = 0;

        return new Matrix3D(p);
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
