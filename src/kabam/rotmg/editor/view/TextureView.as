package kabam.rotmg.editor.view {
import com.adobe.images.PNGEncoder;
import com.company.assembleegameclient.editor.CommandEvent;
import com.company.assembleegameclient.editor.CommandList;
import com.company.assembleegameclient.editor.CommandQueue;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.util.IntPoint;

import flash.display.Sprite;
import flash.events.Event;
import flash.net.FileReference;

import kabam.rotmg.editor.model.TextureData;
import kabam.rotmg.editor.view.components.ColorPicker;
import kabam.rotmg.editor.view.components.ModeDropDown;
import kabam.rotmg.editor.view.components.ObjectSizeDropDown;
import kabam.rotmg.editor.view.components.PictureType;
import kabam.rotmg.editor.view.components.SizeDropDown;
import kabam.rotmg.editor.view.components.TMCommand;
import kabam.rotmg.editor.view.components.TMCommandMenu;
import kabam.rotmg.editor.view.components.TextileSizeDropDown;
import kabam.rotmg.editor.view.components.drawer.AnimationDrawer;
import kabam.rotmg.editor.view.components.drawer.ObjectDrawer;
import kabam.rotmg.editor.view.components.drawer.PixelColor;
import kabam.rotmg.editor.view.components.drawer.PixelDrawer;
import kabam.rotmg.editor.view.components.drawer.PixelEvent;
import kabam.rotmg.editor.view.components.drawer.SetPixelsEvent;
import kabam.rotmg.editor.view.components.preview.AnimationPreview;
import kabam.rotmg.editor.view.components.preview.ObjectPreview;
import kabam.rotmg.editor.view.components.preview.Preview;
import kabam.rotmg.editor.view.components.preview.TextilePreview;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;

public class TextureView extends Sprite {

    private static const MODE_DROPDOWN_X:int = 240;
    private static const MODE_DROPDOWN_Y:int = 32;

    public const loadDialog:Signal = new Signal();
    public const saveDialog:Signal = new Signal(TextureData);
    public const gotoTitle:Signal = new Signal();

    private var commandMenu_:TMCommandMenu;
    private var commandQueue_:CommandQueue;
    private var colorPicker_:ColorPicker;
    private var modeDropDown_:ModeDropDown;
    private var sizeDropDown_:SizeDropDown;
    private var pixelDrawer_:PixelDrawer;
    private var preview_:Preview;
    private var loadDialog_:LoadTextureDialog;
    private var name_:String = "";
    private var type_:int = 0;
    private var tags_:String = "";
    private var tempEvent_:PixelEvent = null;

    public function TextureView() {
        addChild(new ScreenBase());
        addChild(new AccountScreen());
        this.commandMenu_ = new TMCommandMenu();
        this.commandMenu_.x = 15;
        this.commandMenu_.y = 40;
        this.commandMenu_.addEventListener(CommandEvent.UNDO_COMMAND_EVENT, this.onUndo);
        this.commandMenu_.addEventListener(CommandEvent.REDO_COMMAND_EVENT, this.onRedo);
        this.commandMenu_.addEventListener(CommandEvent.CLEAR_COMMAND_EVENT, this.onClear);
        this.commandMenu_.addEventListener(CommandEvent.LOAD_COMMAND_EVENT, this.onLoad);
        this.commandMenu_.addEventListener(CommandEvent.SAVE_COMMAND_EVENT, this.onSave);
        this.commandMenu_.addEventListener(CommandEvent.EXPORT_COMMAND_EVENT, this.onExport);
        this.commandMenu_.addEventListener(CommandEvent.QUIT_COMMAND_EVENT, this.onQuit);
        addChild(this.commandMenu_);
        this.commandQueue_ = new CommandQueue();
        this.colorPicker_ = new ColorPicker();
        this.colorPicker_.x = 20;
        this.colorPicker_.y = 480;
        this.colorPicker_.addEventListener(Event.CHANGE, this.onColorChange);
        addChild(this.colorPicker_);
        this.modeDropDown_ = new ModeDropDown();
        this.modeDropDown_.x = MODE_DROPDOWN_X;
        this.modeDropDown_.y = MODE_DROPDOWN_Y;
        this.modeDropDown_.addEventListener(Event.CHANGE, this.onModeChange);
        addChild(this.modeDropDown_);
        this.resetSizeSelector();
        this.resetPixelDrawer();
        this.resetPreview();
    }

    protected function clearLoadedAttributes():void {
        this.name_ = "";
        this.type_ = 0;
        this.tags_ = "";
    }

    private function onColorChange(_arg_1:Event):void {
        this.commandMenu_.setCommand(TMCommandMenu.DRAW_COMMAND);
    }

    private function onSizeChange(_arg_1:Event):void {
        this.resetPixelDrawer();
    }

    private function onModeChange(_arg_1:Event):void {
        this.resetSizeSelector();
        this.resetPixelDrawer();
        this.resetPreview();
    }

    private function resetSizeSelector():void {
        if (this.sizeDropDown_ != null) {
            removeChild(this.sizeDropDown_);
        }
        var _local_1:String = this.modeDropDown_.getValue();
        switch (_local_1) {
            case ModeDropDown.OBJECTS:
            case ModeDropDown.CHARACTERS:
                this.sizeDropDown_ = new ObjectSizeDropDown();
                break;
            case ModeDropDown.TEXTILES:
                this.sizeDropDown_ = new TextileSizeDropDown();
                break;
        }
        this.sizeDropDown_.x = (MODE_DROPDOWN_X + 190);
        this.sizeDropDown_.y = MODE_DROPDOWN_Y;
        this.sizeDropDown_.addEventListener(Event.CHANGE, this.onSizeChange);
        addChild(this.sizeDropDown_);
    }

    private function resetPixelDrawer():void {
        this.clearLoadedAttributes();
        if (this.pixelDrawer_ != null) {
            removeChild(this.pixelDrawer_);
        }
        var _local_1:String = this.modeDropDown_.getValue();
        var _local_2:IntPoint = this.sizeDropDown_.getSize();
        switch (_local_1) {
            case ModeDropDown.OBJECTS:
                this.pixelDrawer_ = new ObjectDrawer(360, 360, _local_2.x_, _local_2.y_, true);
                break;
            case ModeDropDown.CHARACTERS:
                this.pixelDrawer_ = new AnimationDrawer(360, 360, _local_2.x_, _local_2.y_);
                break;
            case ModeDropDown.TEXTILES:
                this.pixelDrawer_ = new ObjectDrawer(360, 360, _local_2.x_, _local_2.y_, false);
                break;
        }
        this.pixelDrawer_.x = 110;
        this.pixelDrawer_.y = 100;
        this.pixelDrawer_.addEventListener(PixelEvent.PIXEL_EVENT, this.onPixelEvent);
        this.pixelDrawer_.addEventListener(PixelEvent.TEMP_PIXEL_EVENT, this.onTempPixelEvent);
        this.pixelDrawer_.addEventListener(PixelEvent.UNDO_TEMP_EVENT, this.onUndoPixelEvent);
        this.pixelDrawer_.addEventListener(SetPixelsEvent.SET_PIXELS_EVENT, this.onSetPixelsEvent);
        this.pixelDrawer_.addEventListener(Event.CHANGE, this.onPixelDrawerChange);
        addChild(this.pixelDrawer_);
        if (this.preview_ != null) {
            this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
        }
        this.commandQueue_.clear();
    }

    private function onPixelDrawerChange(_arg_1:Event):void {
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function resetPreview():void {
        if (this.preview_ != null) {
            removeChild(this.preview_);
        }
        var _local_1:String = this.modeDropDown_.getValue();
        switch (_local_1) {
            case ModeDropDown.OBJECTS:
                this.preview_ = new ObjectPreview(300, 360);
                break;
            case ModeDropDown.CHARACTERS:
                this.preview_ = new AnimationPreview(300, 360);
                break;
            case ModeDropDown.TEXTILES:
                this.preview_ = new TextilePreview(300, 360);
                break;
        }
        this.preview_.x = 485;
        this.preview_.y = 100;
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
        addChild(this.preview_);
    }

    private function onPixelEvent(_arg_1:PixelEvent):void {
        var _local_2:CommandList;
        switch (this.commandMenu_.getCommand()) {
            case TMCommandMenu.DRAW_COMMAND:
                if (this.colorPicker_.getColor().equals(_arg_1.pixel_.hsv_)) {
                    return;
                }
                _local_2 = new CommandList();
                _local_2.addCommand(new TMCommand(_arg_1.pixel_, _arg_1.pixel_.hsv_, this.colorPicker_.getColor()));
                this.commandQueue_.addCommandList(_local_2);
                break;
            case TMCommandMenu.ERASE_COMMAND:
                if (_arg_1.pixel_.hsv_ == null) {
                    return;
                }
                _local_2 = new CommandList();
                _local_2.addCommand(new TMCommand(_arg_1.pixel_, _arg_1.pixel_.hsv_, null));
                this.commandQueue_.addCommandList(_local_2);
                break;
            case TMCommandMenu.SAMPLE_COMMAND:
                if (_arg_1.pixel_.hsv_ == null) {
                    return;
                }
                this.colorPicker_.setColor(_arg_1.pixel_.hsv_);
                break;
        }
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function onTempPixelEvent(_arg_1:PixelEvent):void {
        switch (this.commandMenu_.getCommand()) {
            case TMCommandMenu.DRAW_COMMAND:
                if (this.colorPicker_.getColor().equals(_arg_1.pixel_.hsv_)) {
                    return;
                }
                _arg_1.pixel_.setHSV(this.colorPicker_.getColor());
                break;
            case TMCommandMenu.ERASE_COMMAND:
                if (_arg_1.pixel_.hsv_ == null) {
                    return;
                }
                _arg_1.pixel_.setHSV(null);
                break;
        }
        this.tempEvent_ = _arg_1;
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function onUndoPixelEvent(_arg_1:PixelEvent):void {
        if (this.tempEvent_ == null) {
            return;
        }
        this.tempEvent_.pixel_.setHSV(this.tempEvent_.prevHSV_);
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
        this.tempEvent_ = null;
    }

    private function onSetPixelsEvent(_arg_1:SetPixelsEvent):void {
        var _local_3:PixelColor;
        var _local_2:CommandList = new CommandList();
        for each (_local_3 in _arg_1.pixelColors_) {
            _local_2.addCommand(new TMCommand(_local_3.pixel_, _local_3.pixel_.hsv_, _local_3.hsv_));
        }
        if (_local_2.empty()) {
            return;
        }
        this.commandQueue_.addCommandList(_local_2);
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function onUndo(_arg_1:CommandEvent):void {
        this.commandQueue_.undo();
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function onRedo(_arg_1:CommandEvent):void {
        this.commandQueue_.redo();
        this.preview_.setBitmapData(this.pixelDrawer_.getBitmapData());
    }

    private function onClear(_arg_1:CommandEvent):void {
        this.pixelDrawer_.clear();
    }

    private function onLoad(_arg_1:CommandEvent):void {
        this.loadDialog.dispatch();
    }

    private function onSave(_arg_1:CommandEvent):void {
        var _local_2:TextureData = new TextureData();
        _local_2.name = this.name_;
        _local_2.type = this.type_;
        _local_2.tags = this.tags_;
        _local_2.bitmapData = this.pixelDrawer_.getBitmapData();
        switch (this.modeDropDown_.getValue()) {
            case ModeDropDown.OBJECTS:
                _local_2.types = new <int>[PictureType.INVALID, PictureType.CHARACTER, PictureType.ITEM, PictureType.ENVIRONMENT, PictureType.PROJECTILE, PictureType.INTERFACE, PictureType.MISCELLANEOUS];
                break;
            case ModeDropDown.CHARACTERS:
                _local_2.types = new <int>[PictureType.CHARACTER];
                break;
            case ModeDropDown.TEXTILES:
                _local_2.types = new <int>[PictureType.TEXTILE];
                break;
        }
        this.saveDialog.dispatch(_local_2);
    }

    private function onExport(_arg_1:CommandEvent):void {
        var _local_2:TextureData = new TextureData();
        _local_2.name = this.name_;
        _local_2.bitmapData = this.pixelDrawer_.getBitmapData();
        new FileReference().save(PNGEncoder.encode(_local_2.bitmapData), _local_2.name != null ? _local_2.name : "sprite.png");
    }

    private function onQuit(_arg_1:CommandEvent):void {
        this.gotoTitle.dispatch();
    }

    public function setTexture(_arg_1:TextureData):void {
        switch (_arg_1.type) {
            case PictureType.CHARACTER:
                this.modeDropDown_.setValue(ModeDropDown.CHARACTERS);
                break;
            case PictureType.TEXTILE:
                this.modeDropDown_.setValue(ModeDropDown.TEXTILES);
                break;
            default:
                this.modeDropDown_.setValue(ModeDropDown.OBJECTS);
        }
        var _local_2:int = _arg_1.bitmapData.width;
        if (_local_2 > 16) {
            _local_2 = (_local_2 / 7);
        }
        this.sizeDropDown_.setSize(_local_2, _arg_1.bitmapData.height);
        this.name_ = _arg_1.name;
        this.type_ = _arg_1.type;
        this.tags_ = _arg_1.tags;
        this.pixelDrawer_.loadBitmapData(_arg_1.bitmapData);
    }


}
}
