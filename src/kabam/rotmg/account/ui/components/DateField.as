package kabam.rotmg.account.ui.components {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.TextEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.lib.util.DateValidator;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class DateField extends Sprite {

    private static const BACKGROUND_COLOR:uint = 0x333333;
    private static const ERROR_BORDER_COLOR:uint = 16549442;
    private static const NORMAL_BORDER_COLOR:uint = 0x454545;
    private static const TEXT_COLOR:uint = 0xB3B3B3;
    private static const INPUT_RESTRICTION:String = "1234567890";
    private static const FORMAT_HINT_COLOR:uint = 0x555555;

    public var label:TextFieldDisplayConcrete;
    public var days:BaseSimpleText;
    public var months:BaseSimpleText;
    public var years:BaseSimpleText;
    private var dayFormatText:TextFieldDisplayConcrete;
    private var monthFormatText:TextFieldDisplayConcrete;
    private var yearFormatText:TextFieldDisplayConcrete;
    private var thisYear:int;
    private var validator:DateValidator;

    public function DateField() {
        this.validator = new DateValidator();
        this.thisYear = new Date().getFullYear();
        this.label = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3);
        this.label.setBold(true);
        this.label.setStringBuilder(new LineBuilder().setParams(name));
        this.label.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.label);
        this.months = new BaseSimpleText(20, TEXT_COLOR, true, 35, 30);
        this.months.restrict = INPUT_RESTRICTION;
        this.months.maxChars = 2;
        this.months.y = 30;
        this.months.x = 6;
        this.months.border = false;
        this.months.updateMetrics();
        this.months.addEventListener(TextEvent.TEXT_INPUT, this.onMonthInput);
        this.months.addEventListener(FocusEvent.FOCUS_OUT, this.onMonthFocusOut);
        this.months.addEventListener(Event.CHANGE, this.onEditMonth);
        this.monthFormatText = this.createFormatHint(this.months, TextKey.DATE_FIELD_MONTHS);
        addChild(this.monthFormatText);
        addChild(this.months);
        this.days = new BaseSimpleText(20, TEXT_COLOR, true, 35, 30);
        this.days.restrict = INPUT_RESTRICTION;
        this.days.maxChars = 2;
        this.days.y = 30;
        this.days.x = 63;
        this.days.border = false;
        this.days.updateMetrics();
        this.days.addEventListener(TextEvent.TEXT_INPUT, this.onDayInput);
        this.days.addEventListener(FocusEvent.FOCUS_OUT, this.onDayFocusOut);
        this.days.addEventListener(Event.CHANGE, this.onEditDay);
        this.dayFormatText = this.createFormatHint(this.days, TextKey.DATE_FIELD_DAYS);
        addChild(this.dayFormatText);
        addChild(this.days);
        this.years = new BaseSimpleText(20, TEXT_COLOR, true, 55, 30);
        this.years.restrict = INPUT_RESTRICTION;
        this.years.maxChars = 4;
        this.years.y = 30;
        this.years.x = 118;
        this.years.border = false;
        this.years.updateMetrics();
        this.years.restrict = INPUT_RESTRICTION;
        this.years.addEventListener(TextEvent.TEXT_INPUT, this.onYearInput);
        this.years.addEventListener(Event.CHANGE, this.onEditYear);
        this.yearFormatText = this.createFormatHint(this.years, TextKey.DATE_FIELD_YEARS);
        addChild(this.yearFormatText);
        addChild(this.years);
        this.setErrorHighlight(false);
    }

    public function setTitle(_arg1:String):void {
        this.label.setStringBuilder(new LineBuilder().setParams(_arg1));
    }

    public function setErrorHighlight(_arg1:Boolean):void {
        this.drawSimpleTextBackground(this.months, 0, 0, _arg1);
        this.drawSimpleTextBackground(this.days, 0, 0, _arg1);
        this.drawSimpleTextBackground(this.years, 0, 0, _arg1);
    }

    private function drawSimpleTextBackground(_arg1:BaseSimpleText, _arg2:int, _arg3:int, _arg4:Boolean):void {
        var _local5:uint = ((_arg4) ? ERROR_BORDER_COLOR : NORMAL_BORDER_COLOR);
        graphics.lineStyle(2, _local5, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(BACKGROUND_COLOR, 1);
        graphics.drawRect(((_arg1.x - _arg2) - 5), (_arg1.y - _arg3), (_arg1.width + (_arg2 * 2)), (_arg1.height + (_arg3 * 2)));
        graphics.endFill();
        graphics.lineStyle();
    }

    private function createFormatHint(_arg1:BaseSimpleText, _arg2:String):TextFieldDisplayConcrete {
        var _local3:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(FORMAT_HINT_COLOR);
        _local3.setTextWidth((_arg1.width + 4)).setTextHeight(_arg1.height);
        _local3.x = (_arg1.x - 6);
        _local3.y = (_arg1.y + 3);
        _local3.setStringBuilder(new LineBuilder().setParams(_arg2));
        _local3.setAutoSize(TextFieldAutoSize.CENTER);
        return (_local3);
    }

    private function onMonthInput(_arg1:TextEvent):void {
        var _local2:String = (this.months.text + _arg1.text);
        var _local3:int = int(_local2);
        if (((!((_local2 == "0"))) && (!(this.validator.isValidMonth(_local3))))) {
            _arg1.preventDefault();
        }
    }

    private function onMonthFocusOut(_arg1:FocusEvent):void {
        var _local2:int = int(this.months.text);
        if ((((_local2 < 10)) && (!((this.days.text == ""))))) {
            this.months.text = ("0" + _local2.toString());
        }
    }

    private function onEditMonth(_arg1:Event):void {
        this.monthFormatText.visible = !(this.months.text);
    }

    private function onDayInput(_arg1:TextEvent):void {
        var _local2:String = (this.days.text + _arg1.text);
        var _local3:int = int(_local2);
        if (((!((_local2 == "0"))) && (!(this.validator.isValidDay(_local3))))) {
            _arg1.preventDefault();
        }
    }

    private function onDayFocusOut(_arg1:FocusEvent):void {
        var _local2:int = int(this.days.text);
        if ((((_local2 < 10)) && (!((this.days.text == ""))))) {
            this.days.text = ("0" + _local2.toString());
        }
    }

    private function onEditDay(_arg1:Event):void {
        this.dayFormatText.visible = !(this.days.text);
    }

    private function onYearInput(_arg1:TextEvent):void {
        var _local2:String = (this.years.text + _arg1.text);
        var _local3:int = this.getEarliestYear(_local2);
        if (_local3 > this.thisYear) {
            _arg1.preventDefault();
        }
    }

    private function getEarliestYear(_arg1:String):int {
        while (_arg1.length < 4) {
            _arg1 = (_arg1 + "0");
        }
        return (int(_arg1));
    }

    private function onEditYear(_arg1:Event):void {
        this.yearFormatText.visible = !(this.years.text);
    }

    public function isValidDate():Boolean {
        var _local1:int = int(this.months.text);
        var _local2:int = int(this.days.text);
        var _local3:int = int(this.years.text);
        return (this.validator.isValidDate(_local1, _local2, _local3, 100));
    }

    public function getDate():String {
        var _local1:String = this.getFixedLengthString(this.months.text, 2);
        var _local2:String = this.getFixedLengthString(this.days.text, 2);
        var _local3:String = this.getFixedLengthString(this.years.text, 4);
        return (((((_local1 + "/") + _local2) + "/") + _local3));
    }

    private function getFixedLengthString(_arg1:String, _arg2:int):String {
        while (_arg1.length < _arg2) {
            _arg1 = ("0" + _arg1);
        }
        return (_arg1);
    }

    public function getTextChanged():Signal {
        return (this.label.textChanged);
    }


}
}
