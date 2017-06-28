package kabam.rotmg.editor.view {
import com.company.assembleegameclient.ui.StaticClickableText;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.rotmg.graphics.DeleteXGraphic;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;
import com.company.util.MoreObjectUtil;

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.net.FileReference;
import flash.text.TextFieldAutoSize;
import flash.utils.ByteArray;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.editor.model.SearchData;
import kabam.rotmg.editor.model.SearchModel;
import kabam.rotmg.editor.model.TextureData;
import kabam.rotmg.editor.view.components.PictureType;
import kabam.rotmg.editor.view.components.loaddialog.DeletePictureDialog;
import kabam.rotmg.editor.view.components.loaddialog.ResultsBoxes;
import kabam.rotmg.editor.view.components.loaddialog.SpriteSheet;
import kabam.rotmg.editor.view.components.loaddialog.TagSearchField;
import kabam.rotmg.editor.view.components.loaddialog.events.AddPictureEvent;
import kabam.rotmg.editor.view.components.loaddialog.events.DeletePictureEvent;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class LoadTextureDialog extends Sprite {

    public static const MINE:String = "Mine";
    public static const WIDTH:int = 640;
    public static const HEIGHT:int = 540;
    public static const NUM_COLS:int = 6;
    public static const NUM_ROWS:int = 4;
    public static const TYPES:Vector.<int> = new <int>[PictureType.INVALID, PictureType.CHARACTER, PictureType.ITEM, PictureType.ENVIRONMENT, PictureType.PROJECTILE, PictureType.TEXTILE, PictureType.INTERFACE, PictureType.MISCELLANEOUS];

    public const textureSelected:Signal = new Signal(TextureData);
    public const cancel:Signal = new Signal();
    public const search:Signal = new Signal(SearchData);

    public var accountDropDown_:DropDown;
    public var resultsBoxes_:ResultsBoxes;
    public var deletePictureDialog:DeletePictureDialog;
    protected var darkBox_:Shape;
    protected var box_:Sprite = new Sprite();
    protected var rect_:Shape;
    protected var titleText_:BaseSimpleText = null;
    protected var cancelButton_:DeleteXGraphic = null;
    protected var searchButton_:StaticTextButton;
    protected var prevButton_:StaticClickableText;
    protected var nextButton_:StaticClickableText;
    protected var tagSearchField_:TagSearchField;
    protected var typeDropDown_:DropDown;
    protected var spriteSheet_:SpriteSheet = null;
    protected var numBitmapsText_:StaticTextDisplay = null;
    protected var downloadButton_:StaticClickableText = null;
    protected var updateSpriteSheetText_:Sprite = null;
    private var data:String;
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var drawn_:Boolean = false;

    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

    public function LoadTextureDialog(_arg_1:SearchModel) {
        var _local_3:int;
        super();
        this.titleText_ = new BaseSimpleText(22, 5746018, false, WIDTH, 0);
        this.titleText_.setBold(true);
        this.titleText_.htmlText = '<p align="center">Load</p>';
        this.titleText_.updateMetrics();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 1)];
        this.titleText_.y = 4;
        this.box_.addChild(this.titleText_);
        this.cancelButton_ = new DeleteXGraphic();
        this.cancelButton_.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this.cancelButton_.x = ((WIDTH - this.cancelButton_.width) - 10);
        this.cancelButton_.y = 10;
        this.box_.addChild(this.cancelButton_);
        this.searchButton_ = new StaticTextButton(16, TextKey.EDITOR_SEARCH, 120);
        this.searchButton_.x = ((WIDTH - this.searchButton_.width) - 20);
        this.searchButton_.y = 40;
        this.searchButton_.addEventListener(MouseEvent.CLICK, this.onSearchClick);
        this.box_.addChild(this.searchButton_);
        this.prevButton_ = new StaticClickableText(16, true, TextKey.EDITOR_PREVIOUS);
        this.prevButton_.visible = false;
        this.prevButton_.x = 20;
        this.prevButton_.y = (HEIGHT - 50);
        this.prevButton_.addEventListener(MouseEvent.CLICK, this.onPrevClick);
        this.box_.addChild(this.prevButton_);
        this.nextButton_ = new StaticClickableText(16, true, TextKey.EDITOR_NEXT);
        this.nextButton_.text_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.nextButton_.visible = false;
        this.nextButton_.x = (WIDTH - 20);
        this.nextButton_.y = (HEIGHT - 50);
        this.nextButton_.addEventListener(MouseEvent.CLICK, this.onNextClick);
        this.box_.addChild(this.nextButton_);
        this.accountDropDown_ = new DropDown(new <String>[MINE, "All", "Wild Shadow"], 120, 30);
        this.accountDropDown_.setValue(_arg_1.searchData.scope);
        this.accountDropDown_.x = 20;
        this.accountDropDown_.y = 40;
        this.box_.addChild(this.accountDropDown_);
        var _local_2:Vector.<String> = new Vector.<String>();
        for each (_local_3 in TYPES) {
            _local_2.push(PictureType.TYPES[_local_3].name_);
        }
        this.typeDropDown_ = new DropDown(_local_2, 120, 30);
        this.typeDropDown_.x = ((this.accountDropDown_.x + this.accountDropDown_.width) + 10);
        this.typeDropDown_.y = 40;
        this.typeDropDown_.setValue(PictureType.TYPES[_arg_1.searchData.type].name_);
        this.box_.addChild(this.typeDropDown_);
        this.tagSearchField_ = new TagSearchField();
        this.tagSearchField_.x = ((this.typeDropDown_.x + this.typeDropDown_.width) + 10);
        this.tagSearchField_.y = 40;
        if (_arg_1.searchData.tags) {
            this.tagSearchField_.setText(_arg_1.searchData.tags);
        }
        this.box_.addChild(this.tagSearchField_);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    private function onCancelClick(_arg_1:MouseEvent):void {
        this.cancel.dispatch();
    }

    private function onSearchClick(_arg_1:MouseEvent):void {
        this.doSearch(0);
    }

    private function onPrevClick(_arg_1:MouseEvent):void {
        if ((((this.resultsBoxes_ == null)) || ((this.resultsBoxes_.offset_ <= 0)))) {
            return;
        }
        this.doSearch(Math.max(0, (this.resultsBoxes_.offset_ - (NUM_ROWS * NUM_COLS))));
    }

    private function onNextClick(_arg_1:MouseEvent):void {
        if ((((this.resultsBoxes_ == null)) || ((this.resultsBoxes_.num_ < (NUM_ROWS * NUM_COLS))))) {
            return;
        }
        this.doSearch((this.resultsBoxes_.offset_ + (NUM_ROWS * NUM_COLS)));
    }

    public function doSearch(_arg_1:int):void {
        this.searchButton_.setEnabled(false);
        var _local_2:SearchData = new SearchData();
        _local_2.scope = this.accountDropDown_.getValue();
        _local_2.type = PictureType.nameToType(this.typeDropDown_.getValue());
        _local_2.tags = this.tagSearchField_.getText();
        _local_2.offset = _arg_1;
        this.search.dispatch(_local_2);
    }

    public function showSearchResults(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.makeResultBoxes(_arg_2);
        }
        else {
            this.onSearchError(_arg_2);
        }
    }

    private function makeResultBoxes(_arg_1:String):void {
        this.data = _arg_1;
        if (((!((this.resultsBoxes_ == null))) && (this.box_.contains(this.resultsBoxes_)))) {
            this.box_.removeChild(this.resultsBoxes_);
        }
        var _local_2:XML = new XML(_arg_1);
        this.resultsBoxes_ = new ResultsBoxes(_local_2, NUM_COLS, NUM_ROWS);
        this.resultsBoxes_.selected.add(this.onTextureSelected);
        this.resultsBoxes_.x = 20;
        this.resultsBoxes_.y = 80;
        this.resultsBoxes_.addEventListener(DeletePictureEvent.DELETE_PICTURE_EVENT, this.onPictureDelete);
        this.resultsBoxes_.addEventListener(AddPictureEvent.ADD_PICTURE_EVENT, this.onPictureAdd);
        this.box_.addChildAt(this.resultsBoxes_, 1);
        this.searchButton_.setEnabled(true);
        this.nextButton_.visible = (this.resultsBoxes_.num_ >= (NUM_ROWS * NUM_COLS));
        this.prevButton_.visible = !((this.resultsBoxes_.offset_ == 0));
    }

    private function onSearchError(_arg_1:String):void {
    }

    private function onTextureSelected(_arg_1:TextureData):void {
        this.textureSelected.dispatch(_arg_1);
    }

    private function onPictureDelete(_arg_1:DeletePictureEvent):void {
        this.deletePictureDialog = new DeletePictureDialog(_arg_1.name_, _arg_1.id_);
        this.deletePictureDialog.addEventListener(Dialog.LEFT_BUTTON, this.onDeleteCancel);
        this.deletePictureDialog.addEventListener(Dialog.RIGHT_BUTTON, this.onDelete);
        addChild(this.deletePictureDialog);
    }

    private function onPictureAdd(_arg_1:AddPictureEvent):void {
        if (this.spriteSheet_ == null) {
            this.spriteSheet_ = new SpriteSheet();
        }
        this.spriteSheet_.addBitmapData(_arg_1.bitmapData_);
        this.updateSpriteSheetText();
    }

    private function updateSpriteSheetText():void {
        if (this.updateSpriteSheetText_ == null) {
            this.updateSpriteSheetText_ = new Sprite();
            this.numBitmapsText_ = new StaticTextDisplay();
            this.numBitmapsText_.setSize(16).setColor(0xB3B3B3);
            this.numBitmapsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 1)];
            this.numBitmapsText_.y = (HEIGHT - 50);
            this.updateSpriteSheetText_.addChild(this.numBitmapsText_);
            this.downloadButton_ = new StaticClickableText(16, true, TextKey.EDITOR_DOWNLOAD);
            this.downloadButton_.y = (HEIGHT - 50);
            this.downloadButton_.addEventListener(MouseEvent.CLICK, this.onDownloadClick);
            this.updateSpriteSheetText_.addChild(this.downloadButton_);
            this.box_.addChild(this.updateSpriteSheetText_);
        }
        this.numBitmapsText_.setStringBuilder(new StaticStringBuilder((this.spriteSheet_.bitmapDatas_.length.toString() + " bitmaps - ")));
        this.numBitmapsText_.x = ((WIDTH / 2) - ((this.numBitmapsText_.width + this.downloadButton_.width) / 2));
        this.downloadButton_.x = (this.numBitmapsText_.x + this.numBitmapsText_.width);
    }

    private function onDownloadClick(_arg_1:MouseEvent):void {
        var _local_2:ByteArray = this.spriteSheet_.generatePNG();
        var _local_3:FileReference = new FileReference();
        _local_3.save(_local_2, "spritesheet.png");
        this.box_.removeChild(this.updateSpriteSheetText_);
        this.spriteSheet_ = null;
        this.updateSpriteSheetText_ = null;
        this.numBitmapsText_ = null;
        this.downloadButton_ = null;
    }

    private function onDeleteCancel(_arg_1:Event):void {
        var _local_2:Dialog = (_arg_1.target as DeletePictureDialog);
        _local_2.parent.removeChild(_local_2);
    }

    private function onDelete(_arg_1:Event):void {
        var _local_2:Account = StaticInjectorContext.getInjector().getInstance(Account);
        var _local_3:DeletePictureDialog = (_arg_1.target as DeletePictureDialog);
        _local_3.parent.removeChild(_local_3);
        this.resultsBoxes_.visible = false;
        var _local_4:AppEngineClient = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
        _local_4.setSendEncrypted(false);
        _local_4.complete.addOnce(this.onDeleteComplete);
        _local_4.sendRequest("/picture/delete", this.getDeleteParams(_local_3, _local_2));
    }

    private function getDeleteParams(_arg_1:DeletePictureDialog, _arg_2:Account):Object {
        var _local_3:Object = {"id": _arg_1.id_.toString()};
        MoreObjectUtil.addToObject(_local_3, _arg_2.getCredentials());
        return (_local_3);
    }

    private function onDeleteComplete(_arg_1:Boolean, _arg_2:*):void {
        this.doSearch(this.resultsBoxes_.offset_);
    }

    private function draw():void {
        var _local_1:Graphics;
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
        this.rect_ = new Shape();
        _local_1 = this.rect_.graphics;
        _local_1.drawGraphicsData(this.graphicsData_);
        this.box_.addChildAt(this.rect_, 0);
        this.box_.x = ((stage.stageWidth / 2) - (this.box_.width / 2));
        this.box_.y = ((stage.stageHeight / 2) - (this.box_.height / 2));
        this.box_.filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16, 1)];
        addChild(this.box_);
        this.darkBox_ = new Shape();
        _local_1 = this.darkBox_.graphics;
        _local_1.clear();
        _local_1.beginFill(0, 0.8);
        _local_1.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
        _local_1.endFill();
        addChildAt(this.darkBox_, 0);
    }

    private function onAddedToStage(_arg_1:Event):void {
        if (!this.drawn_) {
            this.draw();
            this.drawn_ = true;
        }
    }

    public function getData():String {
        return (this.data);
    }


}
}
