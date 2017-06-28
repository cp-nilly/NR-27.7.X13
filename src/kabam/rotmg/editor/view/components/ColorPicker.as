package kabam.rotmg.editor.view.components {
import com.company.color.HSV;
import com.company.color.RGB;
import com.company.ui.BaseSimpleText;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

public class ColorPicker extends Sprite {

    private static var paletteselectEmbed_:Class = ColorPicker_paletteselectEmbed_;
    private static var hsselectEmbed_:Class = ColorPicker_hsselectEmbed_;
    private static var vselectEmbed_:Class = ColorPicker_vselectEmbed_;
    private static const PALETTE_WIDTH:int = 6;
    private static const PALETTE_HEIGHT:int = 2;
    private static const PALETTE_BOX_SIZE:int = 19;
    private static const GAP_SIZE:int = 8;
    private static const PALETTE_BOX_COLORS:Vector.<uint> = new <uint>[16245355, 0, 0xFFFFFF, 7291927, 10839330, 12461619, 3389995, 5777425, 7113244, 0x980001, 4013116, 12873770, 15436081, 8805672, 0xEE0000, 7368395, 3252978, 10735143, 16383286, 13982555, 6969880, 12566461, 2534694, 7573493];

    private var paletteBoxes_:Vector.<PaletteBox>;
    private var selected_:PaletteBox = null;
    private var paletteSelect_:Bitmap;
    private var gradientPalette_:GradientPalette;
    private var HSBD_:BitmapData;
    private var HSBox_:Sprite;
    private var HSSelect_:Bitmap;
    private var VBD_:BitmapData;
    private var VBox_:Sprite;
    private var VSelect_:Bitmap;
    private var colorText_:BaseSimpleText;
    private var dragSprite_:Sprite = null;

    public function ColorPicker() {
        var _local_1:Bitmap;
        var _local_3:int;
        var _local_4:int;
        var _local_5:RGB;
        var _local_6:PaletteBox;
        this.paletteBoxes_ = new Vector.<PaletteBox>();
        super();
        var _local_2:int = 0;
        while (_local_2 < PALETTE_WIDTH) {
            _local_3 = 0;
            while (_local_3 < PALETTE_HEIGHT) {
                _local_4 = ((_local_3 * PALETTE_WIDTH) + _local_2);
                _local_5 = RGB.fromColor(PALETTE_BOX_COLORS[_local_4]);
                _local_6 = new PaletteBox(PALETTE_BOX_SIZE, _local_5.toHSV(), false);
                _local_6.x = (_local_2 * (PALETTE_BOX_SIZE + GAP_SIZE));
                _local_6.y = (_local_3 * (PALETTE_BOX_SIZE + GAP_SIZE));
                addChild(_local_6);
                _local_6.addEventListener(MouseEvent.MOUSE_DOWN, this.onPaletteBoxDown);
                this.paletteBoxes_.push(_local_6);
                _local_3++;
            }
            _local_2++;
        }
        this.paletteSelect_ = new paletteselectEmbed_();
        addChild(this.paletteSelect_);
        this.gradientPalette_ = new GradientPalette();
        this.gradientPalette_.x = 172;
        this.gradientPalette_.y = 2;
        this.gradientPalette_.addEventListener(ColorEvent.COLOR_EVENT, this.onColorEvent);
        addChild(this.gradientPalette_);
        this.HSBD_ = new BitmapDataSpy(360, 100, false, 0xFF0000);
        _local_1 = new Bitmap(this.HSBD_);
        this.HSBox_ = new Sprite();
        this.HSBox_.addChild(_local_1);
        this.HSBox_.x = 380;
        addChild(this.HSBox_);
        this.HSBox_.addEventListener(MouseEvent.MOUSE_DOWN, this.onHSMouseDown);
        this.HSSelect_ = new hsselectEmbed_();
        this.HSBox_.addChild(this.HSSelect_);
        this.VBD_ = new BitmapDataSpy(1, 100, false, 0xFF00);
        _local_1 = new Bitmap(this.VBD_);
        _local_1.width = 20;
        this.VBox_ = new Sprite();
        this.VBox_.addChild(_local_1);
        this.VBox_.x = 750;
        addChild(this.VBox_);
        this.VBox_.addEventListener(MouseEvent.MOUSE_DOWN, this.onVMouseDown);
        this.VSelect_ = new vselectEmbed_();
        this.VSelect_.x = -3;
        this.VBox_.addChild(this.VSelect_);
        this.colorText_ = new BaseSimpleText(18, 0xFFFFFF, true, 100, 26);
        this.colorText_.text = "FFFFFF";
        this.colorText_.restrict = "0123456789aAbBcCdDeEfF";
        this.colorText_.maxChars = 6;
        this.colorText_.useTextDimensions();
        this.colorText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.colorText_.y = 60;
        this.colorText_.x = ((154 / 2) - (this.colorText_.width / 2));
        this.colorText_.addEventListener(Event.CHANGE, this.onColorChange);
        addChild(this.colorText_);
        this.setSelected(this.paletteBoxes_[0]);
    }

    public function getColor():HSV {
        return (this.selected_.hsv_);
    }

    public function setColor(_arg_1:HSV):void {
        this.setColorHSV(_arg_1.h_, _arg_1.s_, _arg_1.v_);
    }

    private function setSelected(_arg_1:PaletteBox):void {
        this.selected_ = _arg_1;
        this.paletteSelect_.x = this.selected_.x - 1;
        this.paletteSelect_.y = this.selected_.y - 1;
        this.redrawHSBD();
        this.redrawVBD();
        this.moveIndicators();
        this.updateColorText();
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function setColorHSV(_arg_1:Number, _arg_2:Number, _arg_3:Number):void {
        var _local_4:HSV = new HSV(_arg_1, _arg_2, _arg_3);
        var _local_5:Boolean = ((!((_local_4.h_ == this.selected_.hsv_.h_))) || (!((_local_4.s_ == this.selected_.hsv_.s_))));
        var _local_6:Boolean = !((_local_4.v_ == this.selected_.hsv_.v_));
        this.selected_.setColor(_local_4);
        if (_local_6) {
            this.redrawHSBD();
        }
        if (_local_5) {
            this.redrawVBD();
        }
        this.moveIndicators();
        this.updateColorText();
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function updateColorText():void {
        if (((!((stage == null))) && ((stage.focus == this.colorText_)))) {
            return;
        }
        this.colorText_.text = this.selected_.hsv_.toRGB().toString();
    }

    private function redrawHSBD():void {
        var _local_2:int;
        var _local_3:uint;
        var _local_1:int = 0;
        while (_local_1 < this.HSBD_.width) {
            _local_2 = 0;
            while (_local_2 < this.HSBD_.height) {
                _local_3 = MoreColorUtil.hsvToRgb(_local_1, ((this.HSBD_.height - _local_2) / this.HSBD_.height), this.selected_.hsv_.v_);
                this.HSBD_.setPixel(_local_1, _local_2, _local_3);
                _local_2++;
            }
            _local_1++;
        }
    }

    private function redrawVBD():void {
        var _local_2:uint;
        var _local_1:int = 0;
        while (_local_1 < this.VBD_.height) {
            _local_2 = MoreColorUtil.hsvToRgb(this.selected_.hsv_.h_, this.selected_.hsv_.s_, ((this.VBD_.height - _local_1) / this.VBD_.height));
            this.VBD_.setPixel(0, _local_1, _local_2);
            _local_1++;
        }
    }

    private function moveIndicators():void {
        this.HSSelect_.x = (this.selected_.hsv_.h_ - int((this.HSSelect_.width / 2)));
        this.HSSelect_.y = (((1 - this.selected_.hsv_.s_) * this.HSBD_.height) - int((this.HSSelect_.height / 2)));
        this.VSelect_.y = (((1 - this.selected_.hsv_.v_) * this.VBD_.height) - int((this.VSelect_.height / 2)));
    }

    private function onColorEvent(_arg_1:ColorEvent):void {
        this.setColor(_arg_1.hsv_);
    }

    private function onPaletteBoxDown(_arg_1:MouseEvent):void {
        var _local_2:PaletteBox = (_arg_1.target as PaletteBox);
        this.setSelected(_local_2);
        var _local_3:PaletteBox = new PaletteBox((PALETTE_BOX_SIZE / 2), _local_2.hsv_, true);
        _local_3.x = (-(_local_3.width) / 2);
        _local_3.y = (-(_local_3.height) / 2);
        this.dragSprite_ = new Sprite();
        this.dragSprite_.addChild(_local_3);
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onStopDrag);
        stage.addChild(this.dragSprite_);
        this.dragSprite_.startDrag(true, null);
    }

    private function onStopDrag(_arg_1:MouseEvent):void {
        this.dragSprite_.stopDrag();
        this.dragSprite_.parent.removeChild(this.dragSprite_);
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStopDrag);
        var _local_2:PaletteBox = (this.dragSprite_.dropTarget as PaletteBox);
        this.dragSprite_ = null;
        var _local_3:PaletteBox = (_arg_1.target as PaletteBox);
        if ((((_local_2 == null)) || ((_local_3 == null)))) {
            return;
        }
        _local_2.setColor(_local_3.hsv_);
    }

    private function onColorChange(_arg_1:Event):void {
        this.setColor(RGB.fromColor(uint(("0x" + this.colorText_.text))).toHSV());
    }

    private function onHSMouseDown(_arg_1:MouseEvent):void {
        this.setColorHSV(this.HSBox_.mouseX, ((this.HSBox_.height - this.HSBox_.mouseY) / 100), this.selected_.hsv_.v_);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onHSMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onHSMouseUp);
    }

    private function onHSMouseMove(_arg_1:MouseEvent):void {
        this.setColorHSV(this.HSBox_.mouseX, ((this.HSBox_.height - this.HSBox_.mouseY) / 100), this.selected_.hsv_.v_);
    }

    private function onHSMouseUp(_arg_1:MouseEvent):void {
        this.setColorHSV(this.HSBox_.mouseX, ((this.HSBox_.height - this.HSBox_.mouseY) / 100), this.selected_.hsv_.v_);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onHSMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onHSMouseUp);
    }

    private function onVMouseDown(_arg_1:MouseEvent):void {
        this.setColorHSV(this.selected_.hsv_.h_, this.selected_.hsv_.s_, ((this.VBox_.height - this.VBox_.mouseY) / 100));
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onVMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onVMouseUp);
    }

    private function onVMouseMove(_arg_1:MouseEvent):void {
        this.setColorHSV(this.selected_.hsv_.h_, this.selected_.hsv_.s_, ((this.VBox_.height - this.VBox_.mouseY) / 100));
    }

    private function onVMouseUp(_arg_1:MouseEvent):void {
        this.setColorHSV(this.selected_.hsv_.h_, this.selected_.hsv_.s_, ((this.VBox_.height - this.VBox_.mouseY) / 100));
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onVMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onVMouseUp);
    }


}
}
