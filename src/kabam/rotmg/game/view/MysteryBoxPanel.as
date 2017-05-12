package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.SellableObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.util.Currency;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.arena.util.ArenaViewAssetFactory;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.mysterybox.components.MysteryBoxSelectModal;
import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
import kabam.rotmg.mysterybox.services.MysteryBoxModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class MysteryBoxPanel extends Panel {

    private const BUTTON_OFFSET:int = 17;

    public var buyItem:Signal;
    private var owner_:SellableObject;
    private var nameText_:TextFieldDisplayConcrete;
    private var buyButton_:LegacyBuyButton;
    private var infoButton_:DeprecatedTextButton;
    private var icon_:Sprite;
    private var bitmap_:Bitmap;

    public function MysteryBoxPanel(_arg1:GameSprite, _arg2:uint) {
        this.buyItem = new Signal(SellableObject);
        var _local3:Injector = StaticInjectorContext.getInjector();
        var _local4:GetMysteryBoxesTask = _local3.getInstance(GetMysteryBoxesTask);
        _local4.start();
        super(_arg1);
        this.nameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((WIDTH - 44));
        this.nameText_.setBold(true);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(TextKey.SELLABLEOBJECTPANEL_TEXT));
        this.nameText_.setWordWrap(true);
        this.nameText_.setMultiLine(true);
        this.nameText_.setAutoSize(TextFieldAutoSize.CENTER);
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.icon_ = new Sprite();
        addChild(this.icon_);
        this.bitmap_ = new Bitmap(null);
        this.icon_.addChild(this.bitmap_);
        var _local5 = "MysteryBoxPanel.open";
        var _local6 = "MysteryBoxPanel.checkBackLater";
        var _local7 = "MysteryBoxPanel.mysteryBoxShop";
        var _local8:MysteryBoxModel = _local3.getInstance(MysteryBoxModel);
        var _local9:Account = _local3.getInstance(Account);
        if (((_local8.isInitialized()) || (!(_local9.isRegistered())))) {
            this.infoButton_ = new DeprecatedTextButton(16, _local5);
            this.infoButton_.addEventListener(MouseEvent.CLICK, this.onInfoButtonClick);
            addChild(this.infoButton_);
        }
        else {
            this.infoButton_ = new DeprecatedTextButton(16, _local6);
            addChild(this.infoButton_);
        }
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_local7));
        this.bitmap_.bitmapData = ArenaViewAssetFactory.returnHostBitmap(_arg2).bitmapData;
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function setOwner(_arg1:SellableObject):void {
        if (_arg1 == this.owner_) {
            return;
        }
        this.owner_ = _arg1;
        this.buyButton_.setPrice(this.owner_.price_, this.owner_.currency_);
        var _local2:String = this.owner_.soldObjectName();
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_local2));
        this.bitmap_.bitmapData = this.owner_.getIcon();
    }

    private function onAddedToStage(_arg1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.icon_.x = -4;
        this.icon_.y = -8;
        this.nameText_.x = 44;
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.infoButton_.removeEventListener(MouseEvent.CLICK, this.onInfoButtonClick);
    }

    private function onInfoButtonClick(_arg1:MouseEvent):void {
        this.onInfoButton();
    }

    private function onInfoButton():void {
        var _local1:Injector = StaticInjectorContext.getInjector();
        var _local2:MysteryBoxModel = _local1.getInstance(MysteryBoxModel);
        var _local3:Account = _local1.getInstance(Account);
        var _local4:OpenDialogSignal = _local1.getInstance(OpenDialogSignal);
        if (((_local2.isInitialized()) && (_local3.isRegistered()))) {
            _local4.dispatch(new MysteryBoxSelectModal());
        }
        else {
            if (!_local3.isRegistered()) {
                _local4.dispatch(new RegisterPromptDialog("SellableObjectPanelMediator.text", {"type": Currency.typeToName(Currency.GOLD)}));
            }
        }
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if ((((_arg1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.onInfoButton();
        }
    }

    override public function draw():void {
        this.nameText_.y = (((this.nameText_.height) > 30) ? 0 : 12);
        this.infoButton_.x = ((WIDTH / 2) - (this.infoButton_.width / 2));
        this.infoButton_.y = ((HEIGHT - (this.infoButton_.height / 2)) - this.BUTTON_OFFSET);
        if (!contains(this.infoButton_)) {
            addChild(this.infoButton_);
        }
    }


}
}
