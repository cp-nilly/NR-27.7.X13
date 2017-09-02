package kabam.rotmg.editor.view.components.drawer {
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.Dictionary;

public class AnimationDrawer extends PixelDrawer {

    public var frameSelector_:FrameSelector;
    public var pixelDrawerDict_:Dictionary;
    private var selected_:ObjectDrawer = null;

    public function AnimationDrawer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int) {
        var _local_5:String;
        var _local_6:ObjectDrawer;
        this.pixelDrawerDict_ = new Dictionary();
        super();
        this.frameSelector_ = new FrameSelector();
        this.frameSelector_.x = ((_arg_1 / 2) - (this.frameSelector_.width / 2));
        this.frameSelector_.y = -28;
        this.frameSelector_.addEventListener(Event.CHANGE, this.onSelectedChange);
        addChild(this.frameSelector_);
        for each (_local_5 in FrameSelector.FRAMES) {
            if (_local_5 == FrameSelector.ATTACK2) {
                _local_6 = new ObjectDrawer(_arg_1, _arg_2, (_arg_3 * 2), _arg_4, true);
            }
            else {
                _local_6 = new ObjectDrawer(_arg_1, _arg_2, _arg_3, _arg_4, true);
            }
            this.pixelDrawerDict_[_local_5] = _local_6;
        }
        this.selected_ = this.pixelDrawerDict_[this.frameSelector_.getSelected()];
        addChild(this.selected_);
    }

    override public function getBitmapData():BitmapData {
        var _local_1:BitmapData = this.pixelDrawerDict_[FrameSelector.STAND].getBitmapData();
        var _local_2:int = _local_1.width;
        var _local_3:BitmapData = new BitmapDataSpy((_local_2 * 7), _local_1.height, true, 0);
        _local_3.copyPixels(_local_1, _local_1.rect, new Point(0, 0));
        _local_1 = this.pixelDrawerDict_[FrameSelector.WALK1].getBitmapData();
        _local_3.copyPixels(_local_1, _local_1.rect, new Point(_local_2, 0));
        _local_1 = this.pixelDrawerDict_[FrameSelector.WALK2].getBitmapData();
        _local_3.copyPixels(_local_1, _local_1.rect, new Point((_local_2 * 2), 0));
        _local_1 = this.pixelDrawerDict_[FrameSelector.ATTACK1].getBitmapData();
        _local_3.copyPixels(_local_1, _local_1.rect, new Point((_local_2 * 4), 0));
        _local_1 = this.pixelDrawerDict_[FrameSelector.ATTACK2].getBitmapData();
        _local_3.copyPixels(_local_1, _local_1.rect, new Point((_local_2 * 5), 0));
        return (_local_3);
    }

    override public function loadBitmapData(_arg_1:BitmapData):void {
        var _local_2:ObjectDrawer;
        var _local_3:int;
        var _local_4:int;
        if (_arg_1.width <= 16) {
            _local_2 = this.pixelDrawerDict_[FrameSelector.STAND];
            _local_2.loadBitmapData(_arg_1);
        }
        else {
            _local_3 = (_arg_1.width / 7);
            _local_4 = _arg_1.height;
            this.pixelDrawerDict_[FrameSelector.STAND].loadBitmapData(BitmapUtil.cropToBitmapData(_arg_1, 0, 0, _local_3, _local_4));
            this.pixelDrawerDict_[FrameSelector.WALK1].loadBitmapData(BitmapUtil.cropToBitmapData(_arg_1, _local_3, 0, _local_3, _local_4));
            this.pixelDrawerDict_[FrameSelector.WALK2].loadBitmapData(BitmapUtil.cropToBitmapData(_arg_1, (_local_3 * 2), 0, _local_3, _local_4));
            this.pixelDrawerDict_[FrameSelector.ATTACK1].loadBitmapData(BitmapUtil.cropToBitmapData(_arg_1, (_local_3 * 4), 0, _local_3, _local_4));
            this.pixelDrawerDict_[FrameSelector.ATTACK2].loadBitmapData(BitmapUtil.cropToBitmapData(_arg_1, (_local_3 * 5), 0, (_local_3 * 2), _local_4));
        }
        dispatchEvent(new Event(Event.CHANGE));
    }

    override public function clear():void {
        this.selected_.clear();
    }

    private function onSelectedChange(_arg_1:Event):void {
        var _local_2:ObjectDrawer;
        if (this.selected_ != null) {
            removeChild(this.selected_);
        }
        this.selected_ = this.pixelDrawerDict_[this.frameSelector_.getSelected()];
        addChild(this.selected_);
        if (this.selected_.empty()) {
            _local_2 = this.pixelDrawerDict_[FrameSelector.STAND];
            this.selected_.loadBitmapData(_local_2.getBitmapData());
            dispatchEvent(new Event(Event.CHANGE));
        }
    }


}
}
