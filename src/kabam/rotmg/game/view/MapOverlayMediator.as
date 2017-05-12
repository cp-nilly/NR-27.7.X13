package kabam.rotmg.game.view {
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.map.mapoverlay.SpeechBalloon;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.ChatFilter;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MapOverlayMediator extends Mediator {

    [Inject]
    public var view:MapOverlay;
    [Inject]
    public var addSpeechBalloon:AddSpeechBalloonSignal;
    [Inject]
    public var chatFilter:ChatFilter;
    [Inject]
    public var account:Account;


    override public function initialize():void {
        this.addSpeechBalloon.add(this.onAddSpeechBalloon);
    }

    override public function destroy():void {
        this.addSpeechBalloon.remove(this.onAddSpeechBalloon);
    }

    private function onAddSpeechBalloon(_arg1:AddSpeechBalloonVO):void {
        var _local2:String = ((((this.account.isRegistered()) || (this.chatFilter.guestChatFilter(_arg1.go.name_)))) ? _arg1.text : ". . .");
        var _local3:* = new SpeechBalloon(_arg1.go, _local2, _arg1.name, _arg1.isTrade, _arg1.isGuild, _arg1.background, _arg1.backgroundAlpha, _arg1.outline, _arg1.outlineAlpha, _arg1.textColor, _arg1.lifetime, _arg1.bold, _arg1.hideable);
        this.view.addSpeechBalloon(_local3);
    }


}
}
