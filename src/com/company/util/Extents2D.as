package com.company.util {
public class Extents2D {

    public var minX_:Number;
    public var minY_:Number;
    public var maxX_:Number;
    public var maxY_:Number;

    public function Extents2D() {
        this.clear();
    }

    public function add(_arg1:Number, _arg2:Number):void {
        if (_arg1 < this.minX_) {
            this.minX_ = _arg1;
        }
        if (_arg2 < this.minY_) {
            this.minY_ = _arg2;
        }
        if (_arg1 > this.maxX_) {
            this.maxX_ = _arg1;
        }
        if (_arg2 > this.maxY_) {
            this.maxY_ = _arg2;
        }
    }

    public function clear():void {
        this.minX_ = Number.MAX_VALUE;
        this.minY_ = Number.MAX_VALUE;
        this.maxX_ = Number.MIN_VALUE;
        this.maxY_ = Number.MIN_VALUE;
    }

    public function toString():String {
        return ((((((((("min:(" + this.minX_) + ", ") + this.minY_) + ") max:(") + this.maxX_) + ", ") + this.maxY_) + ")"));
    }


}
}
