package kabam.rotmg.classes.view {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.util.components.VerticalScrollingList;

public class CharacterSkinListView extends Sprite {

    public static const PADDING:int = 5;
    public static const WIDTH:int = 442;
    public static const HEIGHT:int = 400;

    private const list:VerticalScrollingList = makeList();

    private var items:Vector.<DisplayObject>;


    private function makeList():VerticalScrollingList {
        var _local1:VerticalScrollingList = new VerticalScrollingList();
        _local1.setSize(new Size(WIDTH, HEIGHT));
        _local1.scrollStateChanged.add(this.onScrollStateChanged);
        _local1.setPadding(PADDING);
        addChild(_local1);
        return (_local1);
    }

    public function setItems(_arg1:Vector.<DisplayObject>):void {
        this.items = _arg1;
        this.list.setItems(_arg1);
        this.onScrollStateChanged(this.list.isScrollbarVisible());
    }

    private function onScrollStateChanged(_arg1:Boolean):void {
        var _local3:CharacterSkinListItem;
        var _local2:int = CharacterSkinListItem.WIDTH;
        if (!_arg1) {
            _local2 = (_local2 + VerticalScrollingList.SCROLLBAR_GUTTER);
        }
        for each (_local3 in this.items) {
            _local3.setWidth(_local2);
        }
    }

    public function getListHeight():Number {
        return (this.list.getListHeight());
    }


}
}
