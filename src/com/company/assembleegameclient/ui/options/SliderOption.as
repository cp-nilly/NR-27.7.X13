package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.Event;

public class SliderOption extends BaseOption {

    private var sliderBar:VolumeSliderBar;
    private var disabled_:Boolean;
    private var callbackFunc:Function;

    public function SliderOption(_arg1:String, _arg2:Function = null, _arg3:Boolean = false) {
        super(_arg1, "", "");
        this.sliderBar = new VolumeSliderBar(Parameters.data_[paramName_]);
        this.sliderBar.addEventListener(Event.CHANGE, this.onChange);
        this.callbackFunc = _arg2;
        addChild(this.sliderBar);
        this.setDisabled(_arg3);
    }

    public function setDisabled(_arg1:Boolean):void {
        this.disabled_ = _arg1;
        mouseEnabled = !(this.disabled_);
        mouseChildren = !(this.disabled_);
    }

    override public function refresh():void {
        this.sliderBar.currentVolume = Parameters.data_[paramName_];
    }

    private function onChange(_arg1:Event):void {
        Parameters.data_[paramName_] = this.sliderBar.currentVolume;
        if (this.callbackFunc != null) {
            this.callbackFunc(this.sliderBar.currentVolume);
        }
        Parameters.save();
    }


}
}
