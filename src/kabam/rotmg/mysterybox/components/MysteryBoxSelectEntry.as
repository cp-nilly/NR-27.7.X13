package kabam.rotmg.mysterybox.components {
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.util.Currency;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;
import kabam.rotmg.util.components.UIAssetsHelper;

public class MysteryBoxSelectEntry extends Sprite {

    public static var redBarEmbed:Class = MysteryBoxSelectEntry_redBarEmbed;

    private const newString:String = "MysteryBoxSelectEntry.newString";
    private const onSaleString:String = "MysteryBoxSelectEntry.onSaleString";
    private const saleEndString:String = "MysteryBoxSelectEntry.saleEndString";

    public var mbi:MysteryBoxInfo;
    private var buyButton:LegacyBuyButton;
    private var leftNavSprite:Sprite;
    private var rightNavSprite:Sprite;
    private var iconImage:DisplayObject;
    private var infoImageBorder:PopupWindowBackground;
    private var infoImage:DisplayObject;
    private var newText:TextFieldDisplayConcrete;
    private var sale:TextFieldDisplayConcrete;
    private var left:TextFieldDisplayConcrete;
    private var hoverState:Boolean = false;
    private var descriptionShowing:Boolean = false;
    private var redbar:DisplayObject;
    private var soldOut:Boolean;
    private var quantity_:int;
    private var title:TextFieldDisplayConcrete;

    public function MysteryBoxSelectEntry(_arg1:MysteryBoxInfo):void {
        var _local2:DisplayObject;
        super();
        this.redbar = new redBarEmbed();
        this.redbar.y = -5;
        this.redbar.width = (MysteryBoxSelectModal.modalWidth - 5);
        this.redbar.height = (MysteryBoxSelectModal.aMysteryBoxHeight - 8);
        addChild(this.redbar);
        _local2 = new redBarEmbed();
        _local2.y = 0;
        _local2.width = (MysteryBoxSelectModal.modalWidth - 5);
        _local2.height = ((MysteryBoxSelectModal.aMysteryBoxHeight - 8) + 5);
        _local2.alpha = 0;
        addChild(_local2);
        this.mbi = _arg1;
        this.quantity_ = 1;
        this.title = this.getText(this.mbi.title, 74, 20, 18, true);
        this.title.textChanged.addOnce(this.updateTextPosition);
        addChild(this.title);
        this.addNewText();
        this.buyButton = new LegacyBuyButton("", 16, 0, Currency.INVALID, false, this.mbi.isOnSale());
        if (this.mbi.unitsLeft == 0) {
            this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
        }
        else {
            if (this.mbi.isOnSale()) {
                this.buyButton.setPrice(this.mbi.saleAmount, this.mbi.saleCurrency);
            }
            else {
                this.buyButton.setPrice(this.mbi.priceAmount, this.mbi.priceCurrency);
            }
        }
        this.buyButton.x = (MysteryBoxSelectModal.modalWidth - 120);
        this.buyButton.y = 16;
        this.buyButton._width = 70;
        this.addSaleText();
        if ((((this.mbi.unitsLeft > 0)) || ((this.mbi.unitsLeft == -1)))) {
            this.buyButton.addEventListener(MouseEvent.CLICK, this.onBoxBuy);
        }
        addChild(this.buyButton);
        this.iconImage = this.mbi.iconImage;
        this.infoImage = this.mbi.infoImage;
        if (this.iconImage == null) {
            this.mbi.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageLoadComplete);
        }
        else {
            this.addIconImageChild();
        }
        if (this.infoImage == null) {
            this.mbi.infoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        }
        else {
            this.addInfoImageChild();
        }
        this.mbi.quantity = this.quantity_.toString();
        if ((((this.mbi.unitsLeft > 0)) || ((this.mbi.unitsLeft == -1)))) {
            this.leftNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.LEFT_NEVIGATOR, 3);
            this.leftNavSprite.x = ((this.buyButton.x + this.buyButton.width) + 45);
            this.leftNavSprite.y = ((this.buyButton.y + (this.buyButton.height / 2)) - 2);
            this.leftNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.leftNavSprite);
            this.rightNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.RIGHT_NEVIGATOR, 3);
            this.rightNavSprite.x = ((this.buyButton.x + this.buyButton.width) + 45);
            this.rightNavSprite.y = ((this.buyButton.y + (this.buyButton.height / 2)) - 16);
            this.rightNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
            addChild(this.rightNavSprite);
        }
        this.addUnitsLeftText();
        addEventListener(MouseEvent.ROLL_OVER, this.onHover);
        addEventListener(MouseEvent.ROLL_OUT, this.onRemoveHover);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function updateTextPosition() {
        this.title.y = Math.round(((this.redbar.height - (this.title.getTextHeight() + (((this.title.textField.numLines == 1)) ? 8 : 10))) / 2));
        if (((((this.mbi.isNew()) || (this.mbi.isOnSale()))) && ((this.title.textField.numLines == 2)))) {
            this.title.y = (this.title.y + 6);
        }
    }

    public function updateContent() {
        if (this.left) {
            this.left.setStringBuilder(new LineBuilder().setParams(((this.mbi.unitsLeft + " ") + LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.left"))));
        }
    }

    private function addUnitsLeftText() {
        var _local1:uint;
        var _local2:int;
        if (this.mbi.unitsLeft >= 0) {
            _local2 = (this.mbi.unitsLeft / this.mbi.totalUnits);
            if (_local2 <= 0.1) {
                _local1 = 0xFF0000;
            }
            else {
                if (_local2 <= 0.5) {
                    _local1 = 0xFFA900;
                }
                else {
                    _local1 = 0xFF00;
                }
            }
            this.left = this.getText((this.mbi.unitsLeft + " left"), 20, 46, 11).setColor(_local1);
            addChild(this.left);
        }
    }

    private function markAsSold() {
        this.buyButton.setPrice(0, Currency.INVALID);
        this.buyButton.setText(LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutButton"));
        if (((this.leftNavSprite) && ((this.leftNavSprite.parent == this)))) {
            removeChild(this.leftNavSprite);
            this.leftNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        if (((this.rightNavSprite) && ((this.rightNavSprite.parent == this)))) {
            removeChild(this.rightNavSprite);
            this.rightNavSprite.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function onHover(_arg1:MouseEvent):void {
        this.hoverState = true;
        this.addInfoImageChild();
    }

    private function onRemoveHover(_arg1:MouseEvent):void {
        this.hoverState = false;
        this.removeInfoImageChild();
    }

    private function onClick(_arg1:MouseEvent) {
        switch (_arg1.currentTarget) {
            case this.rightNavSprite:
                if (this.quantity_ == 1) {
                    this.quantity_ = (this.quantity_ + 4);
                }
                else {
                    if (this.quantity_ < 10) {
                        this.quantity_ = (this.quantity_ + 5);
                    }
                }
                break;
            case this.leftNavSprite:
                if (this.quantity_ == 10) {
                    this.quantity_ = (this.quantity_ - 5);
                }
                else {
                    if (this.quantity_ > 1) {
                        this.quantity_ = (this.quantity_ - 4);
                    }
                }
                break;
        }
        this.mbi.quantity = this.quantity_.toString();
        if (this.mbi.isOnSale()) {
            this.buyButton.setPrice((this.mbi.saleAmount * this.quantity_), this.mbi.saleCurrency);
        }
        else {
            this.buyButton.setPrice((this.mbi.priceAmount * this.quantity_), this.mbi.priceCurrency);
        }
    }

    private function addNewText():void {
        if (((this.mbi.isNew()) && (!(this.mbi.isOnSale())))) {
            this.newText = this.getText(this.newString, 74, 0).setColor(0xFFDE00);
            addChild(this.newText);
        }
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local2:Number = (1.05 + (0.05 * Math.sin((getTimer() / 200))));
        if (this.sale) {
            this.sale.scaleX = _local2;
            this.sale.scaleY = _local2;
        }
        if (this.newText) {
            this.newText.scaleX = _local2;
            this.newText.scaleY = _local2;
        }
        if ((((this.mbi.unitsLeft == 0)) && (!(this.soldOut)))) {
            this.soldOut = true;
            this.markAsSold();
        }
    }

    private function addSaleText():void {
        var _local1:LineBuilder;
        var _local2:TextFieldDisplayConcrete;
        var _local3:TextFieldDisplayConcrete;
        if (this.mbi.isOnSale()) {
            this.sale = this.getText(this.onSaleString, 74, 0).setColor(0xFF00);
            addChild(this.sale);
            _local1 = this.mbi.getSaleTimeLeftStringBuilder();
            _local2 = this.getText("", this.buyButton.x, ((this.buyButton.y + this.buyButton.height) + 10), 10).setColor(0xFF0000);
            _local2.setStringBuilder(_local1);
            addChild(_local2);
            _local3 = this.getText(((((LineBuilder.getLocalizedStringFromKey("MysteryBoxSelectEntry.was") + " ") + this.mbi.priceAmount) + " ") + this.mbi.currencyName), this.buyButton.x, (this.buyButton.y - 14), 10).setColor(0xFF0000);
            addChild(_local3);
        }
    }

    private function onImageLoadComplete(_arg1:Event):void {
        this.mbi.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onImageLoadComplete);
        this.iconImage = DisplayObject(this.mbi.loader);
        this.addIconImageChild();
    }

    private function onInfoLoadComplete(_arg1:Event):void {
        this.mbi.infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        this.infoImage = DisplayObject(this.mbi.infoImageLoader);
        this.addInfoImageChild();
    }

    public function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:int = 12, _arg5:Boolean = false):TextFieldDisplayConcrete {
        var _local6:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(_arg4).setColor(0xFFFFFF).setTextWidth((MysteryBoxSelectModal.modalWidth - 185));
        _local6.setBold(true);
        if (_arg5) {
            _local6.setStringBuilder(new StaticStringBuilder(_arg1));
        }
        else {
            _local6.setStringBuilder(new LineBuilder().setParams(_arg1));
        }
        _local6.setWordWrap(true);
        _local6.setMultiLine(true);
        _local6.setAutoSize(TextFieldAutoSize.LEFT);
        _local6.setHorizontalAlign(TextFormatAlign.LEFT);
        _local6.filters = [new DropShadowFilter(0, 0, 0)];
        _local6.x = _arg2;
        _local6.y = _arg3;
        return (_local6);
    }

    private function addIconImageChild():void {
        if (this.iconImage == null) {
            return;
        }
        this.iconImage.width = 58;
        this.iconImage.height = 58;
        this.iconImage.x = 14;
        if (this.mbi.unitsLeft != -1) {
            this.iconImage.y = -6;
        }
        else {
            this.iconImage.y = 1;
        }
        addChild(this.iconImage);
    }

    private function addInfoImageChild():void {
        var _local3:Array;
        var _local4:ColorMatrixFilter;
        if (this.infoImage == null) {
            return;
        }
        var _local1:int = 8;
        this.infoImage.width = (291 - _local1);
        this.infoImage.height = ((598 - (_local1 * 2)) - 2);
        var _local2:Point = this.globalToLocal(new Point(((MysteryBoxSelectModal.getRightBorderX() + 1) + 14), (2 + _local1)));
        this.infoImage.x = _local2.x;
        this.infoImage.y = _local2.y;
        if (((this.hoverState) && (!(this.descriptionShowing)))) {
            this.descriptionShowing = true;
            addChild(this.infoImage);
            this.infoImageBorder = new PopupWindowBackground();
            this.infoImageBorder.draw(this.infoImage.width, (this.infoImage.height + 2), PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
            this.infoImageBorder.x = this.infoImage.x;
            this.infoImageBorder.y = this.infoImage.y - 1;
            addChild(this.infoImageBorder);
            _local3 = [3.0742, -1.8282, -0.246, 0, 50, -0.9258, 2.1718, -0.246, 0, 50, -0.9258, -1.8282, 3.754, 0, 50, 0, 0, 0, 1, 0];
            _local4 = new ColorMatrixFilter(_local3);
            this.redbar.filters = [_local4];
        }
    }

    private function removeInfoImageChild():void {
        if (this.descriptionShowing) {
            removeChild(this.infoImageBorder);
            removeChild(this.infoImage);
            this.descriptionShowing = false;
            this.redbar.filters = [];
        }
    }

    private function onBoxBuy(_arg1:MouseEvent):void {
        var _local2:OpenDialogSignal;
        var _local3:String;
        var _local4:Dialog;
        var _local5:MysteryBoxRollModal;
        var _local6:Boolean;
        if (((!((this.mbi.unitsLeft == -1))) && ((this.quantity_ > this.mbi.unitsLeft)))) {
            _local2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local3 = "";
            if (this.mbi.unitsLeft == 0) {
                _local3 = "MysteryBoxError.soldOutAll";
            }
            else {
                _local3 = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft", {
                    "left": this.mbi.unitsLeft,
                    "box": (((this.mbi.unitsLeft == 1)) ? LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box") : LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                });
            }
            _local4 = new Dialog("MysteryBoxRollModal.purchaseFailedString", _local3, "MysteryBoxRollModal.okString", null, null);
            _local4.addEventListener(Dialog.LEFT_BUTTON, this.onErrorOk);
            _local2.dispatch(_local4);
        }
        else {
            _local5 = new MysteryBoxRollModal(this.mbi, this.quantity_);
            _local6 = _local5.moneyCheckPass();
            if (_local6) {
                _local5.parentSelectModal = MysteryBoxSelectModal(parent.parent);
                _local2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
                _local2.dispatch(_local5);
            }
        }
    }

    private function onErrorOk(_arg1:Event):void {
        var _local2:OpenDialogSignal;
        _local2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local2.dispatch(new MysteryBoxSelectModal());
    }


}
}
