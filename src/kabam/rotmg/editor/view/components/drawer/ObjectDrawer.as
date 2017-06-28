package kabam.rotmg.editor.view.components.drawer {
import com.company.color.HSV;
import com.company.color.RGB;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;

public class ObjectDrawer extends PixelDrawer {

    private static var transbackgroundEmbed_:Class = ObjectDrawer_transbackgroundEmbed_;
    private static var transbackgroundBD_:BitmapData = new transbackgroundEmbed_().bitmapData;

    private var w_:int;
    private var h_:int;
    private var pW_:int;
    private var pH_:int;
    private var allowTrans_:Boolean;
    private var pixels_:Vector.<Vector.<Pixel>>;
    private var gridLines_:Shape;

    public function ObjectDrawer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean) {
        var _local_6:int;
        var _local_7:int;
        var _local_8:Pixel;
        var _local_9:int;
        this.pixels_ = new Vector.<Vector.<Pixel>>();
        super();
        this.w_ = _arg_1;
        this.h_ = _arg_2;
        this.pW_ = _arg_3;
        this.pH_ = _arg_4;
        this.allowTrans_ = _arg_5;
        _local_9 = Math.min((this.w_ / this.pW_), (this.h_ / this.pH_));
        var _local_10:int = ((this.w_ / 2) - ((_local_9 * this.pW_) / 2));
        var _local_11:int = ((this.h_ / 2) - ((_local_9 * this.pH_) / 2));
        this.pixels_.length = this.pW_;
        _local_6 = 0;
        while (_local_6 < this.pW_) {
            if (this.pixels_[_local_6] == null) {
                this.pixels_[_local_6] = new Vector.<Pixel>();
            }
            this.pixels_[_local_6].length = this.pH_;
            _local_7 = 0;
            while (_local_7 < this.pH_) {
                _local_8 = new Pixel(_local_9, this.allowTrans_);
                this.pixels_[_local_6][_local_7] = _local_8;
                _local_8.x = (_local_10 + (_local_6 * _local_9));
                _local_8.y = (_local_11 + (_local_7 * _local_9));
                _local_8.addEventListener(MouseEvent.MOUSE_DOWN, this.onPixelMouseDown);
                _local_8.addEventListener(MouseEvent.MOUSE_OVER, this.onPixelMouseOver);
                _local_8.addEventListener(MouseEvent.MOUSE_OUT, this.onPixelMouseOut);
                addChild(_local_8);
                _local_7++;
            }
            _local_6++;
        }
        graphics.clear();
        graphics.beginBitmapFill(transbackgroundBD_, null);
        graphics.drawRect(_local_10, _local_11, (_local_9 * _arg_3), (_local_9 * _arg_4));
        graphics.endFill();
        this.gridLines_ = new Shape();
        var _local_12:Graphics = this.gridLines_.graphics;
        _local_12.lineStyle(1, 0xFFFFFF, 0.5);
        _local_6 = 0;
        while (_local_6 <= this.pW_) {
            _local_12.moveTo((_local_10 + (_local_6 * _local_9)), _local_11);
            _local_12.lineTo((_local_10 + (_local_6 * _local_9)), (_local_11 + (this.pH_ * _local_9)));
            _local_6++;
        }
        _local_7 = 0;
        while (_local_7 <= this.pH_) {
            _local_12.moveTo(_local_10, (_local_11 + (_local_7 * _local_9)));
            _local_12.lineTo((_local_10 + (this.pW_ * _local_9)), (_local_11 + (_local_7 * _local_9)));
            _local_7++;
        }
        _local_12.lineStyle();
        addChild(this.gridLines_);
    }

    override public function getBitmapData():BitmapData {
        var _local_3:int;
        var _local_4:Pixel;
        var _local_1:BitmapData = new BitmapDataSpy(this.pW_, this.pH_, true, 0);
        var _local_2:int;
        while (_local_2 < this.pixels_.length) {
            _local_3 = 0;
            while (_local_3 < this.pixels_[_local_2].length) {
                _local_4 = this.pixels_[_local_2][_local_3];
                if (((!((_local_4.hsv_ == null))) || (!(this.allowTrans_)))) {
                    _local_1.setPixel32(_local_2, _local_3, (0xFF000000 | _local_4.getColor()));
                }
                _local_3++;
            }
            _local_2++;
        }
        return (_local_1);
    }

    override public function loadBitmapData(_arg_1:BitmapData):void {
        var _local_3:int;
        var _local_4:Pixel;
        var _local_5:uint;
        var _local_6:HSV;
        var _local_2:int;
        while (_local_2 < _arg_1.width) {
            _local_3 = 0;
            while (_local_3 < _arg_1.height) {
                _local_4 = this.pixels_[_local_2][_local_3];
                _local_5 = _arg_1.getPixel32(_local_2, _local_3);
                _local_6 = null;
                if ((_local_5 & 0xFF000000) != 0) {
                    _local_6 = RGB.fromColor((_local_5 & 0xFFFFFF)).toHSV();
                }
                _local_4.setHSV(_local_6);
                _local_3++;
            }
            _local_2++;
        }
        dispatchEvent(new Event(Event.CHANGE));
    }

    public function empty():Boolean {
        var _local_1:Vector.<Pixel>;
        var _local_2:Pixel;
        for each (_local_1 in this.pixels_) {
            for each (_local_2 in _local_1) {
                if (_local_2.hsv_ != null) {
                    return (false);
                }
            }
        }
        return (true);
    }

    override public function clear():void {
        var _local_2:Vector.<Pixel>;
        var _local_3:Pixel;
        var _local_1:Vector.<PixelColor> = new Vector.<PixelColor>();
        for each (_local_2 in this.pixels_) {
            for each (_local_3 in _local_2) {
                if (_local_3.hsv_ != null) {
                    _local_1.push(new PixelColor(_local_3, null));
                }
            }
        }
        dispatchEvent(new SetPixelsEvent(_local_1));
    }

    private function onPixelMouseDown(_arg_1:MouseEvent):void {
        var _local_2:Pixel = (_arg_1.target as Pixel);
        dispatchEvent(new PixelEvent(PixelEvent.UNDO_TEMP_EVENT, _local_2));
        dispatchEvent(new PixelEvent(PixelEvent.PIXEL_EVENT, _local_2));
    }

    private function onPixelMouseOver(_arg_1:MouseEvent):void {
        var _local_2:Pixel = (_arg_1.target as Pixel);
        if (_arg_1.buttonDown) {
            dispatchEvent(new PixelEvent(PixelEvent.PIXEL_EVENT, _local_2));
        }
        else {
            dispatchEvent(new PixelEvent(PixelEvent.TEMP_PIXEL_EVENT, _local_2));
        }
    }

    private function onPixelMouseOut(_arg_1:MouseEvent):void {
        var _local_2:Pixel = (_arg_1.target as Pixel);
        dispatchEvent(new PixelEvent(PixelEvent.UNDO_TEMP_EVENT, _local_2));
    }


}
}
