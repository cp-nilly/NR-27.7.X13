package com.company.assembleegameclient.game {
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.KeyCodes;

import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.Capabilities;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.ui.UIUtils;
import kabam.rotmg.ui.model.TabStripModel;

import net.hires.debug.Stats;

import org.swiftsuspenders.Injector;

public class MapUserInput {

    private static const MOUSE_DOWN_WAIT_PERIOD:uint = 175;

    private static var stats_:Stats = new Stats();
    private static var arrowWarning_:Boolean = false;

    public var gs_:GameSprite;
    private var moveLeft_:Boolean = false;
    private var moveRight_:Boolean = false;
    private var moveUp_:Boolean = false;
    private var moveDown_:Boolean = false;
    private var rotateLeft_:Boolean = false;
    private var rotateRight_:Boolean = false;
    private var mouseDown_:Boolean = false;
    private var autofire_:Boolean = false;
    private var currentString:String = "";
    private var specialKeyDown_:Boolean = false;
    private var enablePlayerInput_:Boolean = true;
    private var giftStatusUpdateSignal:GiftStatusUpdateSignal;
    private var addTextLine:AddTextLineSignal;
    private var setTextBoxVisibility:SetTextBoxVisibilitySignal;
    private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;
    private var miniMapZoom:MiniMapZoomSignal;
    private var useBuyPotionSignal:UseBuyPotionSignal;
    private var potionInventoryModel:PotionInventoryModel;
    private var openDialogSignal:OpenDialogSignal;
    private var closeDialogSignal:CloseDialogsSignal;
    private var tabStripModel:TabStripModel;
    private var layers:Layers;
    private var exitGame:ExitGameSignal;
    private var areFKeysAvailable:Boolean;
    private var reskinPetFlowStart:ReskinPetFlowStartSignal;

    public function MapUserInput(_arg1:GameSprite) {
        this.gs_ = _arg1;
        this.gs_.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        this.gs_.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        var _local2:Injector = StaticInjectorContext.getInjector();
        this.giftStatusUpdateSignal = _local2.getInstance(GiftStatusUpdateSignal);
        this.reskinPetFlowStart = _local2.getInstance(ReskinPetFlowStartSignal);
        this.addTextLine = _local2.getInstance(AddTextLineSignal);
        this.setTextBoxVisibility = _local2.getInstance(SetTextBoxVisibilitySignal);
        this.miniMapZoom = _local2.getInstance(MiniMapZoomSignal);
        this.useBuyPotionSignal = _local2.getInstance(UseBuyPotionSignal);
        this.potionInventoryModel = _local2.getInstance(PotionInventoryModel);
        this.tabStripModel = _local2.getInstance(TabStripModel);
        this.layers = _local2.getInstance(Layers);
        this.statsTabHotKeyInputSignal = _local2.getInstance(StatsTabHotKeyInputSignal);
        this.exitGame = _local2.getInstance(ExitGameSignal);
        this.openDialogSignal = _local2.getInstance(OpenDialogSignal);
        this.closeDialogSignal = _local2.getInstance(CloseDialogsSignal);
        var _local3:ApplicationSetup = _local2.getInstance(ApplicationSetup);
        this.areFKeysAvailable = _local3.areDeveloperHotkeysEnabled();
        this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
    }

    public function onRenderSwitch(_arg1:Boolean):void {
        if (_arg1) {
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        else {
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
    }

    public function clearInput():void {
        this.moveLeft_ = false;
        this.moveRight_ = false;
        this.moveUp_ = false;
        this.moveDown_ = false;
        this.rotateLeft_ = false;
        this.rotateRight_ = false;
        this.mouseDown_ = false;
        this.autofire_ = false;
        this.setPlayerMovement();
    }

    public function setEnablePlayerInput(_arg1:Boolean):void {
        if (this.enablePlayerInput_ != _arg1) {
            this.enablePlayerInput_ = _arg1;
            this.clearInput();
        }
    }

    private function onAddedToStage(_arg1:Event):void {
        var _local2:Stage = this.gs_.stage;
        _local2.addEventListener(Event.ACTIVATE, this.onActivate);
        _local2.addEventListener(Event.DEACTIVATE, this.onDeactivate);
        _local2.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _local2.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        _local2.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        if (Parameters.isGpuRender()) {
            _local2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            _local2.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        else {
            this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        _local2.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        _local2.addEventListener(MouseEvent.RIGHT_CLICK, this.disableRightClick);
    }

    public function disableRightClick(_arg1:MouseEvent):void {
    }

    private function onRemovedFromStage(_arg1:Event):void {
        var _local2:Stage = this.gs_.stage;
        _local2.removeEventListener(Event.ACTIVATE, this.onActivate);
        _local2.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
        _local2.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        _local2.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        _local2.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        if (Parameters.isGpuRender()) {
            _local2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            _local2.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        else {
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        _local2.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        _local2.removeEventListener(MouseEvent.RIGHT_CLICK, this.disableRightClick);
    }

    private function onActivate(_arg1:Event):void {
    }

    private function onDeactivate(_arg1:Event):void {
        this.clearInput();
    }

    public function onMouseDown(_arg1:MouseEvent):void {
        var _local3:Number;
        var _local4:int;
        var _local5:XML;
        var _local6:Number;
        var _local7:Number;
        var _local2:Player = this.gs_.map.player_;
        if (_local2 == null) {
            return;
        }
        if (!this.enablePlayerInput_) {
            return;
        }
        if (_arg1.shiftKey) {
            _local4 = _local2.equipment_[1];
            if (_local4 == -1) {
                return;
            }
            _local5 = ObjectLibrary.xmlLibrary_[_local4];
            if ((((_local5 == null)) || (_local5.hasOwnProperty("EndMpCost")))) {
                return;
            }
            if (_local2.isUnstable()) {
                _local6 = ((Math.random() * 600) - 300);
                _local7 = ((Math.random() * 600) - 325);
            }
            else {
                _local6 = this.gs_.map.mouseX;
                _local7 = this.gs_.map.mouseY;
            }
            if (Parameters.isGpuRender()) {
                if ((((((_arg1.currentTarget == _arg1.target)) || ((_arg1.target == this.gs_.map)))) || ((_arg1.target == this.gs_)))) {
                    _local2.useAltWeapon(_local6, _local7, UseType.START_USE);
                }
            }
            else {
                _local2.useAltWeapon(_local6, _local7, UseType.START_USE);
            }
            return;
        }
        if (Parameters.isGpuRender()) {
            if ((((((((_arg1.currentTarget == _arg1.target)) || ((_arg1.target == this.gs_.map)))) || ((_arg1.target == this.gs_)))) || ((_arg1.currentTarget == this.gs_.chatBox_.list)))) {
                _local3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
            }
            else {
                return;
            }
        }
        else {
            _local3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
        }
        doneAction(this.gs_, Tutorial.ATTACK_ACTION);
        if (_local2.isUnstable()) {
            _local2.attemptAttackAngle((Math.random() * 360));
        }
        else {
            _local2.attemptAttackAngle(_local3);
        }
        this.mouseDown_ = true;
    }

    public function onMouseUp(_arg1:MouseEvent):void {
        this.mouseDown_ = false;
        var _local2:Player = this.gs_.map.player_;
        if (_local2 == null) {
            return;
        }
        _local2.isShooting = false;
    }

    private function onMouseWheel(_arg1:MouseEvent):void {
        if (_arg1.delta > 0) {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
        }
        else {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
        }
    }

    private function onEnterFrame(_arg1:Event):void {
        var _local2:Player;
        var _local3:Number;
        doneAction(this.gs_, Tutorial.UPDATE_ACTION);
        if (((this.enablePlayerInput_) && (((this.mouseDown_) || (this.autofire_))))) {
            _local2 = this.gs_.map.player_;
            if (_local2 != null) {
                if (_local2.isUnstable()) {
                    _local2.attemptAttackAngle((Math.random() * 360));
                }
                else {
                    _local3 = Math.atan2(this.gs_.map.mouseY, this.gs_.map.mouseX);
                    _local2.attemptAttackAngle(_local3);
                }
            }
        }
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        var _local4:AddTextLineSignal;
        var _local5:ChatMessage;
        var _local6:GameObject;
        var _local7:Number;
        var _local8:Number;
        var _local9:Boolean;
        var _local10:Square;
        var _local2:Stage = this.gs_.stage;
        this.currentString = (this.currentString + String.fromCharCode(_arg1.keyCode).toLowerCase());
        if (this.currentString == UIUtils.EXPERIMENTAL_MENU_PASSWORD.slice(0, this.currentString.length)) {
            if (this.currentString.length == UIUtils.EXPERIMENTAL_MENU_PASSWORD.length) {
                _local4 = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
                _local5 = new ChatMessage();
                _local5.name = Parameters.SERVER_CHAT_NAME;
                this.currentString = "";
                UIUtils.SHOW_EXPERIMENTAL_MENU = !(UIUtils.SHOW_EXPERIMENTAL_MENU);
                _local5.text = ((UIUtils.SHOW_EXPERIMENTAL_MENU) ? "Experimental menu activated" : "Experimental menu deactivated");
                _local4.dispatch(_local5);
            }
        }
        else {
            this.currentString = "";
        }
        switch (_arg1.keyCode) {
            case KeyCodes.F1:
            case KeyCodes.F2:
            case KeyCodes.F3:
            case KeyCodes.F4:
            case KeyCodes.F5:
            case KeyCodes.F6:
            case KeyCodes.F7:
            case KeyCodes.F8:
            case KeyCodes.F9:
            case KeyCodes.F10:
            case KeyCodes.F11:
            case KeyCodes.F12:
            case KeyCodes.INSERT:
            case KeyCodes.ALTERNATE:
                break;
            default:
                if (_local2.focus != null) {
                    return;
                }
        }
        var _local3:Player = this.gs_.map.player_;
        switch (_arg1.keyCode) {
            case Parameters.data_.moveUp:
                doneAction(this.gs_, Tutorial.MOVE_FORWARD_ACTION);
                this.moveUp_ = true;
                break;
            case Parameters.data_.moveDown:
                doneAction(this.gs_, Tutorial.MOVE_BACKWARD_ACTION);
                this.moveDown_ = true;
                break;
            case Parameters.data_.moveLeft:
                doneAction(this.gs_, Tutorial.MOVE_LEFT_ACTION);
                this.moveLeft_ = true;
                break;
            case Parameters.data_.moveRight:
                doneAction(this.gs_, Tutorial.MOVE_RIGHT_ACTION);
                this.moveRight_ = true;
                break;
            case Parameters.data_.rotateLeft:
                if (!Parameters.data_.allowRotation) break;
                doneAction(this.gs_, Tutorial.ROTATE_LEFT_ACTION);
                this.rotateLeft_ = true;
                break;
            case Parameters.data_.rotateRight:
                if (!Parameters.data_.allowRotation) break;
                doneAction(this.gs_, Tutorial.ROTATE_RIGHT_ACTION);
                this.rotateRight_ = true;
                break;
            case Parameters.data_.resetToDefaultCameraAngle:
                Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
                Parameters.save();
                break;
            case Parameters.data_.useSpecial:
                _local6 = this.gs_.map.player_;
                if (_local6 == null) break;
                if (!this.specialKeyDown_) {
                    if (_local3.isUnstable()) {
                        _local7 = ((Math.random() * 600) - 300);
                        _local8 = ((Math.random() * 600) - 325);
                    }
                    else {
                        _local7 = this.gs_.map.mouseX;
                        _local8 = this.gs_.map.mouseY;
                    }
                    _local9 = _local3.useAltWeapon(_local7, _local8, UseType.START_USE);
                    if (_local9) {
                        this.specialKeyDown_ = true;
                    }
                }
                break;
            case Parameters.data_.autofireToggle:
                this.gs_.map.player_.isShooting = (this.autofire_ = !(this.autofire_));
                break;
            case Parameters.data_.toggleHPBar:
                Parameters.data_.HPBar = !(Parameters.data_.HPBar);
                break;
            case Parameters.data_.useInvSlot1:
                this.useItem(4);
                break;
            case Parameters.data_.useInvSlot2:
                this.useItem(5);
                break;
            case Parameters.data_.useInvSlot3:
                this.useItem(6);
                break;
            case Parameters.data_.useInvSlot4:
                this.useItem(7);
                break;
            case Parameters.data_.useInvSlot5:
                this.useItem(8);
                break;
            case Parameters.data_.useInvSlot6:
                this.useItem(9);
                break;
            case Parameters.data_.useInvSlot7:
                this.useItem(10);
                break;
            case Parameters.data_.useInvSlot8:
                this.useItem(11);
                break;
            case Parameters.data_.useHealthPotion:
                if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available) {
                    this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                }
                break;
            case Parameters.data_.GPURenderToggle:
                Parameters.data_.GPURender = !(Parameters.data_.GPURender);
                break;
            case Parameters.data_.useMagicPotion:
                if (this.potionInventoryModel.getPotionModel(PotionInventoryModel.MAGIC_POTION_ID).available) {
                    this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.MAGIC_POTION_ID, UseBuyPotionVO.CONTEXTBUY));
                }
                break;
            case Parameters.data_.miniMapZoomOut:
                this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
                break;
            case Parameters.data_.miniMapZoomIn:
                this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
                break;
            case Parameters.data_.togglePerformanceStats:
                this.togglePerformanceStats();
                break;
            case Parameters.data_.escapeToNexus:
            case Parameters.data_.escapeToNexus2:
                this.exitGame.dispatch();
                this.gs_.gsc_.escape();
                Parameters.data_.needsRandomRealm = false;
                Parameters.save();
                break;
            case Parameters.data_.friendList:
                Parameters.data_.friendListDisplayFlag = !(Parameters.data_.friendListDisplayFlag);
                if (Parameters.data_.friendListDisplayFlag) {
                    this.openDialogSignal.dispatch(new FriendListView());
                }
                else {
                    this.closeDialogSignal.dispatch();
                }
                break;
            case Parameters.data_.options:
                this.clearInput();
                this.layers.overlay.addChild(new Options(this.gs_));
                break;
            case Parameters.data_.toggleCentering:
                Parameters.data_.centerOnPlayer = !(Parameters.data_.centerOnPlayer);
                Parameters.save();
                break;
            case Parameters.data_.toggleFullscreen:
                if (Capabilities.playerType == "Desktop") {
                    Parameters.data_.fullscreenMode = !(Parameters.data_.fullscreenMode);
                    Parameters.save();
                    _local2.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
                }
                break;
            case Parameters.data_.switchTabs:
                this.statsTabHotKeyInputSignal.dispatch();
                break;
            case Parameters.data_.testOne:
                break;
        }
        if (Parameters.ALLOW_SCREENSHOT_MODE) {
            switch (_arg1.keyCode) {
                case KeyCodes.F2:
                    this.toggleScreenShotMode();
                    break;
                case KeyCodes.F3:
                    Parameters.screenShotSlimMode_ = !(Parameters.screenShotSlimMode_);
                    break;
                case KeyCodes.F4:
                    this.gs_.map.mapOverlay_.visible = !(this.gs_.map.mapOverlay_.visible);
                    this.gs_.map.partyOverlay_.visible = !(this.gs_.map.partyOverlay_.visible);
                    break;
            }
        }
        if (this.areFKeysAvailable) {
            switch (_arg1.keyCode) {
                case KeyCodes.F6:
                    TextureRedrawer.clearCache();
                    Parameters.projColorType_ = ((Parameters.projColorType_ + 1) % 7);
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, ("Projectile Color Type: " + Parameters.projColorType_)));
                    break;
                case KeyCodes.F7:
                    for each (_local10 in this.gs_.map.squares_) {
                        if (_local10 != null) {
                            _local10.faces_.length = 0;
                        }
                    }
                    Parameters.blendType_ = ((Parameters.blendType_ + 1) % 2);
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, ("Blend type: " + Parameters.blendType_)));
                    break;
                case KeyCodes.F8:
                    Parameters.data_.surveyDate = 0;
                    Parameters.data_.needsSurvey = true;
                    Parameters.data_.playTimeLeftTillSurvey = 5;
                    Parameters.data_.surveyGroup = "testing";
                    break;
                case KeyCodes.F9:
                    Parameters.drawProj_ = !(Parameters.drawProj_);
                    break;
            }
        }
        this.setPlayerMovement();
    }

    private function onKeyUp(_arg1:KeyboardEvent):void {
        var _local2:Number;
        var _local3:Number;
        switch (_arg1.keyCode) {
            case Parameters.data_.moveUp:
                this.moveUp_ = false;
                break;
            case Parameters.data_.moveDown:
                this.moveDown_ = false;
                break;
            case Parameters.data_.moveLeft:
                this.moveLeft_ = false;
                break;
            case Parameters.data_.moveRight:
                this.moveRight_ = false;
                break;
            case Parameters.data_.rotateLeft:
                this.rotateLeft_ = false;
                break;
            case Parameters.data_.rotateRight:
                this.rotateRight_ = false;
                break;
            case Parameters.data_.useSpecial:
                if (this.specialKeyDown_) {
                    this.specialKeyDown_ = false;
                    if (this.gs_.map.player_.isUnstable()) {
                        _local2 = ((Math.random() * 600) - 300);
                        _local3 = ((Math.random() * 600) - 325);
                    }
                    else {
                        _local2 = this.gs_.map.mouseX;
                        _local3 = this.gs_.map.mouseY;
                    }
                    this.gs_.map.player_.useAltWeapon(this.gs_.map.mouseX, this.gs_.map.mouseY, UseType.END_USE);
                }
                break;
        }
        this.setPlayerMovement();
    }

    private function setPlayerMovement():void {
        var _local1:Player = this.gs_.map.player_;
        if (_local1 != null) {
            if (this.enablePlayerInput_) {
                _local1.setRelativeMovement((((this.rotateRight_) ? 1 : 0) - ((this.rotateLeft_) ? 1 : 0)), (((this.moveRight_) ? 1 : 0) - ((this.moveLeft_) ? 1 : 0)), (((this.moveDown_) ? 1 : 0) - ((this.moveUp_) ? 1 : 0)));
            }
            else {
                _local1.setRelativeMovement(0, 0, 0);
            }
        }
    }

    private function useItem(slot:int):void {
        if (this.tabStripModel.currentSelection == TabStripModel.BACKPACK) {
            slot = slot + GeneralConstants.NUM_INVENTORY_SLOTS;
        }
        var slotIndex:int =
                ObjectLibrary.getMatchingSlotIndex(this.gs_.map.player_.equipment_[slot], this.gs_.map.player_);
        if (slotIndex != -1) {
            GameServerConnection.instance.invSwap(
                    this.gs_.map.player_,
                    this.gs_.map.player_, slot,
                    this.gs_.map.player_.equipment_[slot],
                    this.gs_.map.player_, slotIndex,
                    this.gs_.map.player_.equipment_[slotIndex]);
        }
        else {
            GameServerConnection.instance.useItem_new(this.gs_.map.player_, slot);
        }
    }

    private function togglePerformanceStats():void {
        if (this.gs_.contains(stats_)) {
            this.gs_.removeChild(stats_);
            this.gs_.removeChild(this.gs_.gsc_.jitterWatcher_);
            this.gs_.gsc_.disableJitterWatcher();
        }
        else {
            this.gs_.addChild(stats_);
            this.gs_.gsc_.enableJitterWatcher();
            this.gs_.gsc_.jitterWatcher_.y = stats_.height;
            this.gs_.addChild(this.gs_.gsc_.jitterWatcher_);
        }
    }

    private function toggleScreenShotMode():void {
        Parameters.screenShotMode_ = !(Parameters.screenShotMode_);
        if (Parameters.screenShotMode_) {
            this.gs_.hudView.visible = false;
            this.setTextBoxVisibility.dispatch(false);
        }
        else {
            this.gs_.hudView.visible = true;
            this.setTextBoxVisibility.dispatch(true);
        }
    }


}
}
