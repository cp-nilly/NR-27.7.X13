package kabam.rotmg.dailyLogin.view {
import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.mysterybox.components.MysteryBoxSelectModal;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class DailyLoginModal extends Sprite {

    private var content:Sprite;
    private var calendarView:CalendarView;
    private var titleTxt:TextFieldDisplayConcrete;
    private var serverTimeTxt:TextFieldDisplayConcrete;
    public var closeButton:DialogCloseButton;
    private var modalRectangle:Rectangle;
    private var daysLeft:int = 300;
    public var claimButton:DeprecatedTextButtonStatic;
    private var tabs:CalendarTabsView;

    public function DailyLoginModal() {
        this.calendarView = new CalendarView();
        this.closeButton = new DialogCloseButton();
        super();
    }

    public function init(_arg1:DailyLoginModel):void {
        this.daysLeft = _arg1.daysLeftToCalendarEnd;
        this.modalRectangle = CalendarSettings.getCalendarModalRectangle(_arg1.overallMaxDays, (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS));
        this.content = new Sprite();
        addChild(this.content);
        this.createModalBox();
        this.tabs = new CalendarTabsView();
        addChild(this.tabs);
        this.tabs.y = CalendarSettings.TABS_Y_POSITION;
        if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS) {
            this.tabs.y = (this.tabs.y + 20);
        }
        this.centerModal();
    }

    private function addClaimButton() {
        this.claimButton = new DeprecatedTextButtonStatic(16, "Go & Claim");
        this.claimButton.textChanged.addOnce(this.alignClaimButton);
        addChild(this.claimButton);
    }

    public function showLegend(_arg1:Boolean) {
        var _local2:Sprite;
        var _local6:Bitmap;
        var _local7:Bitmap;
        _local2 = new Sprite();
        _local2.y = (this.modalRectangle.height - 55);
        var _local3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
        _local3.setStringBuilder(new StaticStringBuilder(((_arg1) ? "- Reward ready to claim. Click on day to claim reward." : "- Reward ready to claim.")));
        var _local4:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width).setHorizontalAlign(TextFormatAlign.LEFT);
        _local4.setStringBuilder(new StaticStringBuilder("- Item claimed already."));
        _local3.x = 20;
        _local3.y = 0;
        _local4.x = 20;
        _local4.y = 20;
        var _local5:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 52);
        _local5.colorTransform(new Rectangle(0, 0, _local5.width, _local5.height), CalendarSettings.GREEN_COLOR_TRANSFORM);
        _local5 = TextureRedrawer.redraw(_local5, 40, true, 0);
        _local6 = new Bitmap(_local5);
        _local6.x = (-(Math.round((_local6.width / 2))) + 10);
        _local6.y = (-(Math.round((_local6.height / 2))) + 9);
        _local2.addChild(_local6);
        _local5 = AssetLibrary.getImageFromSet("lofiInterfaceBig", 11);
        _local5 = TextureRedrawer.redraw(_local5, 20, true, 0);
        _local7 = new Bitmap(_local5);
        _local7.x = (-(Math.round((_local7.width / 2))) + 10);
        _local7.y = (-(Math.round((_local7.height / 2))) + 30);
        _local2.addChild(_local7);
        _local2.addChild(_local3);
        _local2.addChild(_local4);
        if (!_arg1) {
            this.addClaimButton();
            _local2.x = ((CalendarSettings.DAILY_LOGIN_MODAL_PADDING + this.claimButton.width) + 10);
        }
        else {
            _local2.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
        }
        addChild(_local2);
    }

    private function alignClaimButton():void {
        this.claimButton.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
        this.claimButton.y = ((this.modalRectangle.height - this.claimButton.height) - CalendarSettings.DAILY_LOGIN_MODAL_PADDING);
        if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS) {
        }
    }

    private function createModalBox() {
        var _local1:DisplayObject = new MysteryBoxSelectModal.backgroundImageEmbed();
        this.modalRectangle.width--;
        _local1.height = (this.modalRectangle.height - 27);
        _local1.y = 27;
        _local1.alpha = 0.95;
        this.content.addChild(_local1);
        this.content.addChild(this.makeModalBackground(this.modalRectangle.width, this.modalRectangle.height));
    }

    private function makeModalBackground(_arg1:int, _arg2:int):PopupWindowBackground {
        var _local3:PopupWindowBackground = new PopupWindowBackground();
        _local3.draw(_arg1, _arg2, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        return (_local3);
    }

    public function addCloseButton():void {
        this.closeButton.y = 4;
        this.closeButton.x = ((this.modalRectangle.width - this.closeButton.width) - 5);
        addChild(this.closeButton);
    }

    public function addTitle(_arg1:String):void {
        this.titleTxt = this.getText(_arg1, 0, 6, true).setSize(18);
        this.titleTxt.setColor(0xFFDE00);
        addChild(this.titleTxt);
    }

    public function showServerTime(_arg1:String, _arg2:String):void {
        var _local3:TextFieldDisplayConcrete;
        this.serverTimeTxt = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width);
        this.serverTimeTxt.setStringBuilder(new StaticStringBuilder(((("Server time: " + _arg1) + ", ends on: ") + _arg2)));
        this.serverTimeTxt.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
        if (this.daysLeft < CalendarSettings.CLAIM_WARNING_BEFORE_DAYS) {
            _local3 = new TextFieldDisplayConcrete().setSize(14).setColor(0xFF0000).setTextWidth(this.modalRectangle.width);
            _local3.setStringBuilder(new StaticStringBuilder("Calendar will soon end, remember to claim before it ends."));
            _local3.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
            _local3.y = 40;
            this.serverTimeTxt.y = 60;
            this.calendarView.y = 90;
            addChild(_local3);
        }
        else {
            this.calendarView.y = 70;
            this.serverTimeTxt.y = 40;
        }
        addChild(this.serverTimeTxt);
    }

    public function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:Boolean = false):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(this.modalRectangle.width);
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

    private function centerModal():void {
        this.x = ((WebMain.STAGE.stageWidth / 2) - (this.width / 2));
        this.y = ((WebMain.STAGE.stageHeight / 2) - (this.height / 2));
        this.tabs.x = CalendarSettings.DAILY_LOGIN_MODAL_PADDING;
    }


}
}
