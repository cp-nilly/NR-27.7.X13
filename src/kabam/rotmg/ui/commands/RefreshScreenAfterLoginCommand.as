package kabam.rotmg.ui.commands {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;

import flash.display.Sprite;

import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
import kabam.rotmg.core.model.ScreenModel;
import kabam.rotmg.core.signals.InvalidateDataSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;

public class RefreshScreenAfterLoginCommand {

    [Inject]
    public var screenModel:ScreenModel;
    [Inject]
    public var update:UpdateAccountInfoSignal;
    [Inject]
    public var invalidate:InvalidateDataSignal;
    [Inject]
    public var setScreenWithValidData:SetScreenWithValidDataSignal;


    public function execute():void {
        this.update.dispatch();
        this.invalidate.dispatch();
        this.setScreenWithValidData.dispatch(this.getTargetScreen());
    }

    private function getTargetScreen():Sprite {
        var _local1:Class = this.screenModel.getCurrentScreenType();
        if ((((_local1 == null)) || ((_local1 == GameSprite)))) {
            _local1 = CharacterSelectionAndNewsScreen;
        }
        return (new (_local1)());
    }


}
}
