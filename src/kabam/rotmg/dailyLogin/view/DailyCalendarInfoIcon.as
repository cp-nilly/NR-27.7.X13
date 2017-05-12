package kabam.rotmg.dailyLogin.view {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class DailyCalendarInfoIcon extends Sprite implements TooltipAble {

    protected static const mouseOverCT:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));

    public var hoverTooltipDelegate:HoverTooltipDelegate;
    private var toolTip_:TextToolTip = null;

    public function DailyCalendarInfoIcon(_arg1:String = "", _arg2:String = "", _arg3:Object = null) {
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        super();
        var _local4:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(CalendarSettings.TABS_FONT_SIZE).setColor(0xFFFFFF).setTextWidth(15).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setSize(22);
        _local4.setStringBuilder(new StaticStringBuilder("i"));
        addChild(_local4);
        if (_arg1 != "") {
            this.setToolTipTitle(_arg1, _arg2, _arg3);
        }
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this.toolTip_ = null;
        this.hoverTooltipDelegate.removeDisplayObject();
        this.hoverTooltipDelegate = null;
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    private function setToolTipTitle(_arg1:String, _arg2:String, _arg3:Object):void {
        this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, _arg1, _arg2, 200, _arg3);
        this.hoverTooltipDelegate.setDisplayObject(this);
        this.hoverTooltipDelegate.tooltip = this.toolTip_;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
    }

    protected function onMouseOver(_arg1:MouseEvent):void {
        transform.colorTransform = mouseOverCT;
    }

    protected function onMouseOut(_arg1:MouseEvent):void {
        transform.colorTransform = MoreColorUtil.identity;
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


}
}
