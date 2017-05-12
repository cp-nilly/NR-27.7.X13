package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

class EnemyChooser extends Chooser {

    private var cache:Dictionary;
    private var lastSearch:String = "";
    private var filterTypes:Dictionary;

    public function EnemyChooser(_arg1:String = "") {
        this.filterTypes = new Dictionary(true);
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.reloadObjects(_arg1, "", 0, -1, true);
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[0]] = "";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[1]] = "MaxHitPoints";
        this.filterTypes[ObjectLibrary.ENEMY_FILTER_LIST[2]] = ObjectLibrary.ENEMY_FILTER_LIST[2];
    }

    public function getLastSearch():String {
        return (this.lastSearch);
    }

    public function reloadObjects(_arg1:String, _arg2:String = "", _arg3:Number = 0, _arg4:Number = -1, _arg5:Boolean = false):void {
        var _local8:XML;
        var _local11:RegExp;
        var _local13:String;
        var _local14:int;
        var _local15:ObjectElement;
        if (!_arg5) {
            removeElements();
        }
        this.lastSearch = _arg1;
        var _local6:Boolean = true;
        var _local7:Boolean = true;
        var _local9:Number = -1;
        var _local10:Vector.<String> = new Vector.<String>();
        if (_arg1 != "") {
            _local11 = new RegExp(_arg1, "gix");
        }
        if (_arg2 != "") {
            _arg2 = this.filterTypes[_arg2];
        }
        var _local12:Dictionary = GroupDivider.GROUPS["Enemies"];
        for each (_local8 in _local12) {
            _local13 = String(_local8.@id);
            if (!((!((_local11 == null))) && ((_local13.search(_local11) < 0)))) {
                if (_arg2 != "") {
                    _local9 = ((_local8.hasOwnProperty(_arg2)) ? Number(_local8.elements(_arg2)) : -1);
                    if (_local9 < 0) continue;
                    _local6 = (((_local9) < _arg3) ? false : true);
                    _local7 = (((((_arg4 > 0)) && ((_local9 > _arg4)))) ? false : true);
                }
                if (((_local6) && (_local7))) {
                    _local10.push(_local13);
                }
            }
        }
        _local10.sort(MoreStringUtil.cmp);
        for each (_local13 in _local10) {
            _local14 = ObjectLibrary.idToType_[_local13];
            if (!this.cache[_local14]) {
                _local15 = new ObjectElement(ObjectLibrary.xmlLibrary_[_local14]);
                this.cache[_local14] = _local15;
            }
            else {
                _local15 = this.cache[_local14];
            }
            addElement(_local15);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }


}
}
