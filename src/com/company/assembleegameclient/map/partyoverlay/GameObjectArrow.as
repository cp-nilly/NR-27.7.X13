package com.company.assembleegameclient.map.partyoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.ui.menu.Menu;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.util.RectangleUtil;
import com.company.util.Trig;

import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class GameObjectArrow extends Sprite {

    public static const SMALL_SIZE:int = 8;
    public static const BIG_SIZE:int = 11;
    public static const DIST:int = 3;

    private static var menu_:Menu = null;

    public var menuLayer:DisplayObjectContainer;
    public var lineColor_:uint;
    public var fillColor_:uint;
    public var go_:GameObject = null;
    public var extraGOs_:Vector.<GameObject>;
    public var mouseOver_:Boolean = false;
    private var big_:Boolean;
    private var arrow_:Shape;
    protected var tooltip_:ToolTip = null;
    private var tempPoint:Point;

    public function GameObjectArrow(_arg1:uint, _arg2:uint, _arg3:Boolean) {
        this.extraGOs_ = new Vector.<GameObject>();
        this.arrow_ = new Shape();
        this.tempPoint = new Point();
        super();
        this.lineColor_ = _arg1;
        this.fillColor_ = _arg2;
        this.big_ = _arg3;
        addChild(this.arrow_);
        this.drawArrow();
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        visible = false;
    }

    public static function removeMenu():void {
        if (menu_ != null) {
            if (menu_.parent != null) {
                menu_.parent.removeChild(menu_);
            }
            menu_ = null;
        }
    }


    protected function onMouseOver(_arg1:MouseEvent):void {
        this.mouseOver_ = true;
        this.drawArrow();
    }

    protected function onMouseOut(_arg1:MouseEvent):void {
        this.mouseOver_ = false;
        this.drawArrow();
    }

    protected function onMouseDown(_arg1:MouseEvent):void {
        _arg1.stopImmediatePropagation();
    }

    protected function setToolTip(_arg1:ToolTip):void {
        this.removeTooltip();
        this.tooltip_ = _arg1;
        if (this.tooltip_ != null) {
            addChild(this.tooltip_);
            this.positionTooltip(this.tooltip_);
        }
    }

    protected function removeTooltip():void {
        if (this.tooltip_ != null) {
            if (this.tooltip_.parent != null) {
                this.tooltip_.parent.removeChild(this.tooltip_);
            }
            this.tooltip_ = null;
        }
    }

    protected function setMenu(_arg1:Menu):void {
        this.removeTooltip();
        menu_ = _arg1;
        this.menuLayer.addChild(menu_);
    }

    public function setGameObject(_arg1:GameObject):void {
        if (this.go_ != _arg1) {
            this.go_ = _arg1;
        }
        this.extraGOs_.length = 0;
        if (this.go_ == null) {
            visible = false;
        }
    }

    public function addGameObject(_arg1:GameObject):void {
        this.extraGOs_.push(_arg1);
    }

    public function draw(_arg1:int, _arg2:Camera):void {
        var _local3:Rectangle;
        var _local4:Number;
        var _local5:Number;
        if (this.go_ == null) {
            visible = false;
            return;
        }
        this.go_.computeSortVal(_arg2);
        _local3 = _arg2.clipRect_;
        _local4 = this.go_.posS_[0];
        _local5 = this.go_.posS_[1];
        if (!RectangleUtil.lineSegmentIntersectXY(_arg2.clipRect_, 0, 0, _local4, _local5, this.tempPoint)) {
            this.go_ = null;
            visible = false;
            return;
        }
        x = this.tempPoint.x;
        y = this.tempPoint.y;
        var _local6:Number = Trig.boundTo180((270 - (Trig.toDegrees * Math.atan2(_local4, _local5))));
        if (this.tempPoint.x < (_local3.left + 5)) {
            if (_local6 > 45) {
                _local6 = 45;
            }
            if (_local6 < -45) {
                _local6 = -45;
            }
        }
        else {
            if (this.tempPoint.x > (_local3.right - 5)) {
                if (_local6 > 0) {
                    if (_local6 < 135) {
                        _local6 = 135;
                    }
                }
                else {
                    if (_local6 > -135) {
                        _local6 = -135;
                    }
                }
            }
        }
        if (this.tempPoint.y < (_local3.top + 5)) {
            if (_local6 < 45) {
                _local6 = 45;
            }
            if (_local6 > 135) {
                _local6 = 135;
            }
        }
        else {
            if (this.tempPoint.y > (_local3.bottom - 5)) {
                if (_local6 > -45) {
                    _local6 = -45;
                }
                if (_local6 < -135) {
                    _local6 = -135;
                }
            }
        }
        this.arrow_.rotation = _local6;
        if (this.tooltip_ != null) {
            this.positionTooltip(this.tooltip_);
        }
        visible = true;
    }

    private function positionTooltip(_arg1:ToolTip):void {
        var _local5:Number;
        var _local8:Number;
        var _local9:Number;
        var _local2:Number = this.arrow_.rotation;
        var _local3:int = ((DIST + BIG_SIZE) + 12);
        var _local4:Number = (_local3 * Math.cos((_local2 * Trig.toRadians)));
        _local5 = (_local3 * Math.sin((_local2 * Trig.toRadians)));
        var _local6:Number = _arg1.contentWidth_;
        var _local7:Number = _arg1.contentHeight_;
        if ((((_local2 >= 45)) && ((_local2 <= 135)))) {
            _local8 = (_local4 + (_local6 / Math.tan((_local2 * Trig.toRadians))));
            _arg1.x = (((_local4 + _local8) / 2) - (_local6 / 2));
            _arg1.y = _local5;
        }
        else {
            if ((((_local2 <= -45)) && ((_local2 >= -135)))) {
                _local8 = (_local4 - (_local6 / Math.tan((_local2 * Trig.toRadians))));
                _arg1.x = (((_local4 + _local8) / 2) - (_local6 / 2));
                _arg1.y = (_local5 - _local7);
            }
            else {
                if ((((_local2 < 45)) && ((_local2 > -45)))) {
                    _arg1.x = _local4;
                    _local9 = (_local5 + (_local7 * Math.tan((_local2 * Trig.toRadians))));
                    _arg1.y = (((_local5 + _local9) / 2) - (_local7 / 2));
                }
                else {
                    _arg1.x = (_local4 - _local6);
                    _local9 = (_local5 - (_local7 * Math.tan((_local2 * Trig.toRadians))));
                    _arg1.y = (((_local5 + _local9) / 2) - (_local7 / 2));
                }
            }
        }
    }

    private function drawArrow():void {
        var _local1:Graphics = this.arrow_.graphics;
        _local1.clear();
        var _local2:int = ((((this.big_) || (this.mouseOver_))) ? BIG_SIZE : SMALL_SIZE);
        _local1.lineStyle(1, this.lineColor_);
        _local1.beginFill(this.fillColor_);
        _local1.moveTo(DIST, 0);
        _local1.lineTo((_local2 + DIST), _local2);
        _local1.lineTo((_local2 + DIST), -(_local2));
        _local1.lineTo(DIST, 0);
        _local1.endFill();
        _local1.lineStyle();
    }


}
}
