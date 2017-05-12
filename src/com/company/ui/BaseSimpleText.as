package com.company.ui {
import flash.events.Event;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

public class BaseSimpleText extends TextField {

    public static const MyriadPro:Class = BaseSimpleText_MyriadPro;

    public var inputWidth_:int;
    public var inputHeight_:int;
    public var actualWidth_:int;
    public var actualHeight_:int;

    public function BaseSimpleText(_arg1:int, _arg2:uint, _arg3:Boolean = false, _arg4:int = 0, _arg5:int = 0) {
        this.inputWidth_ = _arg4;
        if (this.inputWidth_ != 0) {
            width = _arg4;
        }
        this.inputHeight_ = _arg5;
        if (this.inputHeight_ != 0) {
            height = _arg5;
        }
        Font.registerFont(MyriadPro);
        var _local6:Font = new MyriadPro();
        var _local7:TextFormat = this.defaultTextFormat;
        _local7.font = _local6.fontName;
        _local7.bold = false;
        _local7.size = _arg1;
        _local7.color = _arg2;
        defaultTextFormat = _local7;
        if (_arg3) {
            selectable = true;
            mouseEnabled = true;
            type = TextFieldType.INPUT;
            embedFonts = true;
            border = true;
            borderColor = _arg2;
            setTextFormat(_local7);
            addEventListener(Event.CHANGE, this.onChange);
        }
        else {
            selectable = false;
            mouseEnabled = false;
        }
    }

    public function setFont(_arg1:String):void {
        var _local2:TextFormat = defaultTextFormat;
        _local2.font = _arg1;
        defaultTextFormat = _local2;
    }

    public function setSize(_arg1:int):void {
        var _local2:TextFormat = defaultTextFormat;
        _local2.size = _arg1;
        this.applyFormat(_local2);
    }

    public function setColor(_arg1:uint):void {
        var _local2:TextFormat = defaultTextFormat;
        _local2.color = _arg1;
        this.applyFormat(_local2);
    }

    public function setBold(_arg1:Boolean):void {
        var _local2:TextFormat = defaultTextFormat;
        _local2.bold = _arg1;
        this.applyFormat(_local2);
    }

    public function setAlignment(_arg1:String):void {
        var _local2:TextFormat = defaultTextFormat;
        _local2.align = _arg1;
        this.applyFormat(_local2);
    }

    public function setText(_arg1:String):void {
        this.text = _arg1;
    }

    public function setMultiLine(_arg1:Boolean):void {
        multiline = _arg1;
        wordWrap = _arg1;
    }

    private function applyFormat(_arg1:TextFormat):void {
        setTextFormat(_arg1);
        defaultTextFormat = _arg1;
    }

    private function onChange(_arg1:Event):void {
        this.updateMetrics();
    }

    public function updateMetrics():void {
        var _local2:TextLineMetrics;
        var _local3:int;
        var _local4:int;
        this.actualWidth_ = 0;
        this.actualHeight_ = 0;
        var _local1:int;
        while (_local1 < numLines) {
            _local2 = getLineMetrics(_local1);
            _local3 = (_local2.width + 4);
            _local4 = (_local2.height + 4);
            if (_local3 > this.actualWidth_) {
                this.actualWidth_ = _local3;
            }
            this.actualHeight_ = (this.actualHeight_ + _local4);
            _local1++;
        }
        width = (((this.inputWidth_) == 0) ? this.actualWidth_ : this.inputWidth_);
        height = (((this.inputHeight_) == 0) ? this.actualHeight_ : this.inputHeight_);
    }

    public function useTextDimensions():void {
        width = (((this.inputWidth_) == 0) ? (textWidth + 4) : this.inputWidth_);
        height = (((this.inputHeight_) == 0) ? (textHeight + 4) : this.inputHeight_);
    }


}
}
