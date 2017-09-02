package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;

import kabam.rotmg.assets.emotes.EmoteHelper;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

public class SpeechBalloon extends Sprite implements IMapOverlayElement {

    public var go_:GameObject;
    public var lifetime_:int;
    public var hideable_:Boolean;
    public var offset_:Point = new Point();
    public var text_:Sprite;
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var senderName:String;
    private var isTrade:Boolean;
    private var isGuild:Boolean;
    private var startTime_:int = 0;

    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

    public function SpeechBalloon(go:GameObject, text:String, name:String, istrade:Boolean, isguild:Boolean, bgFillColor:uint, bgFillAlpha:Number, olFillColor:uint, olFillAlpha:Number, color:uint, lifetime:int, bold:Boolean, hideable:Boolean) {
        super();
        this.go_ = go;
        this.senderName = name;
        this.isTrade = istrade;
        this.isGuild = isguild;
        this.lifetime_ = (lifetime * 1000);
        this.hideable_ = hideable;
        this.text_ = makeTextSprite(text, bold, color);
        this.text_.y = text_.y;
        addChild(this.text_);
        var _local15:int = (this.text_.width);
        this.offset_.x = (-(_local15) / 2);
        this.backgroundFill_.color = bgFillColor;
        this.backgroundFill_.alpha = bgFillAlpha;
        this.outlineFill_.color = olFillColor;
        this.outlineFill_.alpha = olFillAlpha;
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, (_local15 + 12), (height + 12), 4, [1, 1, 1, 1], this.path_);
        this.path_.commands.splice(6, 0, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO);
        var _local16:int = height;
        this.path_.data.splice(12, 0, ((_local15 / 2) + 8), (_local16 + 6), (_local15 / 2), (_local16 + 18), ((_local15 / 2) - 8), (_local16 + 6));
        graphics.drawGraphicsData(this.graphicsData_);
        filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
        this.offset_.y = ((-(height) - ((this.go_.texture_.height * (go.size_ / 100)) * 5)) - 2);
        visible = false;
        addEventListener(MouseEvent.RIGHT_CLICK, this.onSpeechBalloonRightClicked);
    }

    private function onSpeechBalloonRightClicked(e:MouseEvent):void {
        var hmod:HUDModel;
        var aPlayer:Player;
        var playerObjectId:int = this.go_.objectId_;
        try {
            hmod = StaticInjectorContext.getInjector().getInstance(HUDModel);
            if (((((!((hmod.gameSprite.map.goDict_[playerObjectId] == null))) && ((hmod.gameSprite.map.goDict_[playerObjectId] is Player)))) && (!((hmod.gameSprite.map.player_.objectId_ == playerObjectId))))) {
                aPlayer = (hmod.gameSprite.map.goDict_[playerObjectId] as Player);
                hmod.gameSprite.addChatPlayerMenu(aPlayer, e.stageX, e.stageY);
            }
            else {
                if (((((((!(this.isTrade)) && (!((this.senderName == null))))) && (!((this.senderName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.senderName))))) {
                    hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.senderName, this.isGuild);
                }
                else {
                    if (((((((this.isTrade) && (!((this.senderName == null))))) && (!((this.senderName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.senderName))))) {
                        hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.senderName, false, true);
                    }
                }
            }
        }
        catch (e:Error) {
        }
    }

    public function draw(_arg1:Camera, _arg2:int):Boolean {
        if (this.startTime_ == 0) {
            this.startTime_ = _arg2;
        }
        var _local3:int = (_arg2 - this.startTime_);
        if ((((_local3 > this.lifetime_)) || (((!((this.go_ == null))) && ((this.go_.map_ == null)))))) {
            return (false);
        }
        if ((((this.go_ == null)) || (!(this.go_.drawn_)))) {
            visible = false;
            return (true);
        }
        if (((this.hideable_) && (!(Parameters.data_.textBubbles)))) {
            visible = false;
            return (true);
        }
        visible = true;
        x = int((this.go_.posS_[0] + this.offset_.x));
        y = int((this.go_.posS_[1] + this.offset_.y));
        return (true);
    }

    public function makeTextSprite(text:String, bold:Boolean, color:uint):Sprite {
        var emoteHelper:EmoteHelper = new EmoteHelper();
        return emoteHelper.getBubbleText(text, bold, color);
    }

    public function getGameObject():GameObject {
        return (this.go_);
    }

    public function dispose():void {
        parent.removeChild(this);
    }


}
}
