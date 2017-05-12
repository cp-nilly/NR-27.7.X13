package kabam.rotmg.friends.view {
import com.company.assembleegameclient.ui.Scrollbar;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

public class FriendListContainer extends Sprite {

    private const GAP_Y:int = 3;

    private var _currentY:int;
    private var _width:Number;
    private var _height:Number;
    private var _itemContainer:Sprite;
    private var _scrollbar:Scrollbar;

    public function FriendListContainer(_arg1:Number, _arg2:Number) {
        this._currentY = 0;
        this._width = _arg1;
        this._height = _arg2;
        var _local3:Shape = new Shape();
        _local3.graphics.beginFill(2245785);
        _local3.graphics.drawRect(0, 0, this._width, this._height);
        _local3.graphics.endFill();
        addChild(_local3);
        this.mask = _local3;
        this._itemContainer = new Sprite();
        addChild(this._itemContainer);
        this._scrollbar = new Scrollbar(16, this._height);
        this._scrollbar.x = (this._width - 18);
        this._scrollbar.y = 0;
        this._scrollbar.visible = false;
        this._scrollbar.addEventListener(Event.CHANGE, this.onScrollBarChange);
        addChild(this._scrollbar);
    }

    public function addListItem(_arg1:FListItem):void {
        _arg1.y = this._currentY;
        this._itemContainer.addChild(_arg1);
        this._currentY = (this._currentY + (_arg1.height + this.GAP_Y));
        this.updateScrollbar((this._currentY > this._height));
    }

    public function getTotal():int {
        return (this._itemContainer.numChildren);
    }

    override public function getChildAt(_arg1:int):DisplayObject {
        return ((this._itemContainer.getChildAt(_arg1) as Sprite));
    }

    override public function removeChildAt(_arg1:int):DisplayObject {
        var _local2:Sprite = (this._itemContainer.getChildAt(_arg1) as Sprite);
        if (_local2 != null) {
            this._currentY = (this._currentY - (_local2.height + this.GAP_Y));
        }
        return ((this._itemContainer.removeChildAt(_arg1) as Sprite));
    }

    public function clear():void {
        while (this._itemContainer.numChildren > 0) {
            this._itemContainer.removeChildAt((this._itemContainer.numChildren - 1));
        }
        this._currentY = 0;
    }

    private function updateScrollbar(_arg1:Boolean):void {
        this._scrollbar.visible = _arg1;
        if (_arg1) {
            this._scrollbar.setIndicatorSize(this._height, this._currentY);
        }
    }

    private function onScrollBarChange(_arg1:Event):void {
        this._itemContainer.y = (-(this._scrollbar.pos()) * ((this._itemContainer.height - this._height) + 20));
    }


}
}
