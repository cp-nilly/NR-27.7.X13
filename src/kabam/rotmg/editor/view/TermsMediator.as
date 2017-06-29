package kabam.rotmg.editor.view {
import kabam.rotmg.core.signals.SetScreenSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TermsMediator extends Mediator {

    [Inject]
    public var view:TermsView;
    [Inject]
    public var setScreen:SetScreenSignal;


    override public function initialize():void {
        this.view.response.addOnce(this.onResponse);
    }

    private function onResponse(_arg_1:Boolean):void {
        if (_arg_1) {
            this.setScreen.dispatch(new TextureView());
        }
    }


}
}
