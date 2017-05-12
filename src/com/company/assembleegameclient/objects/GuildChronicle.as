package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.GuildChroniclePanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class GuildChronicle extends GameObject implements IInteractiveObject {

    public function GuildChronicle(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new GuildChroniclePanel(_arg1));
    }


}
}
