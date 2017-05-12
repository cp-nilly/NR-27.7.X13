package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.util.PointUtil;

public class Container extends GameObject implements IInteractiveObject {

    public var isLoot_:Boolean;
    public var ownerId_:String;

    public function Container(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
        this.isLoot_ = _arg1.hasOwnProperty("Loot");
        this.ownerId_ = "";
    }

    public function setOwnerId(_arg1:String):void {
        this.ownerId_ = _arg1;
        isInteractive_ = (((this.ownerId_ == "")) || (this.isBoundToCurrentAccount()));
    }

    public function isBoundToCurrentAccount():Boolean {
        return ((map_.player_.accountId_ == this.ownerId_));
    }

    override public function addTo(_arg1:Map, _arg2:Number, _arg3:Number):Boolean {
        if (!super.addTo(_arg1, _arg2, _arg3)) {
            return (false);
        }
        if (map_.player_ == null) {
            return (true);
        }
        var _local4:Number = PointUtil.distanceXY(map_.player_.x_, map_.player_.y_, _arg2, _arg3);
        if (((this.isLoot_) && ((_local4 < 10)))) {
            SoundEffectLibrary.play("loot_appears");
        }
        return (true);
    }

    public function getPanel(_arg1:GameSprite):Panel {
        var _local2:Player = ((((_arg1) && (_arg1.map))) ? _arg1.map.player_ : null);
        return (new ContainerGrid(this, _local2));
    }


}
}
