package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;

import flash.display.IGraphicsData;

import kabam.rotmg.fortune.services.FortuneModel;

public class FortuneTeller extends Character {

    public function FortuneTeller(_arg1:XML) {
        super(_arg1);
    }

    override public function draw(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        if (FortuneModel.HAS_FORTUNES) {
            super.draw(_arg1, _arg2, _arg3);
        }
    }

    override public function drawShadow(_arg1:Vector.<IGraphicsData>, _arg2:Camera, _arg3:int):void {
        if (FortuneModel.HAS_FORTUNES) {
            super.drawShadow(_arg1, _arg2, _arg3);
        }
    }


}
}
