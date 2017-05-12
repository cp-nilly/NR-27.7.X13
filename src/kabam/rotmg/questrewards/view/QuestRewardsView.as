package kabam.rotmg.questrewards.view {
import com.company.assembleegameclient.map.ParticleModalMap;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.Currency;
import com.gskinner.motion.GTween;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import kabam.display.Loader.LoaderProxy;
import kabam.display.Loader.LoaderProxyConcrete;
import kabam.rotmg.account.core.view.EmptyFrame;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;

public class QuestRewardsView extends EmptyFrame {

    public static const closed:Signal = new Signal();
    public static const MODAL_WIDTH:int = 600;
    public static const MODAL_HEIGHT:int = 600;

    public static var backgroundImageEmbed:Class = QuestRewardsView_backgroundImageEmbed;
    public static var questCompleteBanner:Class = QuestRewardsView_questCompleteBanner;
    public static var dailyQuestBanner:Class = QuestRewardsView_dailyQuestBanner;
    public static var rewardgranted:Class = QuestRewardsView_rewardgranted;

    private var rightSlot:ModalItemSlot;
    private var prevSlot:ModalItemSlot;
    private var nextSlot:ModalItemSlot;
    public var exchangeButton:LegacyBuyButton;
    private var infoImageLoader:LoaderProxy;
    private var infoImage:DisplayObject;
    private var leftCenter:int = -1;
    private var dqbanner:DisplayObject;

    public function QuestRewardsView():void {
        this.exchangeButton = new LegacyBuyButton("Turn in!", 36, 0, Currency.INVALID, true);
        this.infoImageLoader = new LoaderProxyConcrete();
        super(MODAL_WIDTH, MODAL_HEIGHT);
        this.rightSlot = new ModalItemSlot(true, true);
        this.rightSlot.hideOuterSlot(false);
        this.prevSlot = new ModalItemSlot();
        this.prevSlot.hideOuterSlot(true);
        this.nextSlot = new ModalItemSlot();
        this.nextSlot.hideOuterSlot(true);
    }

    public function init(_arg1:int, _arg2:int, _arg3:String, _arg4:String):void {
        var _local7:TextField;
        var _local10:TextFormat;
        var _local5:String = ("Tier " + _arg1.toString());
        setTitle(_local5, true);
        this.dqbanner = new dailyQuestBanner();
        addChild(this.dqbanner);
        this.dqbanner.x = (((modalWidth / 4) * 1.1) - (this.dqbanner.width / 2));
        this.dqbanner.y = ((modalHeight / 20) + 2);
        this.leftCenter = (this.dqbanner.x + (this.dqbanner.width / 2));
        title.setSize(20);
        title.setColor(16689154);
        title.x = (((modalWidth / 4) * 1.1) - (title.width / 2));
        title.y = ((this.dqbanner.y + this.dqbanner.height) + 5);
        title.setBold(false);
        if (title.textField != null) {
            _local10 = title.getTextFormat(0, _local5.length);
            _local10.leading = 10;
            title.setTextFormat(_local10, 0, _local5.length);
        }
        var _local6:TextFormat = new TextFormat();
        _local6.size = 13;
        _local6.font = "Myraid Pro";
        _local6.align = TextFormatAlign.CENTER;
        _local7 = new TextField();
        _local7.defaultTextFormat = _local6;
        _local7.text = "All Quests refresh daily at 5pm Pacific Time";
        _local7.wordWrap = true;
        _local7.width = 600;
        _local7.height = 200;
        _local7.y = 554;
        _local7.textColor = 16689154;
        _local7.alpha = 0.8;
        _local7.selectable = false;
        addChild(_local7);
        var _local8:String = LineBuilder.getLocalizedStringFromKey(ObjectLibrary.typeToDisplayId_[_arg2]);
        this.constructDescription(_arg3, _local8);
        this.addCloseButton();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        addChild(this.rightSlot);
        addChild(this.prevSlot);
        this.prevSlot.setCheckMark();
        if (_arg1 == 1) {
            this.prevSlot.visible = false;
        }
        addChild(this.nextSlot);
        this.nextSlot.setQuestionMark();
        this.rightSlot.setUsageText("Drag the item from your inventory into the slot", 14, 0xFFFF);
        this.rightSlot.setActionButton(this.exchangeButton);
        addChild(this.exchangeButton);
        this.exchangeButton.setText("Turn in!");
        this.exchangeButton.scaleButtonWidth(1.3);
        this.exchangeButton.scaleButtonHeight(2.4);
        var _local9:BitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg2, 80, true, false);
        this.rightSlot.setEmbeddedImage(new Bitmap(_local9));
        ((this.infoImageLoader) && (this.infoImageLoader.unload()));
        this.infoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.load(new URLRequest(_arg4));
        this.positionAssets();
    }

    private function positionAssets():void {
        this.rightSlot.x = (this.leftCenter - (this.rightSlot.width / 2));
        this.rightSlot.y = 350;
        this.prevSlot.width = (this.prevSlot.width * 0.8);
        this.prevSlot.height = (this.prevSlot.height * 0.8);
        this.prevSlot.x = (this.rightSlot.x - this.prevSlot.width);
        this.prevSlot.y = (this.rightSlot.y + ((82 - this.prevSlot.height) / 2));
        this.nextSlot.width = (this.nextSlot.width * 0.8);
        this.nextSlot.height = (this.nextSlot.height * 0.8);
        this.nextSlot.x = (this.rightSlot.x + this.rightSlot.width);
        this.nextSlot.y = (this.rightSlot.y + ((82 - this.nextSlot.height) / 2));
        this.exchangeButton.x = (this.leftCenter - (this.exchangeButton.width / 2));
        this.exchangeButton.y = (this.rightSlot.y + 100);
        this.exchangeButton.height = 50;
        background = this.makeModalBackground();
    }

    private function addInfoImageChild():void {
        if (this.infoImage == null) {
            return;
        }
        this.infoImage.alpha = 0;
        addChild(this.infoImage);
        var _local1:int = 8;
        this.infoImage.x = ((desc.x + desc.width) + 1);
        this.infoImage.y = (modalHeight / 20);
        var _local2:Shape = new Shape();
        var _local3:Graphics = _local2.graphics;
        _local3.beginFill(0);
        _local3.drawRect(0, 0, 600, 550);
        _local3.endFill();
        addChild(_local2);
        this.infoImage.mask = _local2;
        new GTween(this.infoImage, 1.25, {"alpha": 1});
    }

    private function onRewardLoadComplete(_arg1:Event):void {
        this.infoImageLoader.removeEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
        if (((!((this.infoImage == null))) && (!((this.infoImage.parent == null))))) {
            removeChild(this.infoImage);
        }
        this.infoImage = DisplayObject(this.infoImageLoader);
        this.addInfoImageChild();
    }

    private function onRewardLoadError(_arg1:IOErrorEvent):void {
        this.infoImageLoader.removeEventListener(Event.COMPLETE, this.onRewardLoadComplete);
        this.infoImageLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.DISK_ERROR, this.onRewardLoadError);
        this.infoImageLoader.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onRewardLoadError);
    }

    public function getItemSlot():ModalItemSlot {
        return (this.rightSlot);
    }

    public function getExchangeButton():LegacyBuyButton {
        return (this.exchangeButton);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        closeButton.clicked.remove(this.onClosed);
    }

    private function onClosed():void {
        closed.dispatch();
    }

    override protected function makeModalBackground():Sprite {
        x = 0;
        var _local1:Sprite = new Sprite();
        var _local2:DisplayObject = new backgroundImageEmbed();
        _local2.width = modalWidth;
        _local2.height = modalHeight;
        _local2.alpha = 0.74;
        _local1.addChild(_local2);
        return (_local1);
    }

    private function addCloseButton():void {
        var _local1:DialogCloseButton = new DialogCloseButton(0.82);
        addChild(_local1);
        _local1.y = 4;
        _local1.x = ((modalWidth - _local1.width) - 5);
        _local1.clicked.add(this.onClosed);
        closeButton = _local1;
    }

    public function noNewQuests():void {
        this.addCloseButton();
        var _local1:TextField = new TextField();
        var _local2 = "ALL QUESTS COMPLETED!";
        var _local3 = "";
        _local1.text = ((_local2 + "\n\n\n\n") + _local3);
        _local1.width = 600;
        var _local4:FontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
        var _local5:TextFormat = _local4.apply(_local1, 32, 0xFFFFFF, true, true);
        _local1.selectable = false;
        _local1.x = 0;
        _local1.y = 150;
        _local1.embedFonts = true;
        _local1.filters = [new GlowFilter(49941)];
        addChild(new ParticleModalMap(1));
        addChild(_local1);
        _local1 = new TextField();
        _local2 = "";
        _local3 = "Return at 5pm Pacific Time for New Quests!";
        _local1.text = ((_local2 + "\n\n\n") + _local3);
        _local1.width = 600;
        _local4.apply(_local1, 17, 49941, false, true);
        _local1.selectable = false;
        _local1.x = 0;
        _local1.y = 150;
        _local1.embedFonts = true;
        _local1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_local1);
    }

    public function constructDescription(_arg1:String, _arg2:String = ""):void {
        var _local4:String;
        var _local6:TextFormat;
        var _local3:int = _arg1.indexOf("{goal}");
        if (_local3 != -1) {
            _local4 = _arg1.split("{goal}").join(_arg2);
            setDesc(_local4, true);
        }
        else {
            _local4 = _arg1;
        }
        setDesc(_local4, true);
        desc.setColor(16689154);
        desc.setBold(false);
        desc.setSize(15);
        desc.setTextWidth(315);
        desc.x = ((((modalWidth / 4) * 1.1) - (desc.width / 2)) + 3);
        desc.y = (((title) != null) ? ((title.y + title.height) + 6) : 165);
        desc.setAutoSize(TextFieldAutoSize.LEFT);
        desc.setHorizontalAlign("left");
        desc.filters = [new DropShadowFilter(0, 0, 0)];
        desc.setLeftMargin(14);
        var _local5:TextFormat = desc.getTextFormat(0, _local4.length);
        _local5.leading = 4;
        desc.setTextFormat(_local5, 0, _local4.length);
        if (_local3 != -1) {
            _local6 = desc.getTextFormat(_local3, (_local3 + _arg2.length));
            _local6.color = 196098;
            _local6.bold = true;
            desc.setTextFormat(_local6, _local3, (_local3 + _arg2.length));
        }
    }

    public function onQuestComplete():void {
        var _local1:DisplayObject;
        _local1 = new questCompleteBanner();
        _local1.x = 120;
        _local1.y = 180;
        _local1.scaleX = 0.1;
        _local1.scaleY = 0.1;
        new GTween(_local1, 0.4, {
            "alpha": 1,
            "scaleX": 0.6,
            "scaleY": 0.6,
            "x": 30,
            "y": 130
        });
        addChild(_local1);
        var _local2:DisplayObject = new rewardgranted();
        _local2.x = (this.infoImage.x + 4);
        _local2.y = (this.infoImage.y + 4);
        _local2.alpha = 0;
        addChild(_local2);
        new GTween(_local2, 0.4, {"alpha": 1});
        new GTween(desc, 0.4, {"alpha": 0.2});
        new GTween(this.dqbanner, 0.4, {"alpha": 0.2});
        new GTween(title, 0.4, {"alpha": 0.2});
        this.rightSlot.highLightAll(0x545454);
        this.rightSlot.stopOutLineAnimation();
    }

    public function onExchangeClick():void {
        this.rightSlot.playOutLineAnimation(-1);
    }


}
}
