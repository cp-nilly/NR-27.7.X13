package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.dailyLogin.view.DailyLoginPanel;

public class DailyLoginRewards extends GameObject implements IInteractiveObject {

    public function DailyLoginRewards(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new DailyLoginPanel(_arg1));
    }


}
}
