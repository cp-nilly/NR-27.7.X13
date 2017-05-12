package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.Event;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceOption extends BaseOption {

    private var callback_:Function;
    private var choiceBox_:ChoiceBox;

    public function ChoiceOption(_arg1:String, _arg2:Vector.<StringBuilder>, _arg3:Array, _arg4:String, _arg5:String, _arg6:Function, _arg7:Number = 0xFFFFFF) {
        super(_arg1, _arg4, _arg5);
        desc_.setColor(_arg7);
        tooltip_.tipText_.setColor(_arg7);
        this.callback_ = _arg6;
        this.choiceBox_ = new ChoiceBox(_arg2, _arg3, Parameters.data_[paramName_], _arg7);
        this.choiceBox_.addEventListener(Event.CHANGE, this.onChange);
        addChild(this.choiceBox_);
    }

    override public function refresh():void {
        this.choiceBox_.setValue(Parameters.data_[paramName_]);
    }

    public function refreshNoCallback():void {
        this.choiceBox_.setValue(Parameters.data_[paramName_], false);
    }

    private function onChange(_arg1:Event):void {
        Parameters.data_[paramName_] = this.choiceBox_.value();
        if (this.callback_ != null) {
            this.callback_();
        }
        Parameters.save();
    }


}
}
