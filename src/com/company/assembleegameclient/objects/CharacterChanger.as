package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.CharacterChangerPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class CharacterChanger extends GameObject implements IInteractiveObject {

    public function CharacterChanger(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new CharacterChangerPanel(_arg1));
    }


}
}
