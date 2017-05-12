package com.company.assembleegameclient.tutorial {
public class Step {

    public var text_:String;
    public var action_:String;
    public var uiDrawBoxes_:Vector.<UIDrawBox>;
    public var uiDrawArrows_:Vector.<UIDrawArrow>;
    public var reqs_:Vector.<Requirement>;
    public var satisfiedSince_:int = 0;

    public function Step(_arg1:XML) {
        var _local2:XML;
        var _local3:XML;
        var _local4:XML;
        this.uiDrawBoxes_ = new Vector.<UIDrawBox>();
        this.uiDrawArrows_ = new Vector.<UIDrawArrow>();
        this.reqs_ = new Vector.<Requirement>();
        super();
        for each (_local2 in _arg1.UIDrawBox) {
            this.uiDrawBoxes_.push(new UIDrawBox(_local2));
        }
        for each (_local3 in _arg1.UIDrawArrow) {
            this.uiDrawArrows_.push(new UIDrawArrow(_local3));
        }
        for each (_local4 in _arg1.Requirement) {
            this.reqs_.push(new Requirement(_local4));
        }
    }

    public function toString():String {
        return ((("[" + this.text_) + "]"));
    }


}
}
