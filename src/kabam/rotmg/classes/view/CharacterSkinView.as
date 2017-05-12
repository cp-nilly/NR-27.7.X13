package kabam.rotmg.classes.view {
import com.company.assembleegameclient.constants.ScreenTypes;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.ui.view.SignalWaiter;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class CharacterSkinView extends Sprite {

    private const base:ScreenBase = makeScreenBase();
    private const account:AccountScreen = makeAccountScreen();
    private const lines:Shape = makeLines();
    private const creditsDisplay:CreditDisplay = makeCreditDisplay();
    private const graphic:ScreenGraphic = makeScreenGraphic();
    private const playBtn:TitleMenuOption = makePlayButton();
    private const backBtn:TitleMenuOption = makeBackButton();
    private const list:CharacterSkinListView = makeListView();
    private const detail:ClassDetailView = makeClassDetailView();
    public const play:Signal = new NativeMappedSignal(playBtn, MouseEvent.CLICK);
    public const back:Signal = new NativeMappedSignal(backBtn, MouseEvent.CLICK);
    public const waiter:SignalWaiter = makeSignalWaiter();


    private function makeScreenBase():ScreenBase {
        var _local1:ScreenBase = new ScreenBase();
        addChild(_local1);
        return (_local1);
    }

    private function makeAccountScreen():AccountScreen {
        var _local1:AccountScreen = new AccountScreen();
        addChild(_local1);
        return (_local1);
    }

    private function makeCreditDisplay():CreditDisplay {
        var _local1:CreditDisplay;
        _local1 = new CreditDisplay(null, true, true);
        var _local2:PlayerModel = StaticInjectorContext.getInjector().getInstance(PlayerModel);
        if (_local2 != null) {
            _local1.draw(_local2.getCredits(), _local2.getFame(), _local2.getTokens());
        }
        _local1.x = 800;
        _local1.y = 20;
        addChild(_local1);
        return (_local1);
    }

    private function makeLines():Shape {
        var _local1:Shape = new Shape();
        _local1.graphics.clear();
        _local1.graphics.lineStyle(2, 0x545454);
        _local1.graphics.moveTo(0, 105);
        _local1.graphics.lineTo(800, 105);
        _local1.graphics.moveTo(346, 105);
        _local1.graphics.lineTo(346, 526);
        addChild(_local1);
        return (_local1);
    }

    private function makeScreenGraphic():ScreenGraphic {
        var _local1:ScreenGraphic = new ScreenGraphic();
        addChild(_local1);
        return (_local1);
    }

    private function makePlayButton():TitleMenuOption {
        var _local1:TitleMenuOption;
        _local1 = new TitleMenuOption(ScreenTypes.PLAY, 36, false);
        _local1.setAutoSize(TextFieldAutoSize.CENTER);
        _local1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        _local1.x = (400 - (_local1.width / 2));
        _local1.y = 550;
        addChild(_local1);
        return (_local1);
    }

    private function makeBackButton():TitleMenuOption {
        var _local1:TitleMenuOption;
        _local1 = new TitleMenuOption(ScreenTypes.BACK, 22, false);
        _local1.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        _local1.x = 30;
        _local1.y = 550;
        addChild(_local1);
        return (_local1);
    }

    private function makeListView():CharacterSkinListView {
        var _local1:CharacterSkinListView;
        _local1 = new CharacterSkinListView();
        _local1.x = 351;
        _local1.y = 110;
        addChild(_local1);
        return (_local1);
    }

    private function makeClassDetailView():ClassDetailView {
        var _local1:ClassDetailView;
        _local1 = new ClassDetailView();
        _local1.x = 5;
        _local1.y = 110;
        addChild(_local1);
        return (_local1);
    }

    public function setPlayButtonEnabled(_arg1:Boolean):void {
        if (!_arg1) {
            this.playBtn.deactivate();
        }
    }

    private function makeSignalWaiter():SignalWaiter {
        var _local1:SignalWaiter = new SignalWaiter();
        _local1.push(this.playBtn.changed);
        _local1.complete.add(this.positionOptions);
        return (_local1);
    }

    private function positionOptions():void {
        this.playBtn.x = (stage.stageWidth / 2);
    }


}
}
