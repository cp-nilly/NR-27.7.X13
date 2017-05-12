package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

class GroundChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function GroundChooser(_arg1:String = "") {
        super(Layer.GROUND);
        this.cache = new Dictionary();
        this.reloadObjects(_arg1, "", true);
    }

    public function getLastSearch():String {
        return (this.lastSearch);
    }

    public function reloadObjects(_arg1:String, _arg2:String = "ALL", _arg3:Boolean = false):void {
        var _local5:RegExp;
        var _local7:String;
        var _local8:XML;
        var _local9:int;
        var _local10:GroundElement;
        if (!_arg3) {
            removeElements();
        }
        this.lastSearch = _arg1;
        var _local4:Vector.<String> = new Vector.<String>();
        if (_arg1 != "") {
            _local5 = new RegExp(_arg1, "gix");
        }
        var _local6:Dictionary = GroupDivider.GROUPS["Ground"];
        for each (_local8 in _local6) {
            _local7 = String(_local8.@id);
            if (!((!((_arg2 == "ALL"))) && (!(this.runFilter(_local8, _arg2))))) {
                if ((((_local5 == null)) || ((_local7.search(_local5) >= 0)))) {
                    _local4.push(_local7);
                }
            }
        }
        _local4.sort(MoreStringUtil.cmp);
        for each (_local7 in _local4) {
            _local9 = GroundLibrary.idToType_[_local7];
            _local8 = GroundLibrary.xmlLibrary_[_local9];
            if (!this.cache[_local9]) {
                _local10 = new GroundElement(_local8);
                this.cache[_local9] = _local10;
            }
            else {
                _local10 = this.cache[_local9];
            }
            addElement(_local10);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }

    private function runFilter(_arg1:XML, _arg2:String):Boolean {
        var _local3:int;
        switch (_arg2) {
            case ObjectLibrary.TILE_FILTER_LIST[1]:
                return (!(_arg1.hasOwnProperty("NoWalk")));
            case ObjectLibrary.TILE_FILTER_LIST[2]:
                return (_arg1.hasOwnProperty("NoWalk"));
            case ObjectLibrary.TILE_FILTER_LIST[3]:
                return (((_arg1.hasOwnProperty("Speed")) && ((Number(_arg1.elements("Speed")) < 1))));
            case ObjectLibrary.TILE_FILTER_LIST[4]:
                return (((!(_arg1.hasOwnProperty("Speed"))) || ((Number(_arg1.elements("Speed")) >= 1))));
        }
        return (true);
    }


}
}
