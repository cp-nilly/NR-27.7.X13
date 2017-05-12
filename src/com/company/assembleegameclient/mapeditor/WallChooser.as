package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class WallChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function WallChooser(_arg1:String = "") {
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.reloadObjects(_arg1, true);
    }

    public function getLastSearch():String {
        return (this.lastSearch);
    }

    public function reloadObjects(_arg1:String = "", _arg2:Boolean = false):void {
        var _local4:RegExp;
        var _local6:String;
        var _local7:XML;
        var _local8:int;
        var _local9:ObjectElement;
        if (!_arg2) {
            removeElements();
        }
        this.lastSearch = _arg1;
        var _local3:Vector.<String> = new Vector.<String>();
        if (_arg1 != "") {
            _local4 = new RegExp(_arg1, "gix");
        }
        var _local5:Dictionary = GroupDivider.GROUPS["Walls"];
        for each (_local7 in _local5) {
            _local6 = String(_local7.@id);
            if ((((_local4 == null)) || ((_local6.search(_local4) >= 0)))) {
                _local3.push(_local6);
            }
        }
        _local3.sort(MoreStringUtil.cmp);
        for each (_local6 in _local3) {
            _local8 = ObjectLibrary.idToType_[_local6];
            _local7 = ObjectLibrary.xmlLibrary_[_local8];
            if (!this.cache[_local8]) {
                _local9 = new ObjectElement(_local7);
                this.cache[_local8] = _local9;
            }
            else {
                _local9 = this.cache[_local8];
            }
            addElement(_local9);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }


}
}
