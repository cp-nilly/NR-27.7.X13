package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.lib.ui.api.Size;
import kabam.rotmg.util.components.VerticalScrollingList;

public class GridList extends Sprite {

    public var list:VerticalScrollingList;
    private var size:Size;
    private var row:Sprite;
    private var rows:Vector.<DisplayObject>;
    private var items:Array;
    private var lastItemRight:int;
    private var padding:int;
    private var grid:Array;
    private var maxItemsPerRow:int;

    public function GridList() {
        this.list = new VerticalScrollingList();
        super();
    }

    public function setSize(_arg1:Size):void {
        this.size = _arg1;
        this.list.setSize(_arg1);
        addChild(this.list);
    }

    public function setPadding(_arg1:int):void {
        this.padding = _arg1;
        this.list.setPadding(_arg1);
    }

    public function setItems(_arg1:Vector.<PetItem>):void {
        var _local2:DisplayObject;
        this.makeNewList();
        for each (_local2 in _arg1) {
            this.addItem(_local2);
        }
        this.list.setItems(this.rows);
        if (!_arg1.length) {
            return;
        }
        var _local3:DisplayObject = _arg1[0];
        this.maxItemsPerRow = (this.maxRowWidth() / _local3.width);
    }

    public function getSize():Size {
        return (this.size);
    }

    public function getItems():Array {
        return (this.items);
    }

    public function getItem(_arg1:int):DisplayObject {
        return (this.items[_arg1]);
    }

    private function makeNewList():void {
        this.grid = [];
        this.items = [];
        this.rows = new Vector.<DisplayObject>();
        this.lastItemRight = 0;
        this.addRow();
    }

    private function addItem(_arg1:DisplayObject):void {
        this.position(_arg1);
        this.row.addChild(_arg1);
        this.items.push(_arg1);
        this.grid[(this.grid.length - 1)].push(_arg1);
    }

    private function position(_arg1:DisplayObject):void {
        if (this.exceedsWidthFor(_arg1)) {
            _arg1.x = 0;
            this.addRow();
        }
        else {
            this.positionRightOfPrevious(_arg1);
        }
        this.lastItemRight = (_arg1.x + _arg1.width);
        this.lastItemRight = (this.lastItemRight + this.padding);
    }

    private function addRow():void {
        this.row = new Sprite();
        this.rows.push(this.row);
        this.grid.push([]);
    }

    private function positionRightOfPrevious(_arg1:DisplayObject):void {
        _arg1.x = this.lastItemRight;
    }

    private function exceedsWidthFor(_arg1:DisplayObject):Boolean {
        return (((this.lastItemRight + _arg1.width) > this.maxRowWidth()));
    }

    private function maxRowWidth():int {
        return ((this.size.width - VerticalScrollingList.SCROLLBAR_GUTTER));
    }

    public function getTopLeft():DisplayObject {
        if (this.items.length) {
            return (this.items[0]);
        }
        return (null);
    }

    public function getTopRight():DisplayObject {
        var _local1:Array;
        if (this.grid.length) {
            _local1 = this.grid[0];
            return (_local1[(this.maxItemsPerRow - 1)]);
        }
        return (null);
    }

    public function getBottomLeft():DisplayObject {
        var _local1:Array;
        if (this.grid.length >= 2) {
            _local1 = this.grid[(this.grid.length - 1)];
            return (_local1[0]);
        }
        return (null);
    }

    public function getBottomRight():DisplayObject {
        var _local1:Array;
        if (this.grid.length >= 2) {
            _local1 = this.grid[(this.grid.length - 1)];
            return (_local1[(this.maxItemsPerRow - 1)]);
        }
        return (null);
    }


}
}
