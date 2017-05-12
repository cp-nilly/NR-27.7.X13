package com.company.assembleegameclient.ui.menu {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class MenuOption extends Sprite {

    protected static const mouseOverCT:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));

    protected var origIconBitmapData_:BitmapData;
    protected var iconBitmapData_:BitmapData;
    protected var icon_:Bitmap;
    protected var text_:TextFieldDisplayConcrete;
    protected var ct_:ColorTransform = null;

    public function MenuOption(_arg1:BitmapData, _arg2:uint, _arg3:String) {
        this.origIconBitmapData_ = _arg1;
        this.iconBitmapData_ = TextureRedrawer.redraw(_arg1, this.redrawSize(), true, 0);
        this.icon_ = new Bitmap(this.iconBitmapData_);
        this.icon_.filters = [new DropShadowFilter(0, 0, 0)];
        this.icon_.x = -12;
        this.icon_.y = -15;
        addChild(this.icon_);
        this.text_ = new TextFieldDisplayConcrete().setSize(18).setColor(_arg2);
        this.text_.setBold(true);
        this.text_.setStringBuilder(new LineBuilder().setParams(_arg3));
        this.text_.filters = [new DropShadowFilter(0, 0, 0)];
        this.text_.x = 20;
        this.text_.y = -6;
        addChild(this.text_);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    public function setColorTransform(_arg1:ColorTransform):void {
        var _local2:BitmapData;
        if (_arg1 == this.ct_) {
            return;
        }
        this.ct_ = _arg1;
        if (this.ct_ == null) {
            this.icon_.bitmapData = this.iconBitmapData_;
            this.text_.transform.colorTransform = MoreColorUtil.identity;
        }
        else {
            _local2 = CachingColorTransformer.transformBitmapData(this.origIconBitmapData_, this.ct_);
            _local2 = TextureRedrawer.redraw(_local2, this.redrawSize(), true, 0);
            this.icon_.bitmapData = _local2;
            this.text_.transform.colorTransform = this.ct_;
        }
    }

    protected function onMouseOver(_arg1:MouseEvent):void {
        this.setColorTransform(mouseOverCT);
    }

    protected function onMouseOut(_arg1:MouseEvent):void {
        this.setColorTransform(null);
    }

    protected function redrawSize():int {
        return ((40 / (this.origIconBitmapData_.width / 8)));
    }


}
}
