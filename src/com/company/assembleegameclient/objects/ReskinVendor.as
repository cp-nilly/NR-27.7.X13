package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

import kabam.rotmg.characters.reskin.view.ReskinPanel;

public class ReskinVendor extends GameObject implements IInteractiveObject {

    public function ReskinVendor(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new ReskinPanel(_arg1));
    }


}
}
