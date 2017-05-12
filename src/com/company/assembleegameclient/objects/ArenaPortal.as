package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.BitmapData;
import flash.display.IGraphicsData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ArenaPortal extends Portal implements IInteractiveObject {

    public function ArenaPortal(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
        name_ = "";
    }

    override public function getPanel(_arg1:GameSprite):Panel {
        return (new ArenaPortalPanel(_arg1, this));
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        super.draw(_arg1, _arg2, _arg3);
        drawName(_arg1, _arg2);
    }

    override protected function makeNameBitmapData():BitmapData {
        var _local1:StringBuilder = new StaticStringBuilder(name_);
        var _local2:BitmapTextFactory = StaticInjectorContext.getInjector().getInstance(BitmapTextFactory);
        return (_local2.make(_local1, 16, 0xFFFFFF, true, IDENTITY_MATRIX, true));
    }


}
}
