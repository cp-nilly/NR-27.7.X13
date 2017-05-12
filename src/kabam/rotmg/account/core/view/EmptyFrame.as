package kabam.rotmg.account.core.view {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class EmptyFrame extends Sprite {

    public static const TEXT_MARGIN:int = 20;

    public var register:Signal;
    public var cancel:Signal;
    protected var modalWidth:Number;
    protected var modalHeight:Number;
    protected var closeButton:DialogCloseButton;
    protected var background:Sprite;
    protected var backgroundContainer:Sprite;
    protected var title:TextFieldDisplayConcrete;
    protected var desc:TextFieldDisplayConcrete;

    public function EmptyFrame(_arg1:int = 288, _arg2:int = 150, _arg3:String = "") {
        this.modalWidth = _arg1;
        this.modalHeight = _arg2;
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        if (_arg3 != "") {
            this.setTitle(_arg3, true);
        }
        if (this.background == null) {
            this.backgroundContainer = new Sprite();
            this.background = this.makeModalBackground();
            this.backgroundContainer.addChild(this.background);
            addChild(this.backgroundContainer);
        }
        if (_arg3 != "") {
            this.setTitle(_arg3, true);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        if (this.closeButton != null) {
            this.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
        }
    }

    public function setWidth(_arg1:Number):void {
        this.modalWidth = _arg1;
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        this.refreshBackground();
    }

    public function setHeight(_arg1:Number):void {
        this.modalHeight = _arg1;
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        this.refreshBackground();
    }

    public function setTitle(_arg1:String, _arg2:Boolean):void {
        if (((!((this.title == null))) && (!((this.title.parent == null))))) {
            removeChild(this.title);
        }
        if (_arg1 != null) {
            this.title = this.getText(_arg1, TEXT_MARGIN, 5, _arg2);
            addChild(this.title);
        }
        else {
            this.title = null;
        }
    }

    public function setDesc(_arg1:String, _arg2:Boolean):void {
        if (_arg1 != null) {
            if (((!((this.desc == null))) && (!((this.desc.parent == null))))) {
                removeChild(this.desc);
            }
            this.desc = this.getText(_arg1, TEXT_MARGIN, 50, _arg2);
            addChild(this.desc);
        }
    }

    public function setCloseButton(_arg1:Boolean):void {
        if ((((this.closeButton == null)) && (_arg1))) {
            this.closeButton = PetsViewAssetFactory.returnCloseButton(this.modalWidth);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addChild(this.closeButton);
        }
        else {
            if (((!((this.closeButton == null))) && (!(_arg1)))) {
                removeChild(this.closeButton);
                this.closeButton = null;
            }
        }
    }

    protected function getText(_arg1:String, _arg2:int, _arg3:int, _arg4:Boolean):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete;
        _local5 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
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

    protected function makeModalBackground():Sprite {
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        var _local1:PopupWindowBackground = new PopupWindowBackground();
        _local1.draw(this.modalWidth, this.modalHeight, PopupWindowBackground.TYPE_DEFAULT_GREY);
        if (this.title != null) {
            _local1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        }
        return (_local1);
    }

    public function alignAssets():void {
        this.desc.setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
        this.title.setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
    }

    protected function refreshBackground():void {
        this.backgroundContainer.removeChild(this.background);
        this.background = this.makeModalBackground();
        this.backgroundContainer.addChild(this.background);
    }

    public function onCloseClick(_arg1:MouseEvent):void {
    }


}
}
