package kabam.rotmg.news.view {
import com.company.assembleegameclient.ui.Scrollbar;

import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextField;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class NewsModalPage extends Sprite {

    public static const TEXT_MARGIN:int = 22;
    public static const TEXT_MARGIN_HTML:int = 26;
    public static const TEXT_TOP_MARGIN_HTML:int = 40;
    private static const SCROLLBAR_WIDTH:int = 10;
    public static const WIDTH:int = 136;
    public static const HEIGHT:int = 310;

    protected var scrollBar_:Scrollbar;
    private var innerModalWidth:int;
    private var htmlText:TextField;

    public function NewsModalPage(_arg1:String, _arg2:String) {
        var _local4:Sprite;
        var _local5:Sprite;
        super();
        this.doubleClickEnabled = false;
        this.mouseEnabled = false;
        this.innerModalWidth = ((NewsModal.MODAL_WIDTH - 2) - (TEXT_MARGIN_HTML * 2));
        this.htmlText = new TextField();
        var _local3:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        _local3.apply(this.htmlText, 16, 15792127, false, false);
        this.htmlText.width = this.innerModalWidth;
        this.htmlText.multiline = true;
        this.htmlText.wordWrap = true;
        this.htmlText.htmlText = _arg2;
        this.htmlText.filters = [new DropShadowFilter(0, 0, 0)];
        this.htmlText.height = (this.htmlText.textHeight + 8);
        _local4 = new Sprite();
        _local4.addChild(this.htmlText);
        _local4.y = TEXT_TOP_MARGIN_HTML;
        _local4.x = TEXT_MARGIN_HTML;
        _local5 = new Sprite();
        _local5.graphics.beginFill(0xFF0000);
        _local5.graphics.drawRect(0, 0, this.innerModalWidth, HEIGHT);
        _local5.x = TEXT_MARGIN_HTML;
        _local5.y = TEXT_TOP_MARGIN_HTML;
        addChild(_local5);
        _local4.mask = _local5;
        disableMouseOnText(this.htmlText);
        addChild(_local4);
        var _local6:TextFieldDisplayConcrete = NewsModal.getText(_arg1, TEXT_MARGIN, 6, true);
        addChild(_local6);
        if (this.htmlText.height >= HEIGHT) {
            this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH, HEIGHT, 0.1, _local4);
            this.scrollBar_.x = ((NewsModal.MODAL_WIDTH - SCROLLBAR_WIDTH) - 10);
            this.scrollBar_.y = TEXT_TOP_MARGIN_HTML;
            this.scrollBar_.setIndicatorSize(HEIGHT, _local4.height);
            addChild(this.scrollBar_);
        }
        this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
    }

    private static function disableMouseOnText(_arg1:TextField):void {
        _arg1.mouseWheelEnabled = false;
    }


    protected function onScrollBarChange(_arg1:Event):void {
        this.htmlText.y = (-(this.scrollBar_.pos()) * (this.htmlText.height - HEIGHT));
    }

    private function onAddedHandler(_arg1:Event):void {
        this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        if (this.scrollBar_) {
            this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedHandler);
        if (this.scrollBar_) {
            this.scrollBar_.removeEventListener(Event.CHANGE, this.onScrollBarChange);
        }
    }


}
}
