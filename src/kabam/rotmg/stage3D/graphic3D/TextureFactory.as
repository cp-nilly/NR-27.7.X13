package kabam.rotmg.stage3D.graphic3D {
import flash.display.BitmapData;
import flash.display3D.Context3DTextureFormat;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.utils.Dictionary;

import kabam.rotmg.stage3D.proxies.Context3DProxy;
import kabam.rotmg.stage3D.proxies.TextureProxy;

public class TextureFactory {

    private static var textures:Dictionary = new Dictionary();
    private static var flippedTextures:Dictionary = new Dictionary();
    private static var count:int = 0;

    [Inject]
    public var context3D:Context3DProxy;


    public static function GetFlippedBitmapData(_arg1:BitmapData):BitmapData {
        var _local2:BitmapData;
        if ((_arg1 in flippedTextures)) {
            return (flippedTextures[_arg1]);
        }
        _local2 = flipBitmapData(_arg1, "y");
        flippedTextures[_arg1] = _local2;
        return (_local2);
    }

    private static function flipBitmapData(_arg1:BitmapData, _arg2:String = "x"):BitmapData {
        var _local4:Matrix;
        var _local3:BitmapData = new BitmapData(_arg1.width, _arg1.height, true, 0);
        if (_arg2 == "x") {
            _local4 = new Matrix(-1, 0, 0, 1, _arg1.width, 0);
        }
        else {
            _local4 = new Matrix(1, 0, 0, -1, 0, _arg1.height);
        }
        _local3.draw(_arg1, _local4, null, null, null, true);
        return (_local3);
    }

    private static function getNextPowerOf2(_arg1:int):Number {
        _arg1--;
        _arg1 = (_arg1 | (_arg1 >> 1));
        _arg1 = (_arg1 | (_arg1 >> 2));
        _arg1 = (_arg1 | (_arg1 >> 4));
        _arg1 = (_arg1 | (_arg1 >> 8));
        _arg1 = (_arg1 | (_arg1 >> 16));
        return (++_arg1);
    }

    public static function disposeTextures():void {
        var _local1:TextureProxy;
        var _local2:BitmapData;
        for each (_local1 in textures) {
            _local1.dispose();
        }
        textures = new Dictionary();
        for each (_local2 in flippedTextures) {
            _local2.dispose();
        }
        flippedTextures = new Dictionary();
        count = 0;
    }

    public static function disposeNormalTextures():void {
        var _local1:TextureProxy;
        for each (_local1 in textures) {
            _local1.dispose();
        }
        textures = new Dictionary();
    }


    public function make(_arg1:BitmapData):TextureProxy {
        var _local2:int;
        var _local3:int;
        var _local4:TextureProxy;
        var _local5:BitmapData;
        if (_arg1 == null) {
            return (null);
        }
        if ((_arg1 in textures)) {
            return (textures[_arg1]);
        }
        _local2 = getNextPowerOf2(_arg1.width);
        _local3 = getNextPowerOf2(_arg1.height);
        _local4 = this.context3D.createTexture(_local2, _local3, Context3DTextureFormat.BGRA, false);
        _local5 = new BitmapData(_local2, _local3, true, 0);
        _local5.copyPixels(_arg1, _arg1.rect, new Point(0, 0));
        _local4.uploadFromBitmapData(_local5);
        if (count > 1000) {
            disposeNormalTextures();
            count = 0;
        }
        textures[_arg1] = _local4;
        count++;
        return (_local4);
    }


}
}
