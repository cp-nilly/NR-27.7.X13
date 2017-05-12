package kabam.rotmg.game.view.components {
import com.company.ui.BaseSimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class TabTextView extends TabView {

    private var background:Sprite;
    private var text:BaseSimpleText;
    private var badgeBG:Bitmap;
    private var badgeIcon:Bitmap;

    public function TabTextView(_arg1:int, _arg2:Sprite, _arg3:BaseSimpleText) {
        super(_arg1);
        this.initBackground(_arg2);
        if (_arg3) {
            this.initTabText(_arg3);
        }
    }

    public function setBadge(_arg1:int):void {
        if (this.badgeIcon == null) {
            this.badgeIcon = new Bitmap();
            this.badgeIcon.bitmapData = AssetLibrary.getImageFromSet("lofiInterface", 110);
            this.badgeIcon.x = (this.x - 10);
            this.badgeIcon.y = 5;
            this.badgeIcon.scaleX = (this.badgeIcon.scaleY = 1.5);
            addChild(this.badgeIcon);
            this.badgeBG = new Bitmap();
            this.badgeBG.bitmapData = AssetLibrary.getImageFromSet("lofiInterface", 110);
            this.badgeBG.x = (this.x - 12);
            this.badgeBG.y = 3;
            this.badgeBG.scaleX = (this.badgeBG.scaleY = 2);
            addChild(this.badgeBG);
        }
        this.badgeIcon.visible = (this.badgeBG.visible = (_arg1 > 0));
    }

    private function initBackground(_arg1:Sprite):void {
        this.background = _arg1;
        addChild(_arg1);
    }

    private function initTabText(_arg1:BaseSimpleText):void {
        this.text = _arg1;
        _arg1.x = 5;
        addChild(_arg1);
    }

    override public function setSelected(_arg1:Boolean):void {
        var _local2:ColorTransform = this.background.transform.colorTransform;
        _local2.color = ((_arg1) ? TabConstants.BACKGROUND_COLOR : TabConstants.TAB_COLOR);
        this.background.transform.colorTransform = _local2;
    }


}
}
