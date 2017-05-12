package com.company.assembleegameclient.map.partyoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Quest;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.tooltip.PortraitToolTip;
import com.company.assembleegameclient.ui.tooltip.QuestToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.events.MouseEvent;
import flash.utils.getTimer;

public class QuestArrow extends GameObjectArrow {

    public var map_:Map;

    public function QuestArrow(_arg1:Map) {
        super(16352321, 12919330, true);
        this.map_ = _arg1;
    }

    public function refreshToolTip():void {
        setToolTip(this.getToolTip(go_, getTimer()));
    }

    override protected function onMouseOver(_arg1:MouseEvent):void {
        super.onMouseOver(_arg1);
        this.refreshToolTip();
    }

    override protected function onMouseOut(_arg1:MouseEvent):void {
        super.onMouseOut(_arg1);
        this.refreshToolTip();
    }

    private function getToolTip(_arg1:GameObject, _arg2:int):ToolTip {
        if ((((_arg1 == null)) || ((_arg1.texture_ == null)))) {
            return (null);
        }
        if (this.shouldShowFullQuest(_arg2)) {
            return (new QuestToolTip(go_));
        }
        if (Parameters.data_.showQuestPortraits) {
            return (new PortraitToolTip(_arg1));
        }
        return (null);
    }

    private function shouldShowFullQuest(_arg1:int):Boolean {
        var _local2:Quest = this.map_.quest_;
        return (((mouseOver_) || (_local2.isNew(_arg1))));
    }

    override public function draw(_arg1:int, _arg2:Camera):void {
        var _local4:Boolean;
        var _local5:Boolean;
        var _local3:GameObject = this.map_.quest_.getObject(_arg1);
        if (_local3 != go_) {
            setGameObject(_local3);
            setToolTip(this.getToolTip(_local3, _arg1));
        }
        else {
            if (go_ != null) {
                _local4 = (tooltip_ is QuestToolTip);
                _local5 = this.shouldShowFullQuest(_arg1);
                if (_local4 != _local5) {
                    setToolTip(this.getToolTip(_local3, _arg1));
                }
            }
        }
        super.draw(_arg1, _arg2);
    }


}
}
