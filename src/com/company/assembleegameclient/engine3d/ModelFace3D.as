package com.company.assembleegameclient.engine3d {
public class ModelFace3D {

    public var model_:Model3D;
    public var indicies_:Vector.<int>;
    public var useTexture_:Boolean;

    public function ModelFace3D(_arg1:Model3D, _arg2:Vector.<int>, _arg3:Boolean) {
        this.model_ = _arg1;
        this.indicies_ = _arg2;
        this.useTexture_ = _arg3;
    }

    public static function compare(_arg1:ModelFace3D, _arg2:ModelFace3D):Number {
        var _local3:Number;
        var _local4:int;
        var _local5:Number = Number.MAX_VALUE;
        var _local6:Number = Number.MIN_VALUE;
        _local4 = 0;
        while (_local4 < _arg1.indicies_.length) {
            _local3 = _arg2.model_.vL_[((_arg1.indicies_[_local4] * 3) + 2)];
            _local5 = (((_local3 < _local5)) ? _local3 : _local5);
            _local6 = (((_local3 > _local6)) ? _local3 : _local6);
            _local4++;
        }
        var _local7:Number = Number.MAX_VALUE;
        var _local8:Number = Number.MIN_VALUE;
        _local4 = 0;
        while (_local4 < _arg2.indicies_.length) {
            _local3 = _arg2.model_.vL_[((_arg2.indicies_[_local4] * 3) + 2)];
            _local7 = (((_local3 < _local7)) ? _local3 : _local7);
            _local8 = (((_local3 > _local8)) ? _local3 : _local8);
            _local4++;
        }
        if (_local7 > _local5) {
            return (-1);
        }
        if (_local7 < _local5) {
            return (1);
        }
        if (_local8 > _local6) {
            return (-1);
        }
        if (_local8 < _local6) {
            return (1);
        }
        return (0);
    }


}
}
