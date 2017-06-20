package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.display.Shader;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class TextureRedrawer {

    public static const magic:int = 12;
    public static const minSize:int = (2 * magic);//24
    private static const BORDER:int = 4;
    public static const OUTLINE_FILTER:GlowFilter = new GlowFilter(0, 0.8, 1.4, 1.4, 0xFF, BitmapFilterQuality.LOW, false, false);

    private static var cache_:Dictionary = new Dictionary();
    private static var faceCache_:Dictionary = new Dictionary();
    private static var redrawCaches:Dictionary = new Dictionary();
    public static var sharedTexture_:BitmapData = null;
    private static var textureShaderEmbed_:Class = TextureRedrawer_textureShaderEmbed_;
    private static var textureShaderData_:ByteArray = (new textureShaderEmbed_() as ByteArray);
    private static var colorTexture1:BitmapData = new BitmapDataSpy(1, 1, false);
    private static var colorTexture2:BitmapData = new BitmapDataSpy(1, 1, false);


    public static function redraw(tex:BitmapData, size:int, padBottom:Boolean, glowColor:uint, useCache:Boolean = true, sMult:Number = 5):BitmapData {
        var hash:* = getHash(size, padBottom, glowColor, sMult);
        if (useCache && isCached(tex, hash)) {
            return redrawCaches[tex][hash];
        }
        var modTex:BitmapData = resize(tex, null, size, padBottom, 0, 0, sMult);
        modTex = GlowRedrawer.outlineGlow(modTex, glowColor, 1.4, useCache);
        if (useCache) {
            cache(tex, hash, modTex);
        }
        return modTex;
    }

    private static function getHash(size:int, padBottom:Boolean, glowColor:uint, sMult:Number):* {
        var h:int = (padBottom ? (1 << 27) : 0) | (size * sMult);
        if (glowColor == 0) {
            return h;
        }
        return h.toString() + glowColor.toString();
    }

    private static function cache(tex:BitmapData, hash:*, modifiedTex:BitmapData):void {
        if (!(tex in redrawCaches)) {
            redrawCaches[tex] = {};
        }
        redrawCaches[tex][hash] = modifiedTex;
    }

    private static function isCached(tex:BitmapData, hash:*):Boolean {
        if (tex in redrawCaches) {
            if (hash in redrawCaches[tex]) {
                return true;
            }
        }
        return false;
    }

    public static function resize(tex:BitmapData, mask:BitmapData, size:int, padBottom:Boolean, op1:int, op2:int, sMult:Number = 5):BitmapData {
        if (mask != null && (op1 != 0 || op2 != 0)) {
            tex = retexture(tex, mask, op1, op2);
            size = size / 5;
        }
        var w:int = sMult * size / 100 * tex.width;
        var h:int = sMult * size / 100 * tex.height;
        var m:Matrix = new Matrix();
        m.scale(w / tex.width, h / tex.height);
        m.translate(magic, magic);
        var ret:BitmapData = new BitmapDataSpy(w + minSize, h + (padBottom ? magic : 1) + magic, true, 0);
        ret.draw(tex, m);
        return ret;
    }

    public static function redrawSolidSquare(color:uint, size:int):BitmapData {
        var colorDict:Dictionary = cache_[size];
        if (colorDict == null) {
            colorDict = new Dictionary();
            cache_[size] = colorDict;
        }
        var tex:BitmapData = colorDict[color];
        if (tex != null) {
            return tex;
        }
        tex = new BitmapDataSpy(size + 4 + 4, size + 4 + 4, true, 0);
        tex.fillRect(new Rectangle(4, 4, size, size), 0xFF000000 | color);
        tex.applyFilter(tex, tex.rect, PointUtil.ORIGIN, OUTLINE_FILTER);
        colorDict[color] = tex;
        return tex;
    }

    public static function clearCache():void {
        var tex:BitmapData;
        var dict:Dictionary;

        for each (dict in cache_) {
            for each (tex in dict) {
                tex.dispose();
            }
        }
        cache_ = new Dictionary();

        for each (dict in faceCache_) {
            for each (tex in dict) {
                tex.dispose();
            }
        }
        faceCache_ = new Dictionary();
    }

    public static function redrawFace(tex:BitmapData, shade:Number):BitmapData {
        if (shade == 1) {
            return tex;
        }
        shade = int(shade * 100);
        var dict:Dictionary = faceCache_[shade];
        if (dict == null) {
            dict = new Dictionary();
            faceCache_[shade] = dict;
        }
        var modTex:BitmapData = dict[tex];
        if (modTex != null) {
            return modTex;
        }
        modTex = tex.clone();
        shade /= 100;
        modTex.colorTransform(modTex.rect, new ColorTransform(shade, shade, shade));
        dict[tex] = modTex;
        return modTex;
    }

    private static function getTexture(op:int, bmp:BitmapData):BitmapData {
        var ret:BitmapData;
        var type = (op >> 24) & 0xFF;
        var value = op & 0xFFFFFF; // could mean color or sprite index
        switch (type) {
            case 0:
                ret = bmp;
                break;
            case 1:
                bmp.setPixel(0, 0, value);
                ret = bmp;
                break;
            case 4:
                ret = AssetLibrary.getImageFromSet("textile4x4", value);
                break;
            case 5:
                ret = AssetLibrary.getImageFromSet("textile5x5", value);
                break;
            case 9:
                ret = AssetLibrary.getImageFromSet("textile9x9", value);
                break;
            case 10:
                ret = AssetLibrary.getImageFromSet("textile10x10", value);
                break;
            case 0xFF:
                ret = sharedTexture_;
                break;
            default:
                ret = bmp;
        }
        return ret;
    }

    private static function retexture(tex:BitmapData, mask:BitmapData, op1:int, op2:int):BitmapData {
        var m:Matrix = new Matrix();
        m.scale(5, 5);
        var ret:BitmapData = new BitmapDataSpy(tex.width * 5, tex.height * 5, true, 0);
        ret.draw(tex, m);
        var c1:BitmapData = getTexture(op1, colorTexture1);
        var c2:BitmapData = getTexture(op2, colorTexture2);
        var shader:Shader = new Shader(textureShaderData_);
        shader.data.src.input = ret;
        shader.data.mask.input = mask;
        shader.data.texture1.input = c1;
        shader.data.texture2.input = c2;
        shader.data.texture1Size.value = [op1 == 0 ? 0 : c1.width];
        shader.data.texture2Size.value = [op2 == 0 ? 0 : c2.width];
        ret.applyFilter(ret, ret.rect, PointUtil.ORIGIN, new ShaderFilter(shader));
        return ret;
    }

    private static function getDrawMatrix():Matrix {
        var m:Matrix = new Matrix();
        m.scale(8, 8);
        m.translate(BORDER, BORDER);
        return m;
    }


}
}
