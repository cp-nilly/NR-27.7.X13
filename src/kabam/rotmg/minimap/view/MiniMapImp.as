package kabam.rotmg.minimap.view {
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.objects.Character;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.GuildHallPortal;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Portal;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
import com.company.assembleegameclient.ui.tooltip.PlayerGroupToolTip;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;
import com.company.util.RectangleUtil;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class MiniMapImp extends MiniMap {

    public static const MOUSE_DIST_SQ:int = (5 * 5);//25

    private static var objectTypeColorDict_:Dictionary = new Dictionary();

    public var _width:int;
    public var _height:int;
    public var zoomIndex:int = 0;
    public var windowRect_:Rectangle;
    public var active:Boolean = true;
    public var maxWH_:Point;
    public var miniMapData_:BitmapData;
    public var zoomLevels:Vector.<Number>;
    public var blueArrow_:BitmapData;
    public var groundLayer_:Shape;
    public var characterLayer_:Shape;
    private var focus:GameObject;
    private var zoomButtons:MiniMapZoomButtons;
    private var isMouseOver:Boolean = false;
    private var tooltip:PlayerGroupToolTip = null;
    private var menu:PlayerGroupMenu = null;
    private var mapMatrix_:Matrix;
    private var arrowMatrix_:Matrix;
    private var players_:Vector.<Player>;
    private var tempPoint:Point;
    private var _rotateEnableFlag:Boolean;

    public function MiniMapImp(_arg1:int, _arg2:int) {
        this.zoomLevels = new Vector.<Number>();
        this.mapMatrix_ = new Matrix();
        this.arrowMatrix_ = new Matrix();
        this.players_ = new Vector.<Player>();
        this.tempPoint = new Point();
        super();
        this._width = _arg1;
        this._height = _arg2;
        this._rotateEnableFlag = Parameters.data_.allowMiniMapRotation;
        this.makeVisualLayers();
        this.addMouseListeners();
    }

    public static function gameObjectToColor(_arg1:GameObject):uint {
        var _local2:* = _arg1.objectType_;
        if (!objectTypeColorDict_.hasOwnProperty(_local2)) {
            objectTypeColorDict_[_local2] = _arg1.getColor();
        }
        return (objectTypeColorDict_[_local2]);
    }


    override public function setMap(_arg1:AbstractMap):void {
        this.map = _arg1;
        this.makeViewModel();
    }

    override public function setFocus(_arg1:GameObject):void {
        this.focus = _arg1;
    }

    private function makeViewModel():void {
        this.windowRect_ = new Rectangle((-(this._width) / 2), (-(this._height) / 2), this._width, this._height);
        this.maxWH_ = new Point(map.width_, map.height_);
        this.miniMapData_ = new BitmapDataSpy(this.maxWH_.x, this.maxWH_.y, false, 0);
        var _local1:Number = Math.max((this._width / this.maxWH_.x), (this._height / this.maxWH_.y));
        var _local2:Number = 4;
        while (_local2 > _local1) {
            this.zoomLevels.push(_local2);
            _local2 = (_local2 / 2);
        }
        this.zoomLevels.push(_local1);
        ((this.zoomButtons) && (this.zoomButtons.setZoomLevels(this.zoomLevels.length)));
    }

    private function makeVisualLayers():void {
        this.blueArrow_ = AssetLibrary.getImageFromSet("lofiInterface", 54).clone();
        this.blueArrow_.colorTransform(this.blueArrow_.rect, new ColorTransform(0, 0, 1));
        graphics.clear();
        graphics.beginFill(0x1B1B1B);
        graphics.drawRect(0, 0, this._width, this._height);
        graphics.endFill();
        this.groundLayer_ = new Shape();
        this.groundLayer_.x = (this._width / 2);
        this.groundLayer_.y = (this._height / 2);
        addChild(this.groundLayer_);
        this.characterLayer_ = new Shape();
        this.characterLayer_.x = (this._width / 2);
        this.characterLayer_.y = (this._height / 2);
        addChild(this.characterLayer_);
        this.zoomButtons = new MiniMapZoomButtons();
        this.zoomButtons.x = (this._width - 20);
        this.zoomButtons.zoom.add(this.onZoomChanged);
        this.zoomButtons.setZoomLevels(this.zoomLevels.length);
        addChild(this.zoomButtons);
    }

    private function addMouseListeners():void {
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        addEventListener(MouseEvent.RIGHT_CLICK, this.onMapRightClick);
        addEventListener(MouseEvent.CLICK, this.onMapClick);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        this.active = false;
        this.removeDecorations();
    }

    public function dispose():void {
        this.miniMapData_.dispose();
        this.miniMapData_ = null;
        this.removeDecorations();
    }

    private function onZoomChanged(_arg1:int):void {
        this.zoomIndex = _arg1;
    }

    private function onMouseOver(_arg1:MouseEvent):void {
        this.isMouseOver = true;
    }

    private function onMouseOut(_arg1:MouseEvent):void {
        this.isMouseOver = false;
    }

    private function onMapRightClick(_arg1:MouseEvent):void {
        this._rotateEnableFlag = ((!(this._rotateEnableFlag)) && (Parameters.data_.allowMiniMapRotation));
    }

    private function onMapClick(_arg1:MouseEvent):void {
        if ((((((((this.tooltip == null)) || ((this.tooltip.parent == null)))) || ((this.tooltip.players_ == null)))) || ((this.tooltip.players_.length == 0)))) {
            return;
        }
        this.removeMenu();
        this.addMenu();
        this.removeTooltip();
    }

    private function addMenu():void {
        this.menu = new PlayerGroupMenu(map, this.tooltip.players_);
        this.menu.x = (this.tooltip.x + 12);
        this.menu.y = this.tooltip.y;
        menuLayer.addChild(this.menu);
    }

    override public function setGroundTile(_arg1:int, _arg2:int, _arg3:uint):void {
        var _local4:uint = GroundLibrary.getColor(_arg3);
        this.miniMapData_.setPixel(_arg1, _arg2, _local4);
    }

    override public function setGameObjectTile(_arg1:int, _arg2:int, _arg3:GameObject):void {
        var _local4:uint = gameObjectToColor(_arg3);
        this.miniMapData_.setPixel(_arg1, _arg2, _local4);
    }

    private function removeDecorations():void {
        this.removeTooltip();
        this.removeMenu();
    }

    private function removeTooltip():void {
        if (this.tooltip != null) {
            if (this.tooltip.parent != null) {
                this.tooltip.parent.removeChild(this.tooltip);
            }
            this.tooltip = null;
        }
    }

    private function removeMenu():void {
        if (this.menu != null) {
            if (this.menu.parent != null) {
                this.menu.parent.removeChild(this.menu);
            }
            this.menu = null;
        }
    }

    override public function draw():void {
        var _local7:Graphics;
        var _local10:GameObject;
        var _local15:uint;
        var _local16:Player;
        var _local17:Number;
        var _local18:Number;
        var _local19:Number;
        var _local20:Number;
        var _local21:Number;
        this._rotateEnableFlag = ((this._rotateEnableFlag) && (Parameters.data_.allowMiniMapRotation));
        this.groundLayer_.graphics.clear();
        this.characterLayer_.graphics.clear();
        if (!this.focus) {
            return;
        }
        if (!this.active) {
            return;
        }
        var _local1:Number = this.zoomLevels[this.zoomIndex];
        this.mapMatrix_.identity();
        this.mapMatrix_.translate(-(this.focus.x_), -(this.focus.y_));
        this.mapMatrix_.scale(_local1, _local1);
        var _local2:Point = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
        var _local3:Point = this.mapMatrix_.transformPoint(this.maxWH_);
        var _local4:Number = 0;
        if (_local2.x > this.windowRect_.left) {
            _local4 = (this.windowRect_.left - _local2.x);
        }
        else {
            if (_local3.x < this.windowRect_.right) {
                _local4 = (this.windowRect_.right - _local3.x);
            }
        }
        var _local5:Number = 0;
        if (_local2.y > this.windowRect_.top) {
            _local5 = (this.windowRect_.top - _local2.y);
        }
        else {
            if (_local3.y < this.windowRect_.bottom) {
                _local5 = (this.windowRect_.bottom - _local3.y);
            }
        }
        this.mapMatrix_.translate(_local4, _local5);
        _local2 = this.mapMatrix_.transformPoint(PointUtil.ORIGIN);
        if ((((_local1 >= 1)) && (this._rotateEnableFlag))) {
            this.mapMatrix_.rotate(-(Parameters.data_.cameraAngle));
        }
        var _local6:Rectangle = new Rectangle();
        _local6.x = Math.max(this.windowRect_.x, _local2.x);
        _local6.y = Math.max(this.windowRect_.y, _local2.y);
        _local6.right = Math.min(this.windowRect_.right, (_local2.x + (this.maxWH_.x * _local1)));
        _local6.bottom = Math.min(this.windowRect_.bottom, (_local2.y + (this.maxWH_.y * _local1)));
        _local7 = this.groundLayer_.graphics;
        _local7.beginBitmapFill(this.miniMapData_, this.mapMatrix_, false);
        _local7.drawRect(_local6.x, _local6.y, _local6.width, _local6.height);
        _local7.endFill();
        _local7 = this.characterLayer_.graphics;
        var _local8:Number = (mouseX - (this._width / 2));
        var _local9:Number = (mouseY - (this._height / 2));
        this.players_.length = 0;
        for each (_local10 in map.goDict_) {
            if (!((_local10.props_.noMiniMap_) || ((_local10 == this.focus)))) {
                _local16 = (_local10 as Player);
                if (_local16 != null) {
                    if (_local16.isPaused()) {
                        _local15 = 0x7F7F7F;
                    }
                    else {
                        if (_local16.isFellowGuild_) {
                            _local15 = 0xFF00;
                        }
                        else {
                            _local15 = 0xFFFF00;
                        }
                    }
                }
                else {
                    if ((_local10 is Character)) {
                        if (_local10.props_.isEnemy_) {
                            _local15 = 0xFF0000;
                        }
                        else {
                            _local15 = gameObjectToColor(_local10);
                        }
                    }
                    else {
                        if ((((_local10 is Portal)) || ((_local10 is GuildHallPortal)))) {
                            _local15 = 0xFF;
                        }
                        else {
                            continue;
                        }
                    }
                }
                _local17 = (((this.mapMatrix_.a * _local10.x_) + (this.mapMatrix_.c * _local10.y_)) + this.mapMatrix_.tx);
                _local18 = (((this.mapMatrix_.b * _local10.x_) + (this.mapMatrix_.d * _local10.y_)) + this.mapMatrix_.ty);
                if ((((((((_local17 <= (-(this._width) / 2))) || ((_local17 >= (this._width / 2))))) || ((_local18 <= (-(this._height) / 2))))) || ((_local18 >= (this._height / 2))))) {
                    RectangleUtil.lineSegmentIntersectXY(this.windowRect_, 0, 0, _local17, _local18, this.tempPoint);
                    _local17 = this.tempPoint.x;
                    _local18 = this.tempPoint.y;
                }
                if (((((!((_local16 == null))) && (this.isMouseOver))) && ((((this.menu == null)) || ((this.menu.parent == null)))))) {
                    _local19 = (_local8 - _local17);
                    _local20 = (_local9 - _local18);
                    _local21 = ((_local19 * _local19) + (_local20 * _local20));
                    if (_local21 < MOUSE_DIST_SQ) {
                        this.players_.push(_local16);
                    }
                }
                _local7.beginFill(_local15);
                _local7.drawRect((_local17 - 2), (_local18 - 2), 4, 4);
                _local7.endFill();
            }
        }
        if (this.players_.length != 0) {
            if (this.tooltip == null) {
                this.tooltip = new PlayerGroupToolTip(this.players_);
                menuLayer.addChild(this.tooltip);
            }
            else {
                if (!this.areSamePlayers(this.tooltip.players_, this.players_)) {
                    this.tooltip.setPlayers(this.players_);
                }
            }
        }
        else {
            if (this.tooltip != null) {
                if (this.tooltip.parent != null) {
                    this.tooltip.parent.removeChild(this.tooltip);
                }
                this.tooltip = null;
            }
        }
        var _local11:Number = this.focus.x_;
        var _local12:Number = this.focus.y_;
        var _local13:Number = (((this.mapMatrix_.a * _local11) + (this.mapMatrix_.c * _local12)) + this.mapMatrix_.tx);
        var _local14:Number = (((this.mapMatrix_.b * _local11) + (this.mapMatrix_.d * _local12)) + this.mapMatrix_.ty);
        this.arrowMatrix_.identity();
        this.arrowMatrix_.translate(-4, -5);
        this.arrowMatrix_.scale((8 / this.blueArrow_.width), (32 / this.blueArrow_.height));
        if (!(((_local1 >= 1)) && (this._rotateEnableFlag))) {
            this.arrowMatrix_.rotate(Parameters.data_.cameraAngle);
        }
        this.arrowMatrix_.translate(_local13, _local14);
        _local7.beginBitmapFill(this.blueArrow_, this.arrowMatrix_, false);
        _local7.drawRect((_local13 - 16), (_local14 - 16), 32, 32);
        _local7.endFill();
    }

    private function areSamePlayers(_arg1:Vector.<Player>, _arg2:Vector.<Player>):Boolean {
        var _local3:int = _arg1.length;
        if (_local3 != _arg2.length) {
            return (false);
        }
        var _local4:int;
        while (_local4 < _local3) {
            if (_arg1[_local4] != _arg2[_local4]) {
                return (false);
            }
            _local4++;
        }
        return (true);
    }

    override public function zoomIn():void {
        this.zoomIndex = this.zoomButtons.setZoomLevel((this.zoomIndex - 1));
    }

    override public function zoomOut():void {
        this.zoomIndex = this.zoomButtons.setZoomLevel((this.zoomIndex + 1));
    }

    override public function deactivate():void {
    }


}
}
