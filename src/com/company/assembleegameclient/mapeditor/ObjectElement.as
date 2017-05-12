package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.animation.Animations;
import com.company.assembleegameclient.objects.animation.AnimationsData;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;

class ObjectElement extends Element {

    public var objXML_:XML;

    public function ObjectElement(_arg1:XML) {
        var _local3:Animations;
        var _local5:Bitmap;
        var _local7:BitmapData;
        super(int(_arg1.@type));
        this.objXML_ = _arg1;
        var _local2:BitmapData = ObjectLibrary.getRedrawnTextureFromType(type_, 100, true, false);
        var _local4:AnimationsData = ObjectLibrary.typeToAnimationsData_[int(_arg1.@type)];
        if (_local4 != null) {
            _local3 = new Animations(_local4);
            _local7 = _local3.getTexture(0.4);
            if (_local7 != null) {
                _local2 = _local7;
            }
        }
        _local5 = new Bitmap(_local2);
        var _local6:Number = ((WIDTH - 4) / Math.max(_local5.width, _local5.height));
        _local5.scaleX = (_local5.scaleY = _local6);
        _local5.x = ((WIDTH / 2) - (_local5.width / 2));
        _local5.y = ((HEIGHT / 2) - (_local5.height / 2));
        addChild(_local5);
    }

    override protected function getToolTip():ToolTip {
        return (new ObjectTypeToolTip(this.objXML_));
    }


}
}
