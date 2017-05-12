package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.natives.NativeSignal;

public class StatView extends Sprite {

    public var fullName_:String;
    public var description_:String;
    public var nameText_:TextFieldDisplayConcrete;
    public var valText_:TextFieldDisplayConcrete;
    public var redOnZero_:Boolean;
    public var val_:int = -1;
    public var boost_:int = -1;
    public var valColor_:uint = 0xB3B3B3;
    public var toolTip_:TextToolTip;
    public var mouseOver:NativeSignal;
    public var mouseOut:NativeSignal;

    public function StatView(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean) {
        this.toolTip_ = new TextToolTip(0x363636, 0x9B9B9B, "", "", 200);
        super();
        this.fullName_ = _arg2;
        this.description_ = _arg3;
        this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg1));
        this.configureTextAndAdd(this.nameText_);
        this.valText_ = new TextFieldDisplayConcrete().setSize(13).setColor(this.valColor_).setBold(true);
        this.valText_.setStringBuilder(new StaticStringBuilder("-"));
        this.configureTextAndAdd(this.valText_);
        this.redOnZero_ = _arg4;
        this.mouseOver = new NativeSignal(this, MouseEvent.MOUSE_OVER, MouseEvent);
        this.mouseOut = new NativeSignal(this, MouseEvent.MOUSE_OUT, MouseEvent);
    }

    public function configureTextAndAdd(_arg1:TextFieldDisplayConcrete):void {
        _arg1.setAutoSize(TextFieldAutoSize.LEFT);
        _arg1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_arg1);
    }

    public function addTooltip():void {
        this.toolTip_.setTitle(new LineBuilder().setParams(this.fullName_));
        this.toolTip_.setText(new LineBuilder().setParams(this.description_));
        if (!stage.contains(this.toolTip_)) {
            stage.addChild(this.toolTip_);
        }
    }

    public function removeTooltip():void {
        if (this.toolTip_.parent != null) {
            this.toolTip_.parent.removeChild(this.toolTip_);
        }
    }

    public function draw(_arg1:int, _arg2:int, _arg3:int):void {
        var _local4:uint;
        if ((((_arg1 == this.val_)) && ((_arg2 == this.boost_)))) {
            return;
        }
        this.val_ = _arg1;
        this.boost_ = _arg2;
        if ((_arg1 - _arg2) >= _arg3) {
            _local4 = 0xFCDF00;
        }
        else {
            if (((((this.redOnZero_) && ((this.val_ <= 0)))) || ((this.boost_ < 0)))) {
                _local4 = 16726072;
            }
            else {
                if (this.boost_ > 0) {
                    _local4 = 6206769;
                }
                else {
                    _local4 = 0xB3B3B3;
                }
            }
        }
        if (this.valColor_ != _local4) {
            this.valColor_ = _local4;
            this.valText_.setColor(this.valColor_);
        }
        var _local5:String = this.val_.toString();
        if (this.boost_ != 0) {
            _local5 = (_local5 + (((" (" + (((this.boost_ > 0)) ? "+" : "")) + this.boost_.toString()) + ")"));
        }
        this.valText_.setStringBuilder(new StaticStringBuilder(_local5));
        this.valText_.x = this.nameText_.getBounds(this).right;
    }


}
}
