package com.company.util {
public class Trig {

    public static const toDegrees:Number = (180 / Math.PI);//57.2957795130823
    public static const toRadians:Number = (Math.PI / 180);//0.0174532925199433

    public function Trig(_arg1:StaticEnforcer) {
    }

    public static function slerp(_arg1:Number, _arg2:Number, _arg3:Number):Number {
        var _local4:Number = Number.MAX_VALUE;
        if (_arg1 > _arg2) {
            if ((_arg1 - _arg2) > Math.PI) {
                _local4 = ((_arg1 * (1 - _arg3)) + ((_arg2 + (2 * Math.PI)) * _arg3));
            }
            else {
                _local4 = ((_arg1 * (1 - _arg3)) + (_arg2 * _arg3));
            }
        }
        else {
            if ((_arg2 - _arg1) > Math.PI) {
                _local4 = (((_arg1 + (2 * Math.PI)) * (1 - _arg3)) + (_arg2 * _arg3));
            }
            else {
                _local4 = ((_arg1 * (1 - _arg3)) + (_arg2 * _arg3));
            }
        }
        if ((((_local4 < -(Math.PI))) || ((_local4 > Math.PI)))) {
            _local4 = boundToPI(_local4);
        }
        return (_local4);
    }

    public static function angleDiff(_arg1:Number, _arg2:Number):Number {
        if (_arg1 > _arg2) {
            if ((_arg1 - _arg2) > Math.PI) {
                return (((_arg2 + (2 * Math.PI)) - _arg1));
            }
            return ((_arg1 - _arg2));
        }
        if ((_arg2 - _arg1) > Math.PI) {
            return (((_arg1 + (2 * Math.PI)) - _arg2));
        }
        return ((_arg2 - _arg1));
    }

    public static function sin(_arg1:Number):Number {
        var _local2:Number;
        if ((((_arg1 < -(Math.PI))) || ((_arg1 > Math.PI)))) {
            _arg1 = boundToPI(_arg1);
        }
        if (_arg1 < 0) {
            _local2 = ((1.27323954 * _arg1) + ((0.405284735 * _arg1) * _arg1));
            if (_local2 < 0) {
                _local2 = ((0.225 * ((_local2 * -(_local2)) - _local2)) + _local2);
            }
            else {
                _local2 = ((0.225 * ((_local2 * _local2) - _local2)) + _local2);
            }
        }
        else {
            _local2 = ((1.27323954 * _arg1) - ((0.405284735 * _arg1) * _arg1));
            if (_local2 < 0) {
                _local2 = ((0.225 * ((_local2 * -(_local2)) - _local2)) + _local2);
            }
            else {
                _local2 = ((0.225 * ((_local2 * _local2) - _local2)) + _local2);
            }
        }
        return (_local2);
    }

    public static function cos(_arg1:Number):Number {
        return (sin((_arg1 + (Math.PI / 2))));
    }

    public static function atan2(_arg1:Number, _arg2:Number):Number {
        var _local3:Number;
        if (_arg2 == 0) {
            if (_arg1 < 0) {
                return ((-(Math.PI) / 2));
            }
            if (_arg1 > 0) {
                return ((Math.PI / 2));
            }
            return (undefined);
        }
        if (_arg1 == 0) {
            if (_arg2 < 0) {
                return (Math.PI);
            }
            return (0);
        }
        if ((((_arg2 > 0)) ? _arg2 : -(_arg2)) > (((_arg1 > 0)) ? _arg1 : -(_arg1))) {
            _local3 = ((((_arg2 < 0)) ? -(Math.PI) : 0) + atan2Helper(_arg1, _arg2));
        }
        else {
            _local3 = ((((_arg1 > 0)) ? (Math.PI / 2) : (-(Math.PI) / 2)) - atan2Helper(_arg2, _arg1));
        }
        if ((((_local3 < -(Math.PI))) || ((_local3 > Math.PI)))) {
            _local3 = boundToPI(_local3);
        }
        return (_local3);
    }

    public static function atan2Helper(_arg1:Number, _arg2:Number):Number {
        var _local3:Number = (_arg1 / _arg2);
        var _local4:Number = _local3;
        var _local5:Number = _local3;
        var _local6:Number = 1;
        var _local7:int = 1;
        do
        {
            _local6 = (_local6 + 2);
            _local7 = (((_local7 > 0)) ? -1 : 1);
            _local5 = ((_local5 * _local3) * _local3);
            _local4 = (_local4 + ((_local7 * _local5) / _local6));
        } while ((((((_local5 > 0.01)) || ((_local5 < -0.01)))) && ((_local6 <= 11))));
        return (_local4);
    }

    public static function boundToPI(_arg1:Number):Number {
        var _local2:int;
        if (_arg1 < -(Math.PI)) {
            _local2 = ((int((_arg1 / -(Math.PI))) + 1) / 2);
            _arg1 = (_arg1 + ((_local2 * 2) * Math.PI));
        }
        else {
            if (_arg1 > Math.PI) {
                _local2 = ((int((_arg1 / Math.PI)) + 1) / 2);
                _arg1 = (_arg1 - ((_local2 * 2) * Math.PI));
            }
        }
        return (_arg1);
    }

    public static function boundTo180(_arg1:Number):Number {
        var _local2:int;
        if (_arg1 < -180) {
            _local2 = ((int((_arg1 / -180)) + 1) / 2);
            _arg1 = (_arg1 + (_local2 * 360));
        }
        else {
            if (_arg1 > 180) {
                _local2 = ((int((_arg1 / 180)) + 1) / 2);
                _arg1 = (_arg1 - (_local2 * 360));
            }
        }
        return (_arg1);
    }

    public static function unitTest():Boolean {
        trace("STARTING UNITTEST: Trig");
        var _local1:Boolean = ((((testFunc1(Math.sin, sin)) && (testFunc1(Math.cos, cos)))) && (testFunc2(Math.atan2, atan2)));
        if (!_local1) {
            trace("Trig Unit Test FAILED!");
        }
        trace("FINISHED UNITTEST: Trig");
        return (_local1);
    }

    public static function testFunc1(_arg1:Function, _arg2:Function):Boolean {
        var _local5:Number;
        var _local6:Number;
        var _local3:Random = new Random();
        var _local4:int;
        while (_local4 < 1000) {
            _local5 = (((_local3.nextInt() % 2000) - 1000) + _local3.nextDouble());
            _local6 = Math.abs((_arg1(_local5) - _arg2(_local5)));
            if (_local6 > 0.1) {
                return (false);
            }
            _local4++;
        }
        return (true);
    }

    public static function testFunc2(_arg1:Function, _arg2:Function):Boolean {
        var _local5:Number;
        var _local6:Number;
        var _local7:Number;
        var _local3:Random = new Random();
        var _local4:int;
        while (_local4 < 1000) {
            _local5 = (((_local3.nextInt() % 2000) - 1000) + _local3.nextDouble());
            _local6 = (((_local3.nextInt() % 2000) - 1000) + _local3.nextDouble());
            _local7 = Math.abs((_arg1(_local5, _local6) - _arg2(_local5, _local6)));
            if (_local7 > 0.1) {
                return (false);
            }
            _local4++;
        }
        return (true);
    }


}
}
class StaticEnforcer {


}

