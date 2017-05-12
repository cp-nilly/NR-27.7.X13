package kabam.rotmg.news.view {
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.account.core.view.EmptyFrame;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class NewsModal extends EmptyFrame {

    public static const MODAL_WIDTH:int = 440;
    public static const MODAL_HEIGHT:int = 400;
    private static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
    private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0);
    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0xFF0000, 1, 11, 5);
    private static const filterWithGlow:Array = [DROP_SHADOW_FILTER, GLOW_FILTER];
    private static const filterNoGlow:Array = [DROP_SHADOW_FILTER];

    public static var backgroundImageEmbed:Class = NewsModal_backgroundImageEmbed;
    public static var foregroundImageEmbed:Class = NewsModal_foregroundImageEmbed;
    public static var modalWidth:int = MODAL_WIDTH;//440
    public static var modalHeight:int = MODAL_HEIGHT;//400

    private var currentPage:NewsModalPage;
    private var currentPageNum:int = -1;
    private var pageOneNav:TextField;
    private var pageTwoNav:TextField;
    private var pageThreeNav:TextField;
    private var pageFourNav:TextField;
    private var pageNavs:Vector.<TextField>;
    private var pageIndicator:TextField;
    private var fontModel:FontModel;
    private var leftNavSprite:Sprite;
    private var rightNavSprite:Sprite;
    private var newsModel:NewsModel;
    private var currentPageNumber:int = 1;
    private var triggeredOnStartup:Boolean;

    public function NewsModal(_arg1:Boolean = false) {
        this.triggeredOnStartup = _arg1;
        this.newsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
        this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        modalWidth = MODAL_WIDTH;
        modalHeight = MODAL_HEIGHT;
        super(modalWidth, modalHeight);
        this.setCloseButton(true);
        this.pageIndicator = new TextField();
        this.initNavButtons();
        this.setPage(this.currentPageNumber);
        WebMain.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownListener);
        addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        addEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
        closeButton.clicked.add(this.onCloseButtonClicked);
    }

    public static function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:Boolean):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setTextWidth(((NewsModal.modalWidth - (TEXT_MARGIN * 2)) - 10));
        _local5.setBold(true);
        if (_arg4) {
            _local5.setStringBuilder(new StaticStringBuilder(_arg1));
        }
        else {
            _local5.setStringBuilder(new LineBuilder().setParams(_arg1));
        }
        _local5.setWordWrap(true);
        _local5.setMultiLine(true);
        _local5.setAutoSize(TextFieldAutoSize.CENTER);
        _local5.setHorizontalAlign(TextFormatAlign.CENTER);
        _local5.filters = [new DropShadowFilter(0, 0, 0)];
        _local5.x = _arg2;
        _local5.y = _arg3;
        return (_local5);
    }


    public function onCloseButtonClicked() {
        var _local1:FlushPopupStartupQueueSignal = StaticInjectorContext.getInjector().getInstance(FlushPopupStartupQueueSignal);
        closeButton.clicked.remove(this.onCloseButtonClicked);
        if (this.triggeredOnStartup) {
            _local1.dispatch();
        }
    }

    private function onAdded(_arg1:Event) {
        this.newsModel.markAsRead();
        this.refreshNewsButton();
    }

    private function updateIndicator() {
        this.fontModel.apply(this.pageIndicator, 24, 0xFFFFFF, true);
        this.pageIndicator.text = ((this.currentPageNumber + " / ") + this.newsModel.numberOfNews);
        addChild(this.pageIndicator);
        this.pageIndicator.y = (modalHeight - 33);
        this.pageIndicator.x = ((modalWidth / 2) - (this.pageIndicator.textWidth / 2));
        this.pageIndicator.width = (this.pageIndicator.textWidth + 4);
    }

    private function initNavButtons():void {
        this.updateIndicator();
        this.leftNavSprite = this.makeLeftNav();
        this.rightNavSprite = this.makeRightNav();
        this.leftNavSprite.x = (((modalWidth * 4) / 11) - (this.rightNavSprite.width / 2));
        this.leftNavSprite.y = (modalHeight - 4);
        addChild(this.leftNavSprite);
        this.rightNavSprite.x = (((modalWidth * 7) / 11) - (this.rightNavSprite.width / 2));
        this.rightNavSprite.y = (modalHeight - 4);
        addChild(this.rightNavSprite);
    }

    public function onClick(_arg1:MouseEvent):void {
        switch (_arg1.currentTarget) {
            case this.rightNavSprite:
                if ((this.currentPageNumber + 1) <= this.newsModel.numberOfNews) {
                    this.setPage((this.currentPageNumber + 1));
                }
                return;
            case this.leftNavSprite:
                if ((this.currentPageNumber - 1) >= 1) {
                    this.setPage((this.currentPageNumber - 1));
                }
                return;
        }
    }

    private function destroy(_arg1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        WebMain.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDownListener);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
        this.leftNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
        this.leftNavSprite.removeEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
        this.rightNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
        this.rightNavSprite.removeEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
    }

    private function setPage(_arg1:int):void {
        this.currentPageNumber = _arg1;
        if (((this.currentPage) && (this.currentPage.parent))) {
            removeChild(this.currentPage);
        }
        this.currentPage = this.newsModel.getModalPage(_arg1);
        addChild(this.currentPage);
        this.updateIndicator();
    }

    private function refreshNewsButton():void {
        var _local1:HUDModel = StaticInjectorContext.getInjector().getInstance(HUDModel);
        if (((!((_local1 == null))) && (!((_local1.gameSprite == null))))) {
            _local1.gameSprite.refreshNewsUpdateButton();
        }
    }

    override protected function makeModalBackground():Sprite {
        var _local1:Sprite = new Sprite();
        var _local2:DisplayObject = new backgroundImageEmbed();
        _local2.width = (modalWidth + 1);
        _local2.height = (modalHeight - 25);
        _local2.y = 27;
        _local2.alpha = 0.95;
        var _local3:DisplayObject = new foregroundImageEmbed();
        _local3.width = (modalWidth + 1);
        _local3.height = (modalHeight - 67);
        _local3.y = 27;
        _local3.alpha = 1;
        var _local4:PopupWindowBackground = new PopupWindowBackground();
        _local4.draw(modalWidth, modalHeight, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        _local1.addChild(_local2);
        _local1.addChild(_local3);
        _local1.addChild(_local4);
        return (_local1);
    }

    private function keyDownListener(_arg1:KeyboardEvent):void {
        if (_arg1.keyCode == KeyCodes.RIGHT) {
            if ((this.currentPageNumber + 1) <= this.newsModel.numberOfNews) {
                this.setPage((this.currentPageNumber + 1));
            }
        }
        else {
            if (_arg1.keyCode == KeyCodes.LEFT) {
                if ((this.currentPageNumber - 1) >= 1) {
                    this.setPage((this.currentPageNumber - 1));
                }
            }
        }
    }

    private function makeLeftNav():Sprite {
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 54);
        var _local2:Bitmap = new Bitmap(_local1);
        _local2.scaleX = 4;
        _local2.scaleY = 4;
        _local2.rotation = -90;
        var _local3:Sprite = new Sprite();
        _local3.addChild(_local2);
        _local3.addEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
        _local3.addEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
        _local3.addEventListener(MouseEvent.CLICK, this.onClick);
        return (_local3);
    }

    private function makeRightNav():Sprite {
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 55);
        var _local2:Bitmap = new Bitmap(_local1);
        _local2.scaleX = 4;
        _local2.scaleY = 4;
        _local2.rotation = -90;
        var _local3:Sprite = new Sprite();
        _local3.addChild(_local2);
        _local3.addEventListener(MouseEvent.MOUSE_OVER, this.onArrowHover);
        _local3.addEventListener(MouseEvent.MOUSE_OUT, this.onArrowHoverOut);
        _local3.addEventListener(MouseEvent.CLICK, this.onClick);
        return (_local3);
    }

    private function onArrowHover(_arg1:MouseEvent):void {
        _arg1.currentTarget.transform.colorTransform = OVER_COLOR_TRANSFORM;
    }

    private function onArrowHoverOut(_arg1:MouseEvent):void {
        _arg1.currentTarget.transform.colorTransform = MoreColorUtil.identity;
    }

    override public function onCloseClick(_arg1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
    }


}
}
