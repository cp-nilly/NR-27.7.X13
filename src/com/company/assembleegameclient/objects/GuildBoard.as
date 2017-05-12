package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.GuildBoardPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class GuildBoard extends GameObject implements IInteractiveObject {

    public function GuildBoard(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new GuildBoardPanel(_arg1));
    }


}
}
