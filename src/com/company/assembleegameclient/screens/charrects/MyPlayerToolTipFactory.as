package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;

public class MyPlayerToolTipFactory {


    public function create(_arg1:String, _arg2:XML, _arg3:CharacterStats):MyPlayerToolTip {
        return (new MyPlayerToolTip(_arg1, _arg2, _arg3));
    }


}
}
