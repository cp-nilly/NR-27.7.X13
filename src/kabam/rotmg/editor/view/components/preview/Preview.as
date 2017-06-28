package kabam.rotmg.editor.view.components.preview {
import com.company.ui.BaseSimpleText;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;

public class Preview extends Sprite {

    private static var zoominiconEmbed_:Class = Preview_zoominiconEmbed_;
    private static var zoomouticonEmbed_:Class = Preview_zoomouticonEmbed_;
    private static const MAX_ZOOM:int = 300;
    private static const MIN_ZOOM:int = 40;
    protected static const GREY_MATRIX:Array = MoreColorUtil.singleColorFilterMatrix(0x4F4F4F);

    protected var w_:int;
    protected var h_:int;
    protected var size_:int;
    protected var origBitmapData_:BitmapData;
    private var sizeText_:BaseSimpleText;
    private var zoomInIcon_:Sprite;
    private var zoomOutIcon_:Sprite;
    protected var bitmap_:Bitmap;

    public function Preview(_arg_1:int, _arg_2:int) {
        this.w_ = _arg_1;
        this.h_ = _arg_2;
        this.size_ = 100;
        graphics.lineStyle(1, 0xFFFFFF);
        graphics.beginFill(0x7F7F7F, 1);
        graphics.drawRect(0, 0, this.w_, this.h_);
        graphics.lineStyle();
        graphics.endFill();
        this.bitmap_ = new Bitmap();
        addChild(this.bitmap_);
        this.sizeText_ = new BaseSimpleText(16, 0xFFFFFF, false, 0, 0);
        this.sizeText_.setBold(true);
        this.sizeText_.text = (this.size_ + "%");
        this.sizeText_.updateMetrics();
        this.sizeText_.x = 2;
        addChild(this.sizeText_);
        this.zoomInIcon_ = this.createIcon(new zoominiconEmbed_(), this.onZoomIn);
        this.zoomInIcon_.x = ((this.w_ - this.zoomInIcon_.width) - 5);
        this.zoomInIcon_.y = 5;
        this.zoomOutIcon_ = this.createIcon(new zoomouticonEmbed_(), this.onZoomOut);
        this.zoomOutIcon_.x = ((this.zoomInIcon_.x - this.zoomOutIcon_.width) - 5);
        this.zoomOutIcon_.y = 5;
    }

    protected function createIcon(_arg_1:Bitmap, _arg_2:Function):Sprite {
        var _local_3:Sprite = new Sprite();
        _local_3.addChild(_arg_1);
        var _local_4:IconCallback = new IconCallback(this, _arg_2);
        _local_3.addEventListener(MouseEvent.MOUSE_DOWN, _local_4.handler);
        addChild(_local_3);
        return (_local_3);
    }

    public function setBitmapData(_arg_1:BitmapData):void {
        this.origBitmapData_ = _arg_1;
        this.redraw();
        this.position();
    }

    private function onZoomIn():void {
        if (this.size_ == MAX_ZOOM) {
            return;
        }
        this.size_ = (this.size_ + 20);
    }

    private function onZoomOut():void {
        if (this.size_ == MIN_ZOOM) {
            return;
        }
        this.size_ = (this.size_ - 20);
    }

    public function redraw():void {
        this.sizeText_.text = (this.size_ + "%");
        this.sizeText_.updateMetrics();
        this.zoomInIcon_.filters = (((this.size_) == MAX_ZOOM) ? [new ColorMatrixFilter(GREY_MATRIX)] : []);
        this.zoomOutIcon_.filters = (((this.size_) == MIN_ZOOM) ? [new ColorMatrixFilter(GREY_MATRIX)] : []);
    }

    public function position():void {
        this.bitmap_.x = ((this.w_ / 2) - (this.bitmap_.width / 2));
        this.bitmap_.y = ((this.h_ / 2) - (this.bitmap_.height / 2));
    }


}
}

import flash.events.Event;

import kabam.rotmg.editor.view.components.preview.Preview;

class IconCallback {

    public var preview_:Preview;
    public var callback_:Function;

    public function IconCallback(_arg_1:Preview, _arg_2:Function):void {
        this.preview_ = _arg_1;
        this.callback_ = _arg_2;
    }

    public function handler(_arg_1:Event):void {
        this.callback_();
        this.preview_.redraw();
        this.preview_.position();
    }


}
