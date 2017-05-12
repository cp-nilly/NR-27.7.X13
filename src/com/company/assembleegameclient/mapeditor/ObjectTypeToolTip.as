package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

public class ObjectTypeToolTip extends ToolTip {

    private static const MAX_WIDTH:int = 180;

    private var titleText_:BaseSimpleText;
    private var descText_:BaseSimpleText;

    public function ObjectTypeToolTip(_arg1:XML) {
        var _local3:XML;
        super(0x363636, 1, 0x9B9B9B, 1, true);
        this.titleText_ = new BaseSimpleText(16, 0xFFFFFF, false, (MAX_WIDTH - 4), 0);
        this.titleText_.setBold(true);
        this.titleText_.wordWrap = true;
        this.titleText_.text = String(_arg1.@id);
        this.titleText_.useTextDimensions();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.titleText_.x = 0;
        this.titleText_.y = 0;
        addChild(this.titleText_);
        var _local2 = "";
        if (_arg1.hasOwnProperty("Group")) {
            _local2 = (_local2 + (("Group: " + _arg1.Group) + "\n"));
        }
        if (_arg1.hasOwnProperty("Static")) {
            _local2 = (_local2 + "Static\n");
        }
        if (_arg1.hasOwnProperty("Enemy")) {
            _local2 = (_local2 + "Enemy\n");
            if (_arg1.hasOwnProperty("MaxHitPoints")) {
                _local2 = (_local2 + (("MaxHitPoints: " + _arg1.MaxHitPoints) + "\n"));
            }
            if (_arg1.hasOwnProperty("Defense")) {
                _local2 = (_local2 + (("Defense: " + _arg1.Defense) + "\n"));
            }
        }
        if (_arg1.hasOwnProperty("God")) {
            _local2 = (_local2 + "God\n");
        }
        if (_arg1.hasOwnProperty("Quest")) {
            _local2 = (_local2 + "Quest\n");
        }
        if (_arg1.hasOwnProperty("Hero")) {
            _local2 = (_local2 + "Hero\n");
        }
        if (_arg1.hasOwnProperty("Encounter")) {
            _local2 = (_local2 + "Encounter\n");
        }
        if (_arg1.hasOwnProperty("Level")) {
            _local2 = (_local2 + (("Level: " + _arg1.Level) + "\n"));
        }
        if (_arg1.hasOwnProperty("Terrain")) {
            _local2 = (_local2 + (("Terrain: " + _arg1.Terrain) + "\n"));
        }
        for each (_local3 in _arg1.Projectile) {
            _local2 = (_local2 + (((((((((("Projectile " + _local3.@id) + ": ") + _local3.ObjectId) + "\n") + "\tDamage: ") + _local3.Damage) + "\n") + "\tSpeed: ") + _local3.Speed) + "\n"));
            if (_local3.hasOwnProperty("PassesCover")) {
                _local2 = (_local2 + "\tPassesCover\n");
            }
            if (_local3.hasOwnProperty("MultiHit")) {
                _local2 = (_local2 + "\tMultiHit\n");
            }
            if (_local3.hasOwnProperty("ConditionEffect")) {
                _local2 = (_local2 + (((("\t" + _local3.ConditionEffect) + " for ") + _local3.ConditionEffect.@duration) + " secs\n"));
            }
            if (_local3.hasOwnProperty("Parametric")) {
                _local2 = (_local2 + "\tParametric\n");
            }
        }
        this.descText_ = new BaseSimpleText(14, 0xB3B3B3, false, MAX_WIDTH, 0);
        this.descText_.wordWrap = true;
        this.descText_.text = String(_local2);
        this.descText_.useTextDimensions();
        this.descText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        this.descText_.x = 0;
        this.descText_.y = (this.titleText_.height + 2);
        addChild(this.descText_);
    }

}
}
