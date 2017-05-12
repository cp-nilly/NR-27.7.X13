package kabam.rotmg.arena.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
import kabam.rotmg.util.components.VerticalScrollingList;

public class ArenaLeaderboardList extends Sprite {

    private const MAX_SIZE:int = 20;

    private var listItemPool:Vector.<DisplayObject>;
    private var scrollList:VerticalScrollingList;

    public function ArenaLeaderboardList() {
        this.listItemPool = new Vector.<DisplayObject>(this.MAX_SIZE);
        this.scrollList = new VerticalScrollingList();
        super();
        var _local1:int;
        while (_local1 < this.MAX_SIZE) {
            this.listItemPool[_local1] = new ArenaLeaderboardListItem();
            _local1++;
        }
        this.scrollList.setSize(new Size(786, 400));
        addChild(this.scrollList);
    }

    public function setItems(_arg1:Vector.<ArenaLeaderboardEntry>, _arg2:Boolean):void {
        var _local4:ArenaLeaderboardEntry;
        var _local5:ArenaLeaderboardListItem;
        var _local3:int;
        while (_local3 < this.listItemPool.length) {
            _local4 = (((_local3 < _arg1.length)) ? _arg1[_local3] : null);
            _local5 = (this.listItemPool[_local3] as ArenaLeaderboardListItem);
            _local5.apply(_local4, _arg2);
            _local3++;
        }
        this.scrollList.setItems(this.listItemPool);
    }


}
}
