package kabam.rotmg.assets.emotes {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.GlowFilter;
import flash.geom.Matrix;

import starling.display.Sprite;
import starling.display.DisplayObject;

public class Emote extends Sprite {

    private var _name:String;
    private var _bmData:BitmapData;
    private var _scale:Number;
    private var _hq:Boolean;

    public function Emote(name:String, bmData:BitmapData, scale:Number, hq:Boolean) {
        _name = name;
        _bmData = bmData;
        _scale = scale;
        _hq = hq;

        var bdata:BitmapData = bmData;

        var matrix:Matrix = new Matrix();
        matrix.scale(scale, scale);

        var resBd:BitmapData = new BitmapData(Math.floor(bdata.width * scale), Math.floor(bdata.height * scale), true, 0x000000);
        resBd.draw(bdata, matrix, null, null, null, hq);

        var shape:Shape = new Shape();
        shape.graphics.beginBitmapFill(bdata, matrix, false, true);
        shape.graphics.lineStyle(0, 0, 0);
        shape.graphics.drawRect(0, 0, resBd.width, resBd.height);
        shape.graphics.endFill();
        resBd.draw(shape);

        var bm:Bitmap = new Bitmap(resBd);
        bm.filters = !hq ? [new GlowFilter(0x000000, 1, 6, 6, 4)] : [];
        bm.y = -2;

        addChild(starling.display.DisplayObject(bm));
    }

    public function clone():Emote {
        return new Emote(_name, _bmData, _scale, _hq);
    }
}
}
