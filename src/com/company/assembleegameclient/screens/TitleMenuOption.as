package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class TitleMenuOption extends Sprite {

    protected static const OVER_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1, (220 / 0xFF), (133 / 0xFF));
    private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(0, 0, 0, 0.5, 12, 12);

    public const clicked:Signal = new Signal();
    public const textField:TextFieldDisplayConcrete = makeTextFieldDisplayConcrete();
    public const changed:Signal = textField.textChanged;

    private var colorTransform:ColorTransform;
    private var size:int;
    private var isPulse:Boolean;
    private var originalWidth:Number;
    private var originalHeight:Number;
    private var active:Boolean;
    private var color:uint = 0xFFFFFF;
    private var hoverColor:uint;

    public function TitleMenuOption(_arg1:String, _arg2:int, _arg3:Boolean) {
        this.size = _arg2;
        this.isPulse = _arg3;
        this.textField.setSize(_arg2).setColor(0xFFFFFF).setBold(true);
        this.setTextKey(_arg1);
        this.originalWidth = width;
        this.originalHeight = height;
        this.activate();
    }

    public function activate():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.CLICK, this.onMouseClick);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.active = true;
    }

    public function deactivate():void {
        var _local1:ColorTransform = new ColorTransform();
        _local1.color = 0x363636;
        this.setColorTransform(_local1);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        removeEventListener(MouseEvent.CLICK, this.onMouseClick);
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.active = false;
    }

    public function setColor(_arg1:uint):void {
        this.color = _arg1;
        var _local2:uint = ((_arg1 & 0xFF0000) >> 16);
        var _local3:uint = ((_arg1 & 0xFF00) >> 8);
        var _local4:uint = (_arg1 & 0xFF);
        var _local5:ColorTransform = new ColorTransform((_local2 / 0xFF), (_local3 / 0xFF), (_local4 / 0xFF));
        this.setColorTransform(_local5);
    }

    public function isActive():Boolean {
        return (this.active);
    }

    private function makeTextFieldDisplayConcrete():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete();
        _local1.filters = [DROP_SHADOW_FILTER];
        addChild(_local1);
        return (_local1);
    }

    public function setTextKey(_arg1:String):void {
        name = _arg1;
        this.textField.setStringBuilder(new LineBuilder().setParams(_arg1));
    }

    public function setAutoSize(_arg1:String):void {
        this.textField.setAutoSize(_arg1);
    }

    public function setVerticalAlign(_arg1:String):void {
        this.textField.setVerticalAlign(_arg1);
    }

    private function onAddedToStage(_arg1:Event):void {
        if (this.isPulse) {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        if (this.isPulse) {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local2:Number = (1.05 + (0.05 * Math.sin((getTimer() / 200))));
        this.textField.scaleX = _local2;
        this.textField.scaleY = _local2;
    }

    public function setColorTransform(_arg1:ColorTransform):void {
        if (_arg1 == this.colorTransform) {
            return;
        }
        this.colorTransform = _arg1;
        if (this.colorTransform == null) {
            this.textField.transform.colorTransform = MoreColorUtil.identity;
        }
        else {
            this.textField.transform.colorTransform = this.colorTransform;
        }
    }

    protected function onMouseOver(_arg1:MouseEvent):void {
        this.setColorTransform(OVER_COLOR_TRANSFORM);
    }

    protected function onMouseOut(_arg1:MouseEvent):void {
        if (this.color != 0xFFFFFF) {
            this.setColor(this.color);
        }
        else {
            this.setColorTransform(null);
        }
    }

    protected function onMouseClick(_arg1:MouseEvent):void {
        SoundEffectLibrary.play("button_click");
        this.clicked.dispatch();
    }

    override public function toString():String {
        return ((("[TitleMenuOption " + this.textField.getText()) + "]"));
    }

    public function createNoticeTag(_arg1:String, _arg2:int, _arg3:uint, _arg4:Boolean):void {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local5.setSize(_arg2).setColor(_arg3).setBold(_arg4);
        _local5.setStringBuilder(new LineBuilder().setParams(_arg1));
        _local5.x = (this.textField.x - 4);
        _local5.y = (this.textField.y - 20);
        addChild(_local5);
    }


}
}
