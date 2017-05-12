package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.util.ArrayIterator;
import com.company.util.IIterator;

import kabam.lib.util.VectorAS3Util;

public class EquippedGrid extends ItemGrid {

    public static const NUM_SLOTS:uint = 4;

    private var tiles:Vector.<EquipmentTile>;

    public function EquippedGrid(_arg1:GameObject, _arg2:Vector.<int>, _arg3:Player, _arg4:int = 0) {
        var _local6:EquipmentTile;
        super(_arg1, _arg3, _arg4);
        this.tiles = new Vector.<EquipmentTile>(NUM_SLOTS);
        var _local5:int;
        while (_local5 < NUM_SLOTS) {
            _local6 = new EquipmentTile(_local5, this, interactive);
            addToGrid(_local6, 1, _local5);
            _local6.setType(_arg2[_local5]);
            this.tiles[_local5] = _local6;
            _local5++;
        }
    }

    public function createInteractiveItemTileIterator():IIterator {
        return (new ArrayIterator(VectorAS3Util.toArray(this.tiles)));
    }

    override public function setItems(_arg1:Vector.<int>, _arg2:int = 0):void {
        var _local3:int;
        var _local4:int;
        if (_arg1) {
            _local3 = _arg1.length;
            _local4 = 0;
            while (_local4 < this.tiles.length) {
                if ((_local4 + _arg2) < _local3) {
                    this.tiles[_local4].setItem(_arg1[(_local4 + _arg2)]);
                }
                else {
                    this.tiles[_local4].setItem(-1);
                }
                this.tiles[_local4].updateDim(curPlayer);
                _local4++;
            }
        }
    }


}
}
