package kabam.rotmg.stage3D.Object3D {
import flash.display3D.Context3D;
import flash.display3D.VertexBuffer3D;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class Model3D_stage3d {

    public var name:String;
    public var groups:Vector.<OBJGroup>;
    public var vertexBuffer:VertexBuffer3D;
    protected var _materials:Dictionary;
    protected var _tupleIndex:uint;
    protected var _tupleIndices:Dictionary;
    protected var _vertices:Vector.<Number>;

    public function Model3D_stage3d() {
        this.groups = new Vector.<OBJGroup>();
        this._materials = new Dictionary();
        this._vertices = new Vector.<Number>();
    }

    public function dispose():void {
        var _local1:OBJGroup;
        for each (_local1 in this.groups) {
            _local1.dispose();
        }
        this.groups.length = 0;
        if (this.vertexBuffer !== null) {
            this.vertexBuffer.dispose();
            this.vertexBuffer = null;
        }
        this._vertices.length = 0;
        this._tupleIndex = 0;
        this._tupleIndices = new Dictionary();
    }

    public function CreatBuffer(_arg1:Context3D):void {
        var _local2:OBJGroup;
        for each (_local2 in this.groups) {
            if (_local2._indices.length > 0) {
                _local2.indexBuffer = _arg1.createIndexBuffer(_local2._indices.length);
                _local2.indexBuffer.uploadFromVector(_local2._indices, 0, _local2._indices.length);
                _local2._faces = null;
            }
        }
        this.vertexBuffer = _arg1.createVertexBuffer((this._vertices.length / 8), 8);
        this.vertexBuffer.uploadFromVector(this._vertices, 0, (this._vertices.length / 8));
    }

    public function readBytes(_arg1:ByteArray):void {
        var _local2:Vector.<String>;
        var _local3:OBJGroup;
        var _local10:String;
        var _local11:Array;
        var _local12:String;
        var _local13:int;
        var _local14:int;
        this.dispose();
        var _local4 = "";
        var _local5:Vector.<Number> = new Vector.<Number>();
        var _local6:Vector.<Number> = new Vector.<Number>();
        var _local7:Vector.<Number> = new Vector.<Number>();
        _arg1.position = 0;
        var _local8:String = _arg1.readUTFBytes(_arg1.bytesAvailable);
        var _local9:Array = _local8.split(/[\r\n]+/);
        for each (_local10 in _local9) {
            _local10 = _local10.replace(/^\s*|\s*$/g, "");
            if (!(((_local10 == "")) || ((_local10.charAt(0) === "#")))) {
                _local11 = _local10.split(/\s+/);
                switch (_local11[0].toLowerCase()) {
                    case "v":
                        _local5.push(parseFloat(_local11[1]), parseFloat(_local11[2]), parseFloat(_local11[3]));
                        break;
                    case "vn":
                        _local6.push(parseFloat(_local11[1]), parseFloat(_local11[2]), parseFloat(_local11[3]));
                        break;
                    case "vt":
                        _local7.push(parseFloat(_local11[1]), (1 - parseFloat(_local11[2])));
                        break;
                    case "f":
                        _local2 = new Vector.<String>();
                        for each (_local12 in _local11.slice(1)) {
                            _local2.push(_local12);
                        }
                        if (_local3 === null) {
                            _local3 = new OBJGroup(null, _local4);
                            this.groups.push(_local3);
                        }
                        _local3._faces.push(_local2);
                        break;
                    case "g":
                        _local3 = new OBJGroup(_local11[1], _local4);
                        this.groups.push(_local3);
                        break;
                    case "o":
                        this.name = _local11[1];
                        break;
                    case "mtllib":
                        break;
                    case "usemtl":
                        _local4 = _local11[1];
                        if (_local3 !== null) {
                            _local3.materialName = _local4;
                        }
                        break;
                }
            }
        }
        for each (_local3 in this.groups) {
            _local3._indices.length = 0;
            for each (_local2 in _local3._faces) {
                _local13 = (_local2.length - 1);
                _local14 = 1;
                while (_local14 < _local13) {
                    _local3._indices.push(this.mergeTuple(_local2[_local14], _local5, _local6, _local7));
                    _local3._indices.push(this.mergeTuple(_local2[0], _local5, _local6, _local7));
                    _local3._indices.push(this.mergeTuple(_local2[(_local14 + 1)], _local5, _local6, _local7));
                    _local14++;
                }
            }
            _local3._faces = null;
        }
        this._tupleIndex = 0;
        this._tupleIndices = null;
    }

    protected function mergeTuple(_arg1:String, _arg2:Vector.<Number>, _arg3:Vector.<Number>, _arg4:Vector.<Number>):uint {
        var _local5:Array;
        var _local6:uint;
        if (this._tupleIndices[_arg1] !== undefined) {
            return (this._tupleIndices[_arg1]);
        }
        _local5 = _arg1.split("/");
        _local6 = (parseInt(_local5[0], 10) - 1);
        this._vertices.push(_arg2[((_local6 * 3) + 0)], _arg2[((_local6 * 3) + 1)], _arg2[((_local6 * 3) + 2)]);
        if ((((_local5.length > 2)) && ((_local5[2].length > 0)))) {
            _local6 = (parseInt(_local5[2], 10) - 1);
            this._vertices.push(_arg3[((_local6 * 3) + 0)], _arg3[((_local6 * 3) + 1)], _arg3[((_local6 * 3) + 2)]);
        }
        else {
            this._vertices.push(0, 0, 0);
        }
        if ((((_local5.length > 1)) && ((_local5[1].length > 0)))) {
            _local6 = (parseInt(_local5[1], 10) - 1);
            this._vertices.push(_arg4[((_local6 * 2) + 0)], _arg4[((_local6 * 2) + 1)]);
        }
        else {
            this._vertices.push(0, 0);
        }
        return ((this._tupleIndices[_arg1] = this._tupleIndex++));
    }


}
}
