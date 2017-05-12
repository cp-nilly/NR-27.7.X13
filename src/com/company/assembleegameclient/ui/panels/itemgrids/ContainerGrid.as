package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;

public class ContainerGrid extends ItemGrid {

    private const NUM_SLOTS:uint = 8;

    private var tiles:Vector.<InteractiveItemTile>;

    public function ContainerGrid(_arg1:GameObject, _arg2:Player) {
        var _local4:InteractiveItemTile;
        super(_arg1, _arg2, 0);
        this.tiles = new Vector.<InteractiveItemTile>(this.NUM_SLOTS);
        var _local3:int;
        while (_local3 < this.NUM_SLOTS) {
            _local4 = new InteractiveItemTile((_local3 + indexOffset), this, interactive);
            addToGrid(_local4, 2, _local3);
            this.tiles[_local3] = _local4;
            _local3++;
        }
    }

    override public function setItems(_arg1:Vector.<int>, _arg2:int = 0):void {
        var _local3:Boolean;
        var _local4:int;
        var _local5:int;
        if (_arg1) {
            _local3 = false;
            _local4 = _arg1.length;
            _local5 = 0;
            while (_local5 < this.NUM_SLOTS) {
                if ((_local5 + indexOffset) < _local4) {
                    if (this.tiles[_local5].setItem(_arg1[(_local5 + indexOffset)])) {
                        _local3 = true;
                    }
                }
                else {
                    if (this.tiles[_local5].setItem(-1)) {
                        _local3 = true;
                    }
                }
                _local5++;
            }
            if (_local3) {
                refreshTooltip();
            }
        }
    }


}
}
