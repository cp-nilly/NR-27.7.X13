package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.web.view.LabeledField;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class Frame extends Sprite {

    private static const INDENT:Number = 17;

    public var titleText_:TextFieldDisplayConcrete;
    public var leftButton_:DeprecatedClickableText;
    public var rightButton_:DeprecatedClickableText;
    public var textInputFields_:Vector.<TextInputField> = new Vector.<TextInputField>();
    public var navigationLinks_:Vector.<DeprecatedClickableText> = new Vector.<DeprecatedClickableText>();
    public var w_:int = 288;
    public var h_:int = 100;
    private var titleFill_:GraphicsSolidFill = new GraphicsSolidFill(0x4D4D4D, 1);
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var path1_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var path2_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());

    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[backgroundFill_, path2_, GraphicsUtil.END_FILL, titleFill_, path1_, GraphicsUtil.END_FILL, lineStyle_, path2_, GraphicsUtil.END_STROKE];

    public function Frame(title:String, leftBtn:String, rightBtn:String, width:int = 288) {
        super();
        this.w_ = width;
        this.titleText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.titleText_.setStringBuilder(new LineBuilder().setParams(title));
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.titleText_.x = 5;
        this.titleText_.y = 3;
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.titleText_);
        this.makeAndAddLeftButton(leftBtn);
        this.makeAndAddRightButton(rightBtn);
        filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    private function makeAndAddLeftButton(_arg1:String):void {
        this.leftButton_ = new DeprecatedClickableText(18, true, _arg1);
        if (_arg1 != "") {
            this.leftButton_.buttonMode = true;
            this.leftButton_.x = 109;
            addChild(this.leftButton_);
        }
    }

    private function makeAndAddRightButton(_arg1:String):void {
        this.rightButton_ = new DeprecatedClickableText(18, true, _arg1);
        if (_arg1 != "") {
            this.rightButton_.buttonMode = true;
            this.rightButton_.x = ((this.w_ - this.rightButton_.width) - 26);
            this.rightButton_.setAutoSize(TextFieldAutoSize.RIGHT);
            addChild(this.rightButton_);
        }
    }

    public function addLabeledField(_arg1:LabeledField):void {
        addChild(_arg1);
        _arg1.y = (this.h_ - 60);
        _arg1.x = 17;
        this.h_ = (this.h_ + _arg1.getHeight());
    }

    public function addTextInputField(_arg1:TextInputField):void {
        this.textInputFields_.push(_arg1);
        addChild(_arg1);
        _arg1.y = (this.h_ - 60);
        _arg1.x = 17;
        this.h_ = (this.h_ + _arg1.height);
    }

    public function addNavigationText(_arg1:DeprecatedClickableText):void {
        this.navigationLinks_.push(_arg1);
        _arg1.x = INDENT;
        addChild(_arg1);
        this.positionText(_arg1);
    }

    public function addComponent(_arg1:DisplayObject, _arg2:int = 8):void {
        addChild(_arg1);
        _arg1.y = (this.h_ - 66);
        _arg1.x = _arg2;
        this.h_ = (this.h_ + _arg1.height);
    }

    public function addPlainText(plainText:String, tokens:Object = null):void {
        var text:TextFieldDisplayConcrete;
        var position:Function;
        position = function ():void {
            positionText(text);
            draw();
        };
        text = new TextFieldDisplayConcrete().setSize(12).setColor(0xFFFFFF);
        text.setStringBuilder(new LineBuilder().setParams(plainText, tokens));
        text.filters = [new DropShadowFilter(0, 0, 0)];
        text.textChanged.add(position);
        addChild(text);
    }

    protected function positionText(_arg1:DisplayObject):void {
        _arg1.y = (this.h_ - 66);
        _arg1.x = INDENT;
        this.h_ = (this.h_ + 20);
    }

    public function addTitle(_arg1:String):void {
        var _local2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(20).setColor(0xB2B2B2).setBold(true);
        _local2.setStringBuilder(new LineBuilder().setParams(_arg1));
        _local2.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(_local2);
        _local2.y = (this.h_ - 60);
        _local2.x = 15;
        this.h_ = (this.h_ + 40);
    }

    public function addCheckBox(_arg1:CheckBoxField):void {
        addChild(_arg1);
        _arg1.y = (this.h_ - 66);
        _arg1.x = INDENT;
        this.h_ = (this.h_ + 44);
    }

    public function addRadioBox(_arg1:PaymentMethodRadioButtons):void {
        addChild(_arg1);
        _arg1.y = (this.h_ - 66);
        _arg1.x = 18;
        this.h_ = (this.h_ + _arg1.height);
    }

    public function addSpace(_arg1:int):void {
        this.h_ = (this.h_ + _arg1);
    }

    public function disable():void {
        var _local1:DeprecatedClickableText;
        mouseEnabled = false;
        mouseChildren = false;
        for each (_local1 in this.navigationLinks_) {
            _local1.setDefaultColor(0xB3B3B3);
        }
        this.leftButton_.setDefaultColor(0xB3B3B3);
        this.rightButton_.setDefaultColor(0xB3B3B3);
    }

    public function enable():void {
        var _local1:DeprecatedClickableText;
        mouseEnabled = true;
        mouseChildren = true;
        for each (_local1 in this.navigationLinks_) {
            _local1.setDefaultColor(0xFFFFFF);
        }
        this.leftButton_.setDefaultColor(0xFFFFFF);
        this.rightButton_.setDefaultColor(0xFFFFFF);
    }

    protected function onAddedToStage(_arg1:Event):void {
        this.draw();
        x = ((stage.stageWidth / 2) - ((this.w_ - 6) / 2));
        y = ((stage.stageHeight / 2) - (height / 2));
        if (this.textInputFields_.length > 0) {
            stage.focus = this.textInputFields_[0].inputText_;
        }
    }

    protected function draw():void {
        graphics.clear();
        GraphicsUtil.clearPath(this.path1_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, this.w_, (20 + 12), 4, [1, 1, 0, 0], this.path1_);
        GraphicsUtil.clearPath(this.path2_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, this.w_, this.h_, 4, [1, 1, 1, 1], this.path2_);
        this.leftButton_.y = (this.h_ - 52);
        this.rightButton_.y = (this.h_ - 52);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}
