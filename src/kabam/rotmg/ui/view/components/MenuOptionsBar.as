package kabam.rotmg.ui.view.components {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Sprite;
import flash.geom.Rectangle;

public class MenuOptionsBar extends Sprite {

    private static const Y_POSITION:Number = 550;
    private static const SPACING:int = 20;
    public static const CENTER:String = "CENTER";
    public static const RIGHT:String = "RIGHT";
    public static const LEFT:String = "LEFT";

    private const leftObjects:Array = [];
    private const rightObjects:Array = [];

    private var screenGraphic:ScreenGraphic;

    public function MenuOptionsBar() {
        this.makeScreenGraphic();
    }

    private function makeScreenGraphic():void {
        this.screenGraphic = new ScreenGraphic();
        addChild(this.screenGraphic);
    }

    public function addButton(_arg1:TitleMenuOption, _arg2:String):void {
        this.screenGraphic.addChild(_arg1);
        switch (_arg2) {
            case CENTER:
                this.leftObjects[0] = (this.rightObjects[0] = _arg1);
                _arg1.x = (this.screenGraphic.width / 2);
                _arg1.y = Y_POSITION;
                return;
            case LEFT:
                this.layoutToLeftOf(this.leftObjects[(this.leftObjects.length - 1)], _arg1);
                this.leftObjects.push(_arg1);
                _arg1.changed.add(this.layoutLeftButtons);
                return;
            case RIGHT:
                this.layoutToRightOf(this.rightObjects[(this.rightObjects.length - 1)], _arg1);
                this.rightObjects.push(_arg1);
                _arg1.changed.add(this.layoutRightButtons);
                return;
        }
    }

    private function layoutLeftButtons():void {
        var _local1:int = 1;
        while (_local1 < this.leftObjects.length) {
            this.layoutToLeftOf(this.leftObjects[(_local1 - 1)], this.leftObjects[_local1]);
            _local1++;
        }
    }

    private function layoutToLeftOf(_arg1:TitleMenuOption, _arg2:TitleMenuOption):void {
        var _local3:Rectangle = _arg1.getBounds(_arg1);
        var _local4:Rectangle = _arg2.getBounds(_arg2);
        _arg2.x = (((_arg1.x + _local3.left) - _local4.right) - SPACING);
        _arg2.y = Y_POSITION;
    }

    private function layoutRightButtons():void {
        var _local1:int = 1;
        while (_local1 < this.rightObjects.length) {
            this.layoutToRightOf(this.rightObjects[(_local1 - 1)], this.rightObjects[_local1]);
            _local1++;
        }
    }

    private function layoutToRightOf(_arg1:TitleMenuOption, _arg2:TitleMenuOption):void {
        var _local3:Rectangle = _arg1.getBounds(_arg1);
        var _local4:Rectangle = _arg2.getBounds(_arg2);
        _arg2.x = (((_arg1.x + _local3.right) - _local4.left) + SPACING);
        _arg2.y = Y_POSITION;
    }


}
}
