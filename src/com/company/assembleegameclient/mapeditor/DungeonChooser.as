package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.MoreStringUtil;

import flash.utils.Dictionary;

public class DungeonChooser extends Chooser {

    public var currentDungon:String = "";
    private var cache:Dictionary;
    private var lastSearch:String = "";

    public function DungeonChooser(_arg1:String = "") {
        super(Layer.OBJECT);
        this.cache = new Dictionary();
        this.reloadObjects(GroupDivider.DEFAULT_DUNGEON, _arg1, true);
    }

    public function getLastSearch():String {
        return (this.lastSearch);
    }

    public function reloadObjects(_arg1:String, _arg2:String, _arg3:Boolean = false):void {
        var _local5:RegExp;
        var _local7:String;
        var _local8:XML;
        var _local9:int;
        var _local10:ObjectElement;
        this.currentDungon = _arg1;
        if (!_arg3) {
            removeElements();
        }
        this.lastSearch = _arg2;
        var _local4:Vector.<String> = new Vector.<String>();
        if (_arg2 != "") {
            _local5 = new RegExp(_arg2, "gix");
        }
        var _local6:Dictionary = GroupDivider.getDungeonsXML(this.currentDungon);
        for each (_local8 in _local6) {
            _local7 = String(_local8.@id);
            if ((((_local5 == null)) || ((_local7.search(_local5) >= 0)))) {
                _local4.push(_local7);
            }
        }
        _local4.sort(MoreStringUtil.cmp);
        for each (_local7 in _local4) {
            _local9 = ObjectLibrary.idToType_[_local7];
            _local8 = _local6[_local9];
            if (!this.cache[_local9]) {
                _local10 = new ObjectElement(_local8);
                this.cache[_local9] = _local10;
            }
            else {
                _local10 = this.cache[_local9];
            }
            addElement(_local10);
        }
        scrollBar_.setIndicatorSize(HEIGHT, elementSprite_.height, true);
    }


}
}
