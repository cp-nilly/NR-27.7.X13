package kabam.rotmg.util.components {
import com.company.rotmg.graphics.StarGraphic;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class StarsView extends Sprite {

    private static const TOTAL:int = 5;
    private static const MARGIN:int = 4;
    private static const CORNER:int = 15;
    private static const BACKGROUND_COLOR:uint = 0x252525;
    private static const EMPTY_STAR_COLOR:uint = 0x838383;
    private static const FILLED_STAR_COLOR:uint = 0xFFFFFF;

    private const stars:Vector.<StarGraphic> = makeStars();
    private const background:Sprite = makeBackground();


    private function makeStars():Vector.<StarGraphic> {
        var _local1:Vector.<StarGraphic> = this.makeStarList();
        this.layoutStars(_local1);
        return (_local1);
    }

    private function makeStarList():Vector.<StarGraphic> {
        var _local1:Vector.<StarGraphic> = new Vector.<StarGraphic>(TOTAL, true);
        var _local2:int;
        while (_local2 < TOTAL) {
            _local1[_local2] = new StarGraphic();
            addChild(_local1[_local2]);
            _local2++;
        }
        return (_local1);
    }

    private function layoutStars(_arg1:Vector.<StarGraphic>):void {
        var _local2:int;
        while (_local2 < TOTAL) {
            _arg1[_local2].x = (MARGIN + (_arg1[0].width * _local2));
            _arg1[_local2].y = MARGIN;
            _local2++;
        }
    }

    private function makeBackground():Sprite {
        var _local1:Sprite = new Sprite();
        this.drawBackground(_local1.graphics);
        addChildAt(_local1, 0);
        return (_local1);
    }

    private function drawBackground(_arg1:Graphics):void {
        var _local2:StarGraphic = this.stars[0];
        var _local3:int = ((_local2.width * TOTAL) + (2 * MARGIN));
        var _local4:int = (_local2.height + (2 * MARGIN));
        _arg1.clear();
        _arg1.beginFill(BACKGROUND_COLOR);
        _arg1.drawRoundRect(0, 0, _local3, _local4, CORNER, CORNER);
        _arg1.endFill();
    }

    public function setStars(_arg1:int):void {
        var _local2:int;
        while (_local2 < TOTAL) {
            this.updateStar(_local2, _arg1);
            _local2++;
        }
    }

    private function updateStar(_arg1:int, _arg2:int):void {
        var _local3:StarGraphic = this.stars[_arg1];
        var _local4:ColorTransform = _local3.transform.colorTransform;
        _local4.color = (((_arg1 < _arg2)) ? FILLED_STAR_COLOR : EMPTY_STAR_COLOR);
        _local3.transform.colorTransform = _local4;
    }


}
}
