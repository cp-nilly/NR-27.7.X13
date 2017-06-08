package com.company.assembleegameclient.util {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.rotmg.graphics.StarGraphic;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class FameUtil {

    public static const STARS:Vector.<int> = new <int>[20, 150, 400, 800, 2000];
    private static const lightBlueCT:ColorTransform = new ColorTransform((138 / 0xFF), (152 / 0xFF), (222 / 0xFF));
    private static const darkBlueCT:ColorTransform = new ColorTransform((49 / 0xFF), (77 / 0xFF), (219 / 0xFF));
    private static const redCT:ColorTransform = new ColorTransform((193 / 0xFF), (39 / 0xFF), (45 / 0xFF));
    private static const orangeCT:ColorTransform = new ColorTransform((247 / 0xFF), (147 / 0xFF), (30 / 0xFF));
    private static const yellowCT:ColorTransform = new ColorTransform((0xFF / 0xFF), (0xFF / 0xFF), (0 / 0xFF));
    private static const greenCT:ColorTransform = new ColorTransform((0 / 0xFF), (0xfe / 0xFF), (0 / 0xFF));
    public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT, darkBlueCT, redCT, orangeCT, yellowCT];


    public static function maxStars():int {
        return ((ObjectLibrary.playerChars_.length * STARS.length));
    }

    public static function numStars(_arg1:int):int {
        var _local2:int;
        while ((((_local2 < STARS.length)) && ((_arg1 >= STARS[_local2])))) {
            _local2++;
        }
        return (_local2);
    }

    public static function nextStarFame(_arg1:int, _arg2:int):int {
        var _local3:int = Math.max(_arg1, _arg2);
        var _local4:int;
        while (_local4 < STARS.length) {
            if (STARS[_local4] > _local3) {
                return (STARS[_local4]);
            }
            _local4++;
        }
        return (-1);
    }

    public static function numAllTimeStars(_arg1:int, _arg2:int, _arg3:XML):int {
        var _local6:XML;
        var _local4:int;
        var _local5:int;
        for each (_local6 in _arg3.ClassStats) {
            if (_arg1 == int(_local6.@objectType)) {
                _local5 = int(_local6.BestFame);
            }
            else {
                _local4 = (_local4 + FameUtil.numStars(_local6.BestFame));
            }
        }
        _local4 = (_local4 + FameUtil.numStars(Math.max(_local5, _arg2)));
        return (_local4);
    }

    public static function numStarsToBigImage(_arg1:int, _arg2:Boolean = false):Sprite {
        var _local2:Sprite = numStarsToImage(_arg1, _arg2);
        _local2.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        _local2.scaleX = 1.4;
        _local2.scaleY = 1.4;
        return (_local2);
    }

    public static function numStarsToImage(_arg1:int, _arg2:Boolean):Sprite {
        var _local2:Sprite = new StarGraphic();
        if (_arg2){
            _local2.transform.colorTransform = greenCT;
            return (_local2);
        }
        if (_arg1 < ObjectLibrary.playerChars_.length) {
            _local2.transform.colorTransform = lightBlueCT;
        }
        if(ObjectLibrary.playerChars_.length)
        {
           _local2.transform.colorTransform = lightBlueCT;
        }
        else if(ObjectLibrary.playerChars_.length * 2)
        {
            _local2.transform.colorTransform = darkBlueCT;
        }
        else if(ObjectLibrary.playerChars_.length * 3)
        {
            _local2.transform.colorTransform = redCT;
        }
        else if(ObjectLibrary.playerChars_.length * 4)
        {
            _local2.transform.colorTransform = orangeCT;
        }
        else if(ObjectLibrary.playerChars_.length * 5)
        {
            _local2.transform.colorTransform = yellowCT;
        }
        return _local2;
    }

    public static function numStarsToIcon(_arg1:int, _arg2:Boolean):Sprite {
        var _local2:Sprite;
        var _local3:Sprite;
        _local2 = numStarsToImage(_arg1, _arg2);
        _local3 = new Sprite();
        _local3.graphics.beginFill(0, 0.4);
        var _local4:int = ((_local2.width / 2) + 2);
        var _local5:int = ((_local2.height / 2) + 2);
        _local3.graphics.drawCircle(_local4, _local5, _local4);
        _local2.x = 2;
        _local2.y = 1;
        _local3.addChild(_local2);
        _local3.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
        return (_local3);
    }

    public static function getFameIcon():BitmapData {
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
        return (TextureRedrawer.redraw(_local1, 40, true, 0));
    }


}
}
