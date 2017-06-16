package com.company.util {
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

public class CachingColorTransformer {

    private static var bds_:Dictionary = new Dictionary();


    public static function transformBitmapData(tex:BitmapData, transform:ColorTransform):BitmapData {
        var ret:BitmapData;
        var keyStore:Object = bds_[tex];
        if (keyStore != null) {
            ret = keyStore[transform];
        }
        else {
            keyStore = new Object();
            bds_[tex] = keyStore;
        }

        if (ret == null) {
            ret = tex.clone();
            ret.colorTransform(ret.rect, transform);
            keyStore[transform] = ret;
        }
        return ret;
    }

    public static function filterBitmapData(tex:BitmapData, filter:BitmapFilter):BitmapData {
        var ret:BitmapData;
        var keyStore:Object = bds_[tex];
        if (keyStore != null) {
            ret = keyStore[filter];
        }
        else {
            keyStore = new Object();
            bds_[tex] = keyStore;
        }

        if (ret == null) {
            ret = tex.clone();
            ret.applyFilter(ret, ret.rect, new Point(), filter);
            keyStore[filter] = ret;
        }
        return ret;
    }

    public static function alphaBitmapData(tex:BitmapData, alpha:Number):BitmapData {
        var alphaPercent:int = int(alpha * 100);
        var transform:ColorTransform = new ColorTransform(1, 1, 1, alphaPercent / 100);
        return transformBitmapData(tex, transform);
    }

    public static function clear():void {
        for each (var keyStore:Object in bds_) {
            for each (var tex:BitmapData in keyStore) {
                tex.dispose();
            }
        }
        bds_ = new Dictionary();
    }


}
}
