package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;

public interface IInteractiveObject {

    function getPanel(_arg1:GameSprite):Panel;

}
}
