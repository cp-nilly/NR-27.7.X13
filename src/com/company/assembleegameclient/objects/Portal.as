package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.PortalPanel;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class Portal extends GameObject implements IInteractiveObject {

    private static const NAME_PARSER:RegExp = /(^\s+)\s\(([0-9]+)\/[0-9]+\)/;

    public var nexusPortal_:Boolean;
    public var lockedPortal_:Boolean;
    public var active_:Boolean = true;

    public function Portal(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
        this.nexusPortal_ = _arg1.hasOwnProperty("NexusPortal");
        this.lockedPortal_ = _arg1.hasOwnProperty("LockedPortal");
    }

    override protected function makeNameBitmapData():BitmapData {
        var _local1:Array = name_.match(NAME_PARSER);
        var _local2:StringBuilder = new PortalNameParser().makeBuilder(name_);
        var _local3:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        return (_local3.make(_local2, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        super.draw(_arg1, _arg2, _arg3);
        if (this.nexusPortal_) {
            drawName(_arg1, _arg2);
        }
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new PortalPanel(_arg1, this));
    }


}
}
