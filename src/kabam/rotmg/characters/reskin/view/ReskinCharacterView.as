package kabam.rotmg.characters.reskin.view {
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.classes.view.CharacterSkinListView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;
import kabam.rotmg.util.components.DialogBackground;
import kabam.rotmg.util.graphics.ButtonLayoutHelper;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class ReskinCharacterView extends Sprite {

    private static const MARGIN:int = 10;
    private static const DIALOG_WIDTH:int = (CharacterSkinListView.WIDTH + (MARGIN * 2));
    private static const BUTTON_WIDTH:int = 120;
    private static const BUTTON_FONT:int = 16;
    private static const BUTTONS_HEIGHT:int = 40;
    private static const TITLE_OFFSET:int = 27;

    private const layoutListener:SignalWaiter = makeLayoutWaiter();
    private const background:DialogBackground = makeBackground();
    private const title:TextFieldDisplayConcrete = makeTitle();
    private const list:CharacterSkinListView = makeListView();
    private const cancel:DeprecatedTextButton = makeCancelButton();
    private const select:DeprecatedTextButton = makeSelectButton();
    public const cancelled:Signal = new NativeMappedSignal(cancel, MouseEvent.CLICK);
    public const selected:Signal = new NativeMappedSignal(select, MouseEvent.CLICK);

    public var viewHeight:int;


    private function makeLayoutWaiter():SignalWaiter {
        var _local1:SignalWaiter = new SignalWaiter();
        _local1.complete.add(this.positionButtons);
        return (_local1);
    }

    private function makeBackground():DialogBackground {
        var _local1:DialogBackground = new DialogBackground();
        addChild(_local1);
        return (_local1);
    }

    private function makeTitle():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(0xB6B6B6).setTextWidth(DIALOG_WIDTH);
        _local1.setAutoSize(TextFieldAutoSize.CENTER).setBold(true);
        _local1.setStringBuilder(new LineBuilder().setParams(TextKey.RESKINCHARACTERVIEW_TITLE));
        _local1.y = (MARGIN * 0.5);
        addChild(_local1);
        return (_local1);
    }

    private function makeListView():CharacterSkinListView {
        var _local1:CharacterSkinListView;
        _local1 = new CharacterSkinListView();
        _local1.x = MARGIN;
        _local1.y = (MARGIN + TITLE_OFFSET);
        addChild(_local1);
        return (_local1);
    }

    private function makeCancelButton():DeprecatedTextButton {
        var _local1:DeprecatedTextButton = new DeprecatedTextButton(BUTTON_FONT, TextKey.RESKINCHARACTERVIEW_CANCEL, BUTTON_WIDTH);
        addChild(_local1);
        this.layoutListener.push(_local1.textChanged);
        return (_local1);
    }

    private function makeSelectButton():DeprecatedTextButton {
        var _local1:DeprecatedTextButton = new DeprecatedTextButton(BUTTON_FONT, TextKey.RESKINCHARACTERVIEW_SELECT, BUTTON_WIDTH);
        addChild(_local1);
        this.layoutListener.push(_local1.textChanged);
        return (_local1);
    }

    public function setList(_arg1:Vector.<DisplayObject>):void {
        this.list.setItems(_arg1);
        this.getDialogHeight();
        this.resizeBackground();
        this.positionButtons();
    }

    private function getDialogHeight():void {
        this.viewHeight = Math.min((CharacterSkinListView.HEIGHT + MARGIN), this.list.getListHeight());
        this.viewHeight = (this.viewHeight + ((BUTTONS_HEIGHT + (MARGIN * 2)) + TITLE_OFFSET));
    }

    private function resizeBackground():void {
        this.background.draw(DIALOG_WIDTH, this.viewHeight);
        this.background.graphics.lineStyle(2, 0x5B5B5B, 1, false, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.BEVEL);
        this.background.graphics.moveTo(1, TITLE_OFFSET);
        this.background.graphics.lineTo((DIALOG_WIDTH - 1), TITLE_OFFSET);
    }

    private function positionButtons():void {
        var _local1:ButtonLayoutHelper = new ButtonLayoutHelper();
        _local1.layout(DIALOG_WIDTH, this.cancel, this.select);
        this.cancel.y = (this.select.y = (this.viewHeight - BUTTONS_HEIGHT));
    }


}
}
