package com.company.assembleegameclient.account.ui.components {
import flash.display.Shape;

public class BackgroundBox extends Shape {

    private var _width:int;
    private var _height:int;
    private var _color:int;


    public function setSize(_arg1:int, _arg2:int):void {
        this._width = _arg1;
        this._height = _arg2;
        this.drawFill();
    }

    public function setColor(_arg1:int):void {
        this._color = _arg1;
        this.drawFill();
    }

    private function drawFill():void {
        graphics.clear();
        graphics.beginFill(this._color);
        graphics.drawRect(0, 0, this._width, this._height);
        graphics.endFill();
    }


}
}
