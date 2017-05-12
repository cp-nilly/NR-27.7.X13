package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.objects.ObjectLibrary;

public class Requirement {

    public var type_:String;
    public var slot_:int = -1;
    public var objectType_:int = -1;
    public var objectName_:String = "";
    public var radius_:Number = 1;

    public function Requirement(_arg1:XML) {
        this.type_ = String(_arg1);
        var _local2:String = String(_arg1.@objectId);
        if (((!((_local2 == null))) && (!((_local2 == ""))))) {
            this.objectType_ = ObjectLibrary.idToType_[_local2];
        }
        this.objectName_ = String(_arg1.@objectName).replace("tutorial_script", "tutorial");
        if (this.objectName_ == null) {
            this.objectName_ = "";
        }
        this.slot_ = int(_arg1.@slot);
        this.radius_ = Number(_arg1.@radius);
    }

}
}
