package kabam.rotmg.packages.view {
import com.company.assembleegameclient.util.TimeUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.UIUtils;

import org.osflash.signals.Signal;

public class PackageButton extends BasePackageButton {

    private const SHOW_DURATION:String = "showDuration";
    private const SHOW_QUANTITY:String = "showQuantity";

    public var clicked:Signal;
    private var _state:String = "showDuration";
    private var _icon:DisplayObject;
    var durationText:TextFieldDisplayConcrete;
    var quantityText:TextFieldDisplayConcrete;
    var quantityStringBuilder:StaticStringBuilder;
    var durationStringBuilder:LineBuilder;

    public function PackageButton() {
        this.clicked = new Signal();
        this.durationText = makeText();
        this.quantityText = makeText();
        this.quantityStringBuilder = new StaticStringBuilder("");
        this.durationStringBuilder = new LineBuilder();
        super();
    }

    private static function makeText():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF);
        _local1.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local1);
    }


    public function init():void {
        addChild(UIUtils.makeStaticHUDBackground());
        addChild(this.durationText);
        addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        this.setIcon(makeIcon());
    }

    private function setState(_arg1:String):void {
        if (this._state == _arg1) {
            return;
        }
        if (_arg1 == this.SHOW_DURATION) {
            removeChild(this.quantityText);
            addChild(this.durationText);
        }
        else {
            if (_arg1 == this.SHOW_QUANTITY) {
                removeChild(this.durationText);
                addChild(this.quantityText);
            }
            else {
                throw (new Error(("PackageButton.setState: Unexpected state " + _arg1)));
            }
        }
        this._state = _arg1;
    }

    public function setQuantity(_arg1:int):void {
        if (_arg1 == PackageInfo.INFINITE) {
            this.setState(this.SHOW_DURATION);
        }
        else {
            this.setState(this.SHOW_QUANTITY);
        }
        this.quantityText.textChanged.addOnce(this.layout);
        this.quantityStringBuilder.setString(_arg1.toString());
        this.quantityText.setStringBuilder(this.quantityStringBuilder);
    }

    public function setDuration(_arg1:int):void {
        var _local3:String;
        var _local2:int = Math.ceil((_arg1 / TimeUtil.DAY_IN_MS));
        if (_local2 > 1) {
            _local3 = TextKey.PACKAGE_BUTTON_DAYS;
        }
        else {
            _local3 = TextKey.PACKAGE_BUTTON_DAY;
        }
        this.durationText.textChanged.addOnce(this.layout);
        this.durationStringBuilder.setParams(_local3, {"number": _local2});
        this.durationText.setStringBuilder(this.durationStringBuilder);
    }

    private function layout():void {
        positionText(this._icon, this.durationText);
        positionText(this._icon, this.quantityText);
    }

    public function setIcon(_arg1:DisplayObject):void {
        this._icon = _arg1;
        addChild(_arg1);
    }

    public function getIcon():DisplayObject {
        return (this._icon);
    }

    private function onMouseUp(_arg1:Event):void {
        this.clicked.dispatch();
    }


}
}
