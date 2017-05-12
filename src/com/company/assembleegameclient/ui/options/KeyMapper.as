package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreColorUtil;

import flash.events.Event;

public class KeyMapper extends BaseOption {

    private var keyCodeBox_:KeyCodeBox;
    private var disabled_:Boolean;

    public function KeyMapper(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean = false) {
        super(_arg1, _arg2, _arg3);
        this.keyCodeBox_ = new KeyCodeBox(Parameters.data_[paramName_]);
        this.keyCodeBox_.addEventListener(Event.CHANGE, this.onChange);
        addChild(this.keyCodeBox_);
        this.setDisabled(_arg4);
    }

    public function setDisabled(_arg1:Boolean):void {
        this.disabled_ = _arg1;
        transform.colorTransform = ((this.disabled_) ? MoreColorUtil.darkCT : MoreColorUtil.identity);
        mouseEnabled = !(this.disabled_);
        mouseChildren = !(this.disabled_);
    }

    override public function refresh():void {
        this.keyCodeBox_.setKeyCode(Parameters.data_[paramName_]);
    }

    private function onChange(_arg1:Event):void {
        Parameters.setKey(paramName_, this.keyCodeBox_.value());
        Parameters.save();
    }


}
}
