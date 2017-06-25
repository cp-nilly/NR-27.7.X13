package com.company.util {
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

public class CachingColorTransformer {

    private static var bds_:Dictionary = new Dictionary();
    private static var alphas_:Dictionary = new Dictionary();


    public static function transformBitmapData(tex:BitmapData, transform:ColorTransform):BitmapData {
        var ret:BitmapData;
        var dict:Dictionary = bds_[tex];
        if (dict != null) {
            ret = dict[transform];
        }
        else {
            dict = new Dictionary();
            bds_[tex] = dict;
        }

        if (ret == null) {
            ret = tex.clone();
            ret.colorTransform(ret.rect, transform);
            dict[transform] = ret;
        }
        return ret;
    }

    public static function filterBitmapData(tex:BitmapData, filter:BitmapFilter):BitmapData {
        var ret:BitmapData;
        var dict:Dictionary = bds_[tex];
        if (dict != null) {
            ret = dict[filter];
        }
        else {
            dict = new Dictionary();
            bds_[tex] = dict;
        }

        if (ret == null) {
            ret = tex.clone();
            ret.applyFilter(ret, ret.rect, new Point(), filter);
            dict[filter] = ret;
        }
        return ret;
    }

    public static function alphaBitmapData(tex:BitmapData, alphaPercent:int):BitmapData {
        var ct:ColorTransform = alphas_[alphaPercent];
        if (ct == null) {
            ct = new ColorTransform(1, 1, 1, alphaPercent / 100);
            alphas_[alphaPercent] = ct;
        }
        return transformBitmapData(tex, ct);
    }

    public static function clear():void {
        for each (var dict:Dictionary in bds_) {
            for each (var tex:BitmapData in dict) {
                tex.dispose();
            }
        }
        bds_ = new Dictionary();
        alphas_ = new Dictionary();
    }


}
}
