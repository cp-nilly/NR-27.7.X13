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
    private static const greenCT:ColorTransform = new ColorTransform((0 / 0xFF), (0xFF / 0xFF), (0 / 0xFF));
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

    public static function numStarsToBigImage(numStars:int, isAdmin:Boolean = false):Sprite {
        var starGfx:Sprite = numStarsToImage(numStars, isAdmin);
        starGfx.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        starGfx.scaleX = 1.4;
        starGfx.scaleY = 1.4;
        return starGfx;
    }

    public static function numStarsToImage(numStars:int, isAdmin:Boolean):Sprite {
        var starGfx:Sprite = new StarGraphic();

        if (isAdmin) {
            starGfx.transform.colorTransform = greenCT;
            return starGfx;
        }

        if (numStars < ObjectLibrary.playerChars_.length) {
            starGfx.transform.colorTransform = lightBlueCT;
        }
        else if (numStars < ObjectLibrary.playerChars_.length * 2) {
            starGfx.transform.colorTransform = darkBlueCT;
        }
        else if (numStars < ObjectLibrary.playerChars_.length * 3) {
            starGfx.transform.colorTransform = redCT;
        }
        else if (numStars < ObjectLibrary.playerChars_.length * 4) {
            starGfx.transform.colorTransform = orangeCT;
        }
        else if (numStars < ObjectLibrary.playerChars_.length * 5) {
            starGfx.transform.colorTransform = yellowCT;
        }
        return starGfx;
    }

    public static function numStarsToIcon(numStars:int, isAdmin:Boolean):Sprite {
        var starGfx:Sprite;
        var icon:Sprite;
        starGfx = numStarsToImage(numStars, isAdmin);
        icon = new Sprite();
        icon.graphics.beginFill(0, 0.4);
        var x:int = starGfx.width / 2 + 2;
        var y:int = starGfx.height / 2 + 2;
        icon.graphics.drawCircle(x, y, x);
        starGfx.x = 2;
        starGfx.y = 1;
        icon.addChild(starGfx);
        icon.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
        return icon;
    }

    public static function getFameIcon():BitmapData {
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
        return (TextureRedrawer.redraw(_local1, 40, true, 0));
    }


}
}
