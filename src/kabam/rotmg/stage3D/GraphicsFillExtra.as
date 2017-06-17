package kabam.rotmg.stage3D {
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsSolidFill;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

public class GraphicsFillExtra {

    private static const DEFAULT_OFFSET:Vector.<Number> = Vector.<Number>([0, 0, 0, 0]);

    private static var textureOffsets:Dictionary = new Dictionary();
    private static var textureOffsetsSize:uint = 0;
    private static var waterSinks:Dictionary = new Dictionary();
    private static var waterSinksSize:uint = 0;
    private static var colorTransforms:Dictionary = new Dictionary();
    private static var colorTransformsSize:uint = 0;
    private static var vertexBuffers:Dictionary = new Dictionary();
    private static var vertexBuffersSize:uint = 0;
    private static var softwareDraw:Dictionary = new Dictionary();
    private static var softwareDrawSize:uint = 0;
    private static var softwareDrawSolid:Dictionary = new Dictionary();
    private static var softwareDrawSolidSize:uint = 0;
    private static var lastChecked:uint = 0;


    public static function setColorTransform(_arg1:BitmapData, _arg2:ColorTransform):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (colorTransforms[_arg1] == null) {
            colorTransformsSize++;
        }
        colorTransforms[_arg1] = _arg2;
    }

    public static function getColorTransform(bmp:BitmapData):ColorTransform {
        var ct:ColorTransform;
        if (bmp in colorTransforms) {
            ct = colorTransforms[bmp];
        }
        else {
            ct = new ColorTransform();
            colorTransforms[bmp] = ct;
            colorTransformsSize++;
        }
        return ct;
    }

    public static function setOffsetUV(_arg1:GraphicsBitmapFill, _arg2:Number, _arg3:Number):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        testOffsetUV(_arg1);
        textureOffsets[_arg1][0] = _arg2;
        textureOffsets[_arg1][1] = _arg3;
    }

    public static function getOffsetUV(_arg1:GraphicsBitmapFill):Vector.<Number> {
        if (textureOffsets[_arg1] != null) {
            return (textureOffsets[_arg1]);
        }
        return (DEFAULT_OFFSET);
    }

    private static function testOffsetUV(_arg1:GraphicsBitmapFill):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (textureOffsets[_arg1] == null) {
            textureOffsetsSize++;
            textureOffsets[_arg1] = Vector.<Number>([0, 0, 0, 0]);
        }
    }

    public static function setSinkLevel(_arg1:GraphicsBitmapFill, _arg2:Number):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (waterSinks[_arg1] == null) {
            waterSinksSize++;
        }
        waterSinks[_arg1] = _arg2;
    }

    public static function getSinkLevel(_arg1:GraphicsBitmapFill):Number {
        if (((!((waterSinks[_arg1] == null))) && ((waterSinks[_arg1] is Number)))) {
            return (waterSinks[_arg1]);
        }
        return (0);
    }

    public static function setVertexBuffer(_arg1:GraphicsBitmapFill, _arg2:Vector.<Number>):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        var _local3:Context3DProxy = StaticInjectorContext.getInjector().getInstance(Context3DProxy);
        var _local4:VertexBuffer3D = _local3.GetContext3D().createVertexBuffer(4, 5);
        _local4.uploadFromVector(_arg2, 0, 4);
        _local3.GetContext3D().setVertexBufferAt(0, _local4, 0, Context3DVertexBufferFormat.FLOAT_3);
        _local3.GetContext3D().setVertexBufferAt(1, _local4, 3, Context3DVertexBufferFormat.FLOAT_2);
        if (vertexBuffers[_arg1] == null) {
            vertexBuffersSize++;
        }
        vertexBuffers[_arg1] = _local4;
    }

    public static function getVertexBuffer(_arg1:GraphicsBitmapFill):VertexBuffer3D {
        if (((!((vertexBuffers[_arg1] == null))) && ((vertexBuffers[_arg1] is VertexBuffer3D)))) {
            return (vertexBuffers[_arg1]);
        }
        return (null);
    }

    public static function clearSink(_arg1:GraphicsBitmapFill):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (waterSinks[_arg1] != null) {
            waterSinksSize--;
            delete waterSinks[_arg1];
        }
    }

    public static function setSoftwareDraw(_arg1:GraphicsBitmapFill, _arg2:Boolean):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (softwareDraw[_arg1] == null) {
            softwareDrawSize++;
        }
        softwareDraw[_arg1] = _arg2;
    }

    public static function isSoftwareDraw(_arg1:GraphicsBitmapFill):Boolean {
        if (((!((softwareDraw[_arg1] == null))) && ((softwareDraw[_arg1] is Boolean)))) {
            return (softwareDraw[_arg1]);
        }
        return (false);
    }

    public static function setSoftwareDrawSolid(_arg1:GraphicsSolidFill, _arg2:Boolean):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (softwareDrawSolid[_arg1] == null) {
            softwareDrawSolidSize++;
        }
        softwareDrawSolid[_arg1] = _arg2;
    }

    public static function isSoftwareDrawSolid(_arg1:GraphicsSolidFill):Boolean {
        if (((!((softwareDrawSolid[_arg1] == null))) && ((softwareDrawSolid[_arg1] is Boolean)))) {
            return (softwareDrawSolid[_arg1]);
        }
        return (false);
    }

    public static function dispose():void {
        textureOffsets = new Dictionary();
        waterSinks = new Dictionary();
        colorTransforms = new Dictionary();
        disposeVertexBuffers();
        softwareDraw = new Dictionary();
        softwareDrawSolid = new Dictionary();
        textureOffsetsSize = 0;
        waterSinksSize = 0;
        colorTransformsSize = 0;
        vertexBuffersSize = 0;
        softwareDrawSize = 0;
        softwareDrawSolidSize = 0;
    }

    public static function disposeVertexBuffers():void {
        var _local1:VertexBuffer3D;
        for each (_local1 in vertexBuffers) {
            _local1.dispose();
        }
        vertexBuffers = new Dictionary();
    }

    public static function manageSize():void {
        if (colorTransformsSize > 2000) {
            colorTransforms = new Dictionary();
            colorTransformsSize = 0;
        }
        if (textureOffsetsSize > 2000) {
            textureOffsets = new Dictionary();
            textureOffsetsSize = 0;
        }
        if (waterSinksSize > 2000) {
            waterSinks = new Dictionary();
            waterSinksSize = 0;
        }
        if (vertexBuffersSize > 1000) {
            disposeVertexBuffers();
            vertexBuffersSize = 0;
        }
        if (softwareDrawSize > 2000) {
            softwareDraw = new Dictionary();
            softwareDrawSize = 0;
        }
        if (softwareDrawSolidSize > 2000) {
            softwareDrawSolid = new Dictionary();
            softwareDrawSolidSize = 0;
        }
    }


}
}
