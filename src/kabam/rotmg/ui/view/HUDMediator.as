package kabam.rotmg.ui.view {
import com.company.assembleegameclient.objects.Player;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.game.view.components.StatsUndockedSignal;
import kabam.rotmg.game.view.components.StatsView;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class HUDMediator extends Mediator {

    [Inject]
    public var view:HUDView;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var updateHUD:UpdateHUDSignal;
    [Inject]
    public var statsUndocked:StatsUndockedSignal;
    [Inject]
    public var statsDocked:StatsDockedSignal;
    private var stats:Sprite;


    override public function initialize():void {
        this.updateHUD.addOnce(this.onInitializeHUD);
        this.updateHUD.add(this.onUpdateHUD);
        this.statsUndocked.add(this.onStatsUndocked);
    }

    private function onStatsUndocked(_arg1:StatsView):void {
        this.stats = _arg1;
        this.view.addChild(_arg1);
        _arg1.x = (this.view.mouseX - (_arg1.width / 2));
        _arg1.y = (this.view.mouseY - (_arg1.height / 2));
        this.startDraggingStatsAsset(_arg1);
    }

    private function startDraggingStatsAsset(_arg1:StatsView):void {
        _arg1.startDrag();
        _arg1.addEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
    }

    private function onStatsMouseUp(_arg1:MouseEvent):void {
        var _local2:Sprite = StatsView(_arg1.target);
        this.stopDraggingStatsAsset(_local2);
        if (_local2.hitTestObject(this.view.tabStrip)) {
            this.dockStats(_local2);
        }
    }

    private function dockStats(_arg1:Sprite):void {
        this.statsDocked.dispatch();
        this.view.removeChild(_arg1);
        _arg1.stopDrag();
    }

    private function stopDraggingStatsAsset(_arg1:Sprite):void {
        _arg1.removeEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
        _arg1.addEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        _arg1.stopDrag();
    }

    private function onStatsMouseDown(_arg1:MouseEvent):void {
        var _local2:Sprite = Sprite(_arg1.target);
        this.stats = _local2;
        _local2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        _local2.addEventListener(MouseEvent.MOUSE_UP, this.onStatsMouseUp);
        _local2.startDrag();
    }

    override public function destroy():void {
        this.updateHUD.remove(this.onUpdateHUD);
        this.statsUndocked.remove(this.onStatsUndocked);
        if (((this.stats) && (this.stats.hasEventListener(MouseEvent.MOUSE_DOWN)))) {
            this.stats.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStatsMouseDown);
        }
    }

    private function onUpdateHUD(_arg1:Player):void {
        this.view.draw();
    }

    private function onInitializeHUD(_arg1:Player):void {
        this.view.setPlayerDependentAssets(this.hudModel.gameSprite);
    }


}
}
