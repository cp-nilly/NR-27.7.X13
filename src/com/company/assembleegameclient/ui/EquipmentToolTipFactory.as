package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;

import flash.display.Sprite;

public class EquipmentToolTipFactory {


    public function make(_arg1:int, _arg2:Player, _arg3:int, _arg4:String, _arg5:uint):Sprite {
        return (new EquipmentToolTip(_arg1, _arg2, _arg3, _arg4));
    }


}
}
