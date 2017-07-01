package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.BitmapUtil;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.utils.getTimer;

public class PortraitToolTip extends ToolTip {

    private var portrait_:Bitmap;
    public var questObj:GameObject;
    public var bar:Sprite;
    public var hMeter:Sprite;
    public var dist:int;
    public var colorTransform:ColorTransform;

    public function PortraitToolTip(_arg1:GameObject) {
        super(6036765, 1, 16549442, 1, false);
        this.portrait_ = new Bitmap();
        this.portrait_.x = 0;
        this.portrait_.y = 0;
        var _local2:BitmapData = _arg1.getPortrait();
        _local2 = BitmapUtil.cropToBitmapData(_local2, 10, 10, (_local2.width - 20), (_local2.height - 20));
        this.portrait_.bitmapData = _local2;
        addChild(this.portrait_);
        filters = [];
        this.questObj = _arg1;
        this.bar = new Sprite();
        this.bar.x = 0;
        this.bar.y = 25;
        this.hMeter = new Sprite();
        this.colorTransform = new ColorTransform(1, 1, 1, 1);
        if (Parameters.data_.enhancedQuestToolTip == true) {
            this.bar.addChild(this.hMeter);
            addChild(this.bar);
        }
    }

    public function getDist(playerX:Number, playerY:Number, questX:Number, QuestY:Number):Number {
        var x_:* = (playerX - questX);
        var y_:* = (playerY - QuestY);
        return (Math.sqrt(((y_ * y_)) + ((x_ * x_))));
    }

    public function updateDist():void {
        var gameObject:GameObject;
        var dist:int;
        var map:Map = this.questObj.map_;
        this.dist = int.MAX_VALUE;
        for each (gameObject in map.goDict_) {
            if (gameObject is Player) {
                dist = this.getDist(gameObject.x_, gameObject.y_, this.questObj.x_, this.questObj.y_);
                if (dist < this.dist) {
                    this.dist = dist;
                }
            }
        }
    }

    public function getHpColor(_arg1:int):int {
        if (_arg1 > 50) {
            return (0xFF00 + (327680 * int(100 - _arg1)));
        }
        return (0xFFFF00 - (0x0500 * int((50 - _arg1))));
    }

    public function drawBar(_arg1:int, _arg2:int, _arg3:Number = 100, _arg4:Number = 3, _arg5:uint = 0x545454, _arg6:uint = 0xFF00) {
        var _local7:Number = (_arg1 / _arg2);
        this.bar.graphics.clear();
        var bar:Graphics = this.bar.graphics;
        bar.lineStyle(0, 0x545454);
        bar.beginFill(_arg5);
        bar.lineTo(_arg3, 0);
        bar.lineTo(_arg3, _arg4);
        bar.lineTo(0, _arg4);
        bar.lineTo(0, 0);
        bar.endFill();
        _arg3 = (_arg3 * _local7);
        this.hMeter.graphics.clear();
        var hMeter:Graphics = this.hMeter.graphics;
        hMeter.lineStyle(0, 0x545454);
        hMeter.beginFill(this.getHpColor(_local7 * 100));
        hMeter.lineTo(_arg3, 0);
        hMeter.lineTo(_arg3, _arg4);
        hMeter.lineTo(0, _arg4);
        hMeter.lineTo(0, 0);
        hMeter.endFill();
    }

    override public function draw():void {
        var _local1:Number;
        if ((((Parameters.data_.enhancedQuestToolTip == true)) && (!((this.questObj.map_ == null))))) {
            this.updateDist();
            this.drawBar(this.questObj.hp_, this.questObj.maxHP_, 23);
            if (this.dist < 20) {
                _local1 = (getTimer() % 1000);
                if (_local1 < 500) {
                    _local1 = (_local1 / 500);
                }
                else {
                    _local1 = (2 - (_local1 / 500));
                }
                this.colorTransform.alphaMultiplier = _local1;
                this.bar.transform.colorTransform = this.colorTransform;
            }
            else {
                this.bar.transform.colorTransform = MoreColorUtil.identity;
            }
        }
        super.draw();
    }

}
}
