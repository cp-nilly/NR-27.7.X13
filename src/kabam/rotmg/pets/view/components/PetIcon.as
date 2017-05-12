package kabam.rotmg.pets.view.components {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.dialogs.Disableable;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class PetIcon extends Sprite implements TooltipAble, Disableable {

    public static const DISABLE_COLOR:uint = 0x292929;

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var bitmap:Bitmap;
    private var enabled:Boolean = true;
    private var petVO:PetVO;
    private var doShowTooltip:Boolean = false;

    public function PetIcon(_arg1:PetVO) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        super();
        this.petVO = _arg1;
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = new PetTooltip(_arg1);
    }

    public function disable():void {
        var _local1:ColorTransform = new ColorTransform();
        _local1.color = DISABLE_COLOR;
        this.bitmap.transform.colorTransform = _local1;
        this.enabled = false;
    }

    public function isEnabled():Boolean {
        return (this.enabled);
    }

    override public function dispatchEvent(_arg1:Event):Boolean {
        if (this.enabled) {
            return (super.dispatchEvent(_arg1));
        }
        return (false);
    }

    public function setBitmap(_arg1:Bitmap):void {
        this.bitmap = _arg1;
        addChild(_arg1);
    }

    public function setShowToolTipSignal(_arg1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return (this.hoverTooltipDelegate.getShowToolTip());
    }

    public function setHideToolTipsSignal(_arg1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return (this.hoverTooltipDelegate.getHideToolTips());
    }

    public function getPetVO():PetVO {
        return (this.petVO);
    }

    public function setTooltipEnabled(_arg1:Boolean):void {
        this.doShowTooltip = _arg1;
        if (!_arg1) {
        }
    }


}
}
