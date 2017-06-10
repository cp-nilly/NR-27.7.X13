package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.TemplateBuilder;

import org.osflash.signals.Signal;

public class GameObjectListItem extends Sprite {

    public var portrait:Bitmap;
    private var text:TextFieldDisplayConcrete;
    private var builder:TemplateBuilder;
    private var color:uint;
    public var isLongVersion:Boolean;
    public var go:GameObject;
    public var textReady:Signal;
    private var objname:String;
    private var type:int;
    private var level:int;
    private var accountId:String;
    private var positionClassBelow:Boolean;
    private var showAccId:Boolean;

    public function GameObjectListItem(color:uint, isLongVersion:Boolean, go:GameObject, posClassBelow:Boolean = false, showAccId:Boolean = false) {
        this.positionClassBelow = posClassBelow;
        this.showAccId = showAccId;
        this.isLongVersion = isLongVersion;
        this.color = color;
        this.portrait = new Bitmap();
        this.portrait.x = -4;
        this.portrait.y = posClassBelow ? -1 : -4;
        if (showAccId) {
            this.portrait.y = -2;
        }
        addChild(this.portrait);
        this.text = new TextFieldDisplayConcrete().setSize(13).setColor(color).setHTML(isLongVersion);
        if (!isLongVersion) {
            this.text.setTextWidth(66).setTextHeight(20).setBold(true);
        }
        this.text.x = 32;
        this.text.y = 6;
        this.text.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.text);
        this.textReady = this.text.textChanged;
        this.draw(go);
    }

    public function draw(_arg1:GameObject, _arg2:ColorTransform = null):void {
        var _local3:Boolean;
        _local3 = this.isClear();
        this.go = _arg1;
        visible = !((_arg1 == null));
        if (((visible) && (((this.hasChanged()) || (_local3))))) {
            this.redraw();
            transform.colorTransform = ((_arg2) || (MoreColorUtil.identity));
        }
    }

    public function clear():void {
        this.go = null;
        visible = false;
    }

    public function isClear():Boolean {
        return ((((this.go == null)) && ((visible == false))));
    }

    private function hasChanged():Boolean {
        var hasChanged:Boolean =
                this.go.name_ != this.objname ||
                this.go.level_ != this.level ||
                this.go.objectType_ != this.type;
        hasChanged && this.updateData();
        return hasChanged;
    }

    private function updateData():void {
        this.objname = this.go.name_;
        this.level = this.go.level_;
        this.type = this.go.objectType_;
        if(this.go is Player)
        {
            var player:Player = this.go as Player;
            this.accountId = player.accountId_;
        }
    }

    private function redraw():void {
        this.portrait.bitmapData = this.go.getPortrait();
        this.text.setStringBuilder(this.prepareText());
        this.text.setColor(this.getDrawColor());
        this.text.update();
    }

    private function prepareText():TemplateBuilder {
        this.builder = ((this.builder) || (new TemplateBuilder()));
        if (this.isLongVersion) {
            this.applyLongTextToBuilder();
        }
        else {
            if (this.isNameDefined()) {
                this.builder.setTemplate(this.objname);
            }
            else {
                this.builder.setTemplate(ObjectLibrary.typeToDisplayId_[this.type]);
            }
        }
        return (this.builder);
    }

    private function applyLongTextToBuilder():void {
        var charDesc:String;
        var tokens:Object = {};
        if (this.isNameDefined()) {
            if (this.positionClassBelow) {
                charDesc = "<b>{name}</b>\n({type}{level})";
            }
            else {
                charDesc = "<b>{name}</b> ({type}{level})";
            }
            if (this.showAccId) {
                charDesc += "{accountId}";
            }
            if (this.go.name_.length > 8 && !this.positionClassBelow) {
                tokens.name = (this.go.name_.slice(0, 6) + "...");
            }
            else {
                tokens.name = this.go.name_;
            }
            tokens.type = ObjectLibrary.typeToDisplayId_[this.type];
            tokens.level = this.level < 1 ? "" : " " + this.level;
            tokens.accountId = this.accountId ? "\n<b>Account ID:</b> " + this.accountId : "";
        }
        else {
            charDesc = "<b>{name}</b>";
            tokens.name = ObjectLibrary.typeToDisplayId_[this.type];
        }
        this.builder.setTemplate(charDesc, tokens);
    }

    private function isNameDefined():Boolean {
        return (((!((this.go.name_ == null))) && (!((this.go.name_ == "")))));
    }

    private function getDrawColor():int {
        var _local1:Player = (this.go as Player);
        if (_local1 == null) {
            return (this.color);
        }
        if (_local1.isFellowGuild_) {
            return (Parameters.FELLOW_GUILD_COLOR);
        }
        if (_local1.nameChosen_) {
            return (Parameters.NAME_CHOSEN_COLOR);
        }
        return (this.color);
    }


}
}
