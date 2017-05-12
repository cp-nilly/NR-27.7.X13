package kabam.rotmg.pets.view.components.slot {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.DisplayHierarchy;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.pets.view.FeedPetView;
import kabam.rotmg.pets.view.FusePetView;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class FoodFeedFuseSlot extends FeedFuseSlot {

    public const foodLoaded:Signal = new Signal(int);
    public const foodUnloaded:Signal = new Signal();

    public var processing:Boolean = false;
    private var cancelCallback:Function;
    protected var grayscaleMatrix:ColorMatrixFilter;
    public var empty:Boolean = true;

    public function FoodFeedFuseSlot() {
        this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
        super();
        itemSprite.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.updateTitle();
    }

    public function setProcessing(_arg1:Boolean):void {
        var _local2:ColorTransform;
        if (this.processing != _arg1) {
            this.processing = _arg1;
            itemSprite.filters = ((_arg1) ? [this.grayscaleMatrix] : []);
            _local2 = ((_arg1) ? MoreColorUtil.darkCT : new ColorTransform());
            itemSprite.transform.colorTransform = _local2;
        }
    }

    override protected function onRemovedFromStage(_arg1:Event):void {
        super.onRemovedFromStage(_arg1);
        this.clearAndCallCancel();
    }

    public function setItem(_arg1:int, _arg2:int, _arg3:int, _arg4:Function):void {
        if (this.itemId != _arg1) {
            this.clearAndCallCancel();
            this.itemId = _arg1;
            this.slotId = _arg2;
            this.objectId = _arg3;
            itemBitmap.bitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg1, 80, true);
            alignBitmapInBox();
            this.updateTitle();
            this.cancelCallback = _arg4;
        }
    }

    public function setItemPart2(_arg1:int):void {
        this.foodLoaded.dispatch(_arg1);
    }

    public function updateTitle():void {
        var _local1:XML;
        var _local2:String;
        if (((itemId) && (!((itemId == -1))))) {
            setTitle(TextKey.PETORFOODSLOT_ITEM_POWER, {});
            _local1 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemId));
            _local2 = ((_local1.hasOwnProperty("feedPower")) ? _local1.feedPower : "0");
            setSubtitle(TextKey.BLANK, {"data": _local2});
        }
        else {
            setTitle(TextKey.PETORFOODSLOT_PLACE_ITEM, {});
            setSubtitle(TextKey.BLANK, {"data": ""});
        }
    }

    public function setCancelCallback(_arg1:Function):void {
        this.cancelCallback = _arg1;
    }

    public function clearItem():void {
        this.clearAndCallCancel();
        itemId = ItemConstants.NO_ITEM;
        itemBitmap.bitmapData = null;
        slotId = -1;
        objectId = -1;
        this.updateTitle();
    }

    private function clearAndCallCancel():void {
        ((this.cancelCallback) && (this.cancelCallback()));
        this.cancelCallback = null;
    }

    private function alignBitmapOnMouse(_arg1:int, _arg2:int):void {
        itemBitmap.x = (-(itemBitmap.width) / 2);
        itemBitmap.y = (-(itemBitmap.height) / 2);
        itemSprite.x = _arg1;
        itemSprite.y = _arg2;
    }

    private function onMouseDown(_arg1:MouseEvent):void {
        if (!this.processing) {
            this.alignBitmapOnMouse(_arg1.stageX, _arg1.stageY);
            itemSprite.startDrag(true);
            itemSprite.addEventListener(MouseEvent.MOUSE_UP, this.endDrag);
            if (((!((itemSprite.parent == null))) && (!((itemSprite.parent == stage))))) {
                removeChild(itemSprite);
                stage.addChild(itemSprite);
            }
        }
    }

    private function endDrag(_arg1:MouseEvent):void {
        itemSprite.stopDrag();
        itemSprite.removeEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        stage.removeChild(itemSprite);
        addChild(itemSprite);
        alignBitmapInBox();
        var _local2:* = DisplayHierarchy.getParentWithTypeArray(itemSprite.dropTarget, FeedPetView, FusePetView, ModalItemSlot);
        if (((((!((_local2 is FeedPetView))) && (!((_local2 is FusePetView))))) && (!((((_local2 is ModalItemSlot)) && (((_local2 as ModalItemSlot).interactable == true))))))) {
            this.empty = true;
            itemId = ItemConstants.NO_ITEM;
            itemBitmap.bitmapData = null;
            this.clearAndCallCancel();
            this.foodUnloaded.dispatch();
            this.updateTitle();
        }
    }


}
}
