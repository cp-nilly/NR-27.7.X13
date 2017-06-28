package kabam.rotmg.editor.view.components.loaddialog {
import com.company.assembleegameclient.ui.tooltip.EditorTextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.rotmg.graphics.DeleteXGraphic;
import com.company.ui.BaseSimpleText;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.system.System;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import ion.utils.png.PNGDecoder;

import kabam.rotmg.editor.view.components.PictureType;
import kabam.rotmg.editor.view.components.loaddialog.events.AddPictureEvent;
import kabam.rotmg.editor.view.components.loaddialog.events.DeletePictureEvent;

public class ResultsBox extends Sprite {

    private static var addIconEmbed_:Class = ResultsBox_addIconEmbed_;
    private static var copyIconEmbed_:Class = ResultsBox_copyIconEmbed_;
    public static const WIDTH:int = 100;
    public static const HEIGHT:int = 100;
    private static var toolTip_:ToolTip = null;

    public var id_:String;
    public var name_:String;
    public var pictureType_:int = 0;
    public var tags_:String;
    public var mine_:Boolean;
    public var admin_:Boolean;
    public var bitmapData_:BitmapData = null;
    public var animatedChar_:AnimatedChar = null;
    protected var bitmap_:Bitmap;
    protected var nameText_:BaseSimpleText;
    protected var addIcon_:Sprite;
    protected var copyIcon_:Sprite;
    protected var deleteX_:DeleteXGraphic;

    public function ResultsBox(_arg_1:XML, _arg_2:Boolean) {
        this.id_ = String(_arg_1.@id);
        this.name_ = _arg_1.PicName;
        this.pictureType_ = int(_arg_1.DataType);
        this.tags_ = _arg_1.Tags;
        this.mine_ = _arg_1.hasOwnProperty("Mine");
        this.admin_ = _arg_2;
        this.bitmap_ = new Bitmap();
        addChild(this.bitmap_);
        this.nameText_ = new BaseSimpleText(12, 0xB3B3B3, false, 98, 20);
        this.nameText_.htmlText = (('<p align="center">' + this.name_) + "</p>");
        this.nameText_.wordWrap = true;
        this.nameText_.multiline = true;
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.nameText_.x = ((WIDTH / 2) - (this.nameText_.width / 2));
        this.nameText_.y = 80;
        addChild(this.nameText_);
        this.addIcon_ = new Sprite();
        this.addIcon_.addChild(new addIconEmbed_());
        this.addIcon_.x = 5;
        this.addIcon_.y = 5;
        this.addIcon_.visible = false;
        this.addIcon_.addEventListener(MouseEvent.CLICK, this.onAddClick);
        addChild(this.addIcon_);
        this.copyIcon_ = new Sprite();
        this.copyIcon_.addChild(new copyIconEmbed_());
        this.copyIcon_.x = (10 + this.addIcon_.width);
        this.copyIcon_.y = 5;
        this.copyIcon_.visible = false;
        this.copyIcon_.addEventListener(MouseEvent.CLICK, this.onCopyClick);
        addChild(this.copyIcon_);
        this.deleteX_ = new DeleteXGraphic();
        this.deleteX_.x = ((WIDTH - this.deleteX_.width) - 5);
        this.deleteX_.y = 5;
        this.deleteX_.visible = false;
        this.deleteX_.addEventListener(MouseEvent.CLICK, this.onDeleteClick);
        addChild(this.deleteX_);
        this.drawBackground(0x363636);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function onDeleteClick(_arg_1:MouseEvent):void {
        _arg_1.stopImmediatePropagation();
        dispatchEvent(new DeletePictureEvent(this.name_, this.id_));
    }

    private function onAddClick(_arg_1:MouseEvent):void {
        _arg_1.stopImmediatePropagation();
        dispatchEvent(new AddPictureEvent(this.bitmapData_));
    }

    private function onCopyClick(_arg_1:MouseEvent):void {
        _arg_1.stopImmediatePropagation();
        System.setClipboard(this.id_);
    }

    public function makeBitmapData(_arg_1:ByteArray):void {
        this.bitmapData_ = PNGDecoder.decodeImage(_arg_1);
        switch (this.pictureType_) {
            case PictureType.CHARACTER:
                if (this.bitmapData_.width > 16) {
                    this.showAnimation();
                }
                else {
                    this.showOther();
                }
                return;
            case PictureType.TEXTILE:
                this.showTextile();
                return;
            default:
                this.showOther();
        }
    }

    private function showAnimation():void {
        var _local_1:int = (this.bitmapData_.width / 7);
        var _local_2:int = this.bitmapData_.height;
        this.animatedChar_ = new AnimatedChar(new MaskedImage(this.bitmapData_, null), _local_1, _local_2, AnimatedChar.RIGHT);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        this.updateAnimation();
    }

    private function onEnterFrame(_arg_1:Event):void {
        this.updateAnimation();
    }

    private function updateAnimation():void {
        var _local_1:int = getTimer();
        var _local_2:int = ((_local_1 / 400) % AnimatedChar.NUM_ACTION);
        var _local_3:Number = ((_local_1 % 400) / 400);
        var _local_4:MaskedImage = this.animatedChar_.imageFromDir(AnimatedChar.RIGHT, _local_2, _local_3);
        this.bitmap_.bitmapData = TextureRedrawer.redraw(_local_4.image_, 100, true, 0, true);
        this.bitmap_.x = ((WIDTH / 2) - (this.bitmap_.width / 2));
        this.bitmap_.y = (((HEIGHT / 2) - (this.bitmap_.height / 2)) - 10);
    }

    private function showTextile():void {
        var _local_1:AnimatedChar = AnimatedChars.getAnimatedChar("players", 0);
        var _local_2:MaskedImage = _local_1.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
        TextureRedrawer.sharedTexture_ = this.bitmapData_;
        var _local_3:BitmapData = TextureRedrawer.resize(_local_2.image_, _local_2.mask_, 100, true, 0xFFFFFFFF, 0);
        _local_3 = GlowRedrawer.outlineGlow(_local_3, 0, 1.4, false);
        this.bitmap_.bitmapData = _local_3;
        this.bitmap_.x = ((WIDTH / 2) - (this.bitmap_.width / 2));
        this.bitmap_.y = (((HEIGHT / 2) - (this.bitmap_.height / 2)) - 10);
    }

    private function showOther():void {
        this.bitmap_.bitmapData = TextureRedrawer.redraw(this.bitmapData_, 100, true, 0, false);
        this.bitmap_.x = ((WIDTH / 2) - (this.bitmap_.width / 2));
        this.bitmap_.y = (((HEIGHT / 2) - (this.bitmap_.height / 2)) - 10);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.drawBackground(0x565656);
        this.addToolTip();
        if (((this.mine_) || (this.admin_))) {
            this.deleteX_.visible = true;
        }
        if (this.admin_) {
            this.addIcon_.visible = true;
            this.copyIcon_.visible = true;
        }
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.drawBackground(0x363636);
        this.removeToolTip();
        this.deleteX_.visible = false;
        this.addIcon_.visible = false;
        this.copyIcon_.visible = false;
    }

    private function addToolTip():void {
        this.removeToolTip();
        if (this.bitmapData_ == null) {
            return;
        }
        var _local_1:String = this.tags_.split(",").join(", ");
        var _local_2:String = (((((((((((("Type: " + PictureType.TYPES[this.pictureType_].name_) + "\n") + "Size: ") + this.bitmapData_.width) + " x ") + this.bitmapData_.height) + "\n") + "Tags: ") + _local_1) + "\n") + "Id: ") + this.id_);
        toolTip_ = new EditorTextToolTip(0x363636, 0x9B9B9B, this.name_, _local_2, 200);
        stage.addChild(toolTip_);
    }

    private function removeToolTip():void {
        if (((!((toolTip_ == null))) && (!((toolTip_.parent == null))))) {
            toolTip_.parent.removeChild(toolTip_);
        }
        toolTip_ = null;
    }

    private function drawBackground(_arg_1:uint):void {
        graphics.clear();
        graphics.beginFill(_arg_1, 1);
        graphics.drawRect(1, 1, (WIDTH - 2), (HEIGHT - 2));
        graphics.endFill();
    }


}
}
