package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.game.AGameSprite;

public function doneAction(_arg1:AGameSprite, _arg2:String):void {
    if (_arg1.tutorial_ == null) {
        return;
    }
    _arg1.tutorial_.doneAction(_arg2);
}

}
