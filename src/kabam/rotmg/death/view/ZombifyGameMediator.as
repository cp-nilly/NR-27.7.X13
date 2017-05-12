package kabam.rotmg.death.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;

import flash.utils.Dictionary;

import kabam.rotmg.death.control.ZombifySignal;
import kabam.rotmg.game.signals.SetWorldInteractionSignal;
import kabam.rotmg.messaging.impl.incoming.Death;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ZombifyGameMediator extends Mediator {

    [Inject]
    public var view:GameSprite;
    [Inject]
    public var zombify:ZombifySignal;
    [Inject]
    public var setWorldInteraction:SetWorldInteractionSignal;


    override public function initialize():void {
        this.zombify.add(this.onZombify);
    }

    override public function destroy():void {
        this.zombify.remove(this.onZombify);
    }

    private function onZombify(_arg1:Death):void {
        this.removePlayer();
        this.setZombieAsViewFocus(_arg1);
        this.setWorldInteraction.dispatch(false);
    }

    private function removePlayer():void {
        var _local1:Player = this.view.map.player_;
        ((_local1) && (this.view.map.removeObj(_local1.objectId_)));
        this.view.map.player_ = null;
    }

    private function setZombieAsViewFocus(_arg1:Death):void {
        var _local2:Dictionary = this.view.map.goDict_;
        ((_local2) && (this.view.setFocus(_local2[_arg1.zombieId])));
    }


}
}
