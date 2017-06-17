package com.company.assembleegameclient.ui.options {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.sound.SFX;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.navigateToURL;
import flash.system.Capabilities;
import flash.text.TextFieldAutoSize;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.UIUtils;

public class Options extends Sprite {

    private static const TABS:Vector.<String> = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, TextKey.OPTIONS_MISC];
    public static const Y_POSITION:int = 550;
    public static const CHAT_COMMAND:String = "chatCommand";
    public static const CHAT:String = "chat";
    public static const TELL:String = "tell";
    public static const GUILD_CHAT:String = "guildChat";
    public static const SCROLL_CHAT_UP:String = "scrollChatUp";
    public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";

    private static var registeredCursors:Vector.<String> = new <String>[];

    private var gs_:GameSprite;
    private var continueButton_:TitleMenuOption;
    private var resetToDefaultsButton_:TitleMenuOption;
    private var homeButton_:TitleMenuOption;
    private var tabs_:Vector.<OptionsTabTitle>;
    private var selected_:OptionsTabTitle = null;
    private var options_:Vector.<Sprite>;

    public function Options(_arg1:GameSprite) {
        var _local2:TextFieldDisplayConcrete;
        var _local5:int;
        var _local6:OptionsTabTitle;
        this.tabs_ = new Vector.<OptionsTabTitle>();
        this.options_ = new Vector.<Sprite>();
        super();
        this.gs_ = _arg1;
        graphics.clear();
        graphics.beginFill(0x2B2B2B, 0.8);
        graphics.drawRect(0, 0, 800, 600);
        graphics.endFill();
        graphics.lineStyle(1, 0x5E5E5E);
        graphics.moveTo(0, 100);
        graphics.lineTo(800, 100);
        graphics.lineStyle();
        _local2 = new TextFieldDisplayConcrete().setSize(36).setColor(0xFFFFFF);
        _local2.setBold(true);
        _local2.setStringBuilder(new LineBuilder().setParams(TextKey.OPTIONS_TITLE));
        _local2.setAutoSize(TextFieldAutoSize.CENTER);
        _local2.filters = [new DropShadowFilter(0, 0, 0)];
        _local2.x = ((800 / 2) - (_local2.width / 2));
        _local2.y = 8;
        addChild(_local2);
        addChild(new ScreenGraphic());
        this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
        this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
        this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
        addChild(this.continueButton_);
        this.resetToDefaultsButton_ = new TitleMenuOption(TextKey.OPTIONS_RESET_TO_DEFAULTS_BUTTON, 22, false);
        this.resetToDefaultsButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.resetToDefaultsButton_.setAutoSize(TextFieldAutoSize.LEFT);
        this.resetToDefaultsButton_.addEventListener(MouseEvent.CLICK, this.onResetToDefaultsClick);
        addChild(this.resetToDefaultsButton_);
        this.homeButton_ = new TitleMenuOption(TextKey.OPTIONS_HOME_BUTTON, 22, false);
        this.homeButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.homeButton_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.homeButton_.addEventListener(MouseEvent.CLICK, this.onHomeClick);
        addChild(this.homeButton_);
        if (UIUtils.SHOW_EXPERIMENTAL_MENU) {
            if (TABS.indexOf("Experimental") == -1) {
                TABS.push("Experimental");
            }
        }
        else {
            _local5 = TABS.indexOf("Experimental");
            if (_local5 != -1) {
                TABS.pop();
            }
        }
        var _local3:int = 14;
        var _local4:int;
        while (_local4 < TABS.length) {
            _local6 = new OptionsTabTitle(TABS[_local4]);
            _local6.x = _local3;
            _local6.y = 70;
            addChild(_local6);
            _local6.addEventListener(MouseEvent.CLICK, this.onTabClick);
            this.tabs_.push(_local6);
            _local3 = (_local3 + ((UIUtils.SHOW_EXPERIMENTAL_MENU) ? 90 : 108));
            _local4++;
        }
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private static function makePotionBuy():ChoiceOption {
        return (new ChoiceOption("contextualPotionBuy", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CONTEXTUAL_POTION_BUY, TextKey.OPTIONS_CONTEXTUAL_POTION_BUY_DESC, null));
    }

    private static function makeOnOffLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_ON), makeLineBuilder(TextKey.OPTIONS_OFF)]);
    }

    private static function makeHighLowLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("High"), new StaticStringBuilder("Low")]);
    }

    private static function makeStarSelectLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("5"), new StaticStringBuilder("10")]);
    }

    private static function makeCursorSelectLabels():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("ProX"), new StaticStringBuilder("X2"), new StaticStringBuilder("X3"), new StaticStringBuilder("X4"), new StaticStringBuilder("Corner1"), new StaticStringBuilder("Corner2"), new StaticStringBuilder("Symb"), new StaticStringBuilder("Alien"), new StaticStringBuilder("Xhair"), new StaticStringBuilder("Dystopia+")]);
    }

    private static function makeLineBuilder(_arg1:String):LineBuilder {
        return (new LineBuilder().setParams(_arg1));
    }

    private static function makeClickForGold():ChoiceOption {
        return (new ChoiceOption("clickForGold", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CLICK_FOR_GOLD, TextKey.OPTIONS_CLICK_FOR_GOLD_DESC, null));
    }

    private static function onUIQualityToggle():void {
        UIUtils.toggleQuality(Parameters.data_.uiQuality);
    }

    private static function onBarTextToggle():void {
        StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
    }

    public static function refreshCursor():void {
        var _local1:MouseCursorData;
        var _local2:Vector.<BitmapData>;
        if (((!((Parameters.data_.cursorSelect == MouseCursor.AUTO))) && ((registeredCursors.indexOf(Parameters.data_.cursorSelect) == -1)))) {
            _local1 = new MouseCursorData();
            _local1.hotSpot = new Point(15, 15);
            _local2 = new Vector.<BitmapData>(1, true);
            _local2[0] = AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
            _local1.data = _local2;
            Mouse.registerCursor(Parameters.data_.cursorSelect, _local1);
            registeredCursors.push(Parameters.data_.cursorSelect);
        }
        Mouse.cursor = Parameters.data_.cursorSelect;
    }

    private static function makeDegreeOptions():Vector.<StringBuilder> {
        return (new <StringBuilder>[new StaticStringBuilder("45°"), new StaticStringBuilder("0°")]);
    }

    private static function onDefaultCameraAngleChange():void {
        Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
        Parameters.save();
    }


    private function onContinueClick(_arg1:MouseEvent):void {
        this.close();
    }

    private function onResetToDefaultsClick(_arg1:MouseEvent):void {
        var _local3:BaseOption;
        var _local2:int;
        while (_local2 < this.options_.length) {
            _local3 = (this.options_[_local2] as BaseOption);
            if (_local3 != null) {
                delete Parameters.data_[_local3.paramName_];
            }
            _local2++;
        }
        Parameters.setDefaults();
        Parameters.save();
        this.refresh();
    }

    private function onHomeClick(_arg1:MouseEvent):void {
        this.close();
        this.gs_.closed.dispatch();
    }

    private function onTabClick(_arg1:MouseEvent):void {
        var _local2:OptionsTabTitle = (_arg1.currentTarget as OptionsTabTitle);
        this.setSelected(_local2);
    }

    private function setSelected(_arg1:OptionsTabTitle):void {
        if (_arg1 == this.selected_) {
            return;
        }
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg1;
        this.selected_.setSelected(true);
        this.removeOptions();
        switch (this.selected_.text_) {
            case TextKey.OPTIONS_CONTROLS:
                this.addControlsOptions();
                return;
            case TextKey.OPTIONS_HOTKEYS:
                this.addHotKeysOptions();
                return;
            case TextKey.OPTIONS_CHAT:
                this.addChatOptions();
                return;
            case TextKey.OPTIONS_GRAPHICS:
                this.addGraphicsOptions();
                return;
            case TextKey.OPTIONS_SOUND:
                this.addSoundOptions();
                return;
            case TextKey.OPTIONS_MISC:
                this.addMiscOptions();
                return;
            case TextKey.OPTIONS_FRIEND:
                this.addFriendOptions();
                return;
            case "Experimental":
                this.addExperimentalOptions();
                return;
        }
    }

    private function onAddedToStage(_arg1:Event):void {
        this.continueButton_.x = (stage.stageWidth / 2);
        this.continueButton_.y = Y_POSITION;
        this.resetToDefaultsButton_.x = 20;
        this.resetToDefaultsButton_.y = Y_POSITION;
        this.homeButton_.x = (stage.stageWidth - 20);
        this.homeButton_.y = Y_POSITION;
        if (Capabilities.playerType == "Desktop") {
            Parameters.data_.fullscreenMode = (stage.displayState == "fullScreenInteractive");
            Parameters.save();
        }
        this.setSelected(this.tabs_[0]);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
        stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
        stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if ((((Capabilities.playerType == "Desktop")) && ((_arg1.keyCode == KeyCodes.ESCAPE)))) {
            Parameters.data_.fullscreenMode = false;
            Parameters.save();
            this.refresh();
        }
        if (_arg1.keyCode == Parameters.data_.options) {
            this.close();
        }
        _arg1.stopImmediatePropagation();
    }

    private function close():void {
        stage.focus = null;
        parent.removeChild(this);
    }

    private function onKeyUp(_arg1:KeyboardEvent):void {
        _arg1.stopImmediatePropagation();
    }

    private function removeOptions():void {
        var _local1:Sprite;
        for each (_local1 in this.options_) {
            removeChild(_local1);
        }
        this.options_.length = 0;
    }

    private function addControlsOptions():void {
        this.addOptionAndPosition(new KeyMapper("moveUp", TextKey.OPTIONS_MOVE_UP, TextKey.OPTIONS_MOVE_UP_DESC));
        this.addOptionAndPosition(new KeyMapper("moveLeft", TextKey.OPTIONS_MOVE_LEFT, TextKey.OPTIONS_MOVE_LEFT_DESC));
        this.addOptionAndPosition(new KeyMapper("moveDown", TextKey.OPTIONS_MOVE_DOWN, TextKey.OPTIONS_MOVE_DOWN_DESC));
        this.addOptionAndPosition(new KeyMapper("moveRight", TextKey.OPTIONS_MOVE_RIGHT, TextKey.OPTIONS_MOVE_RIGHT_DESC));
        this.addOptionAndPosition(this.makeAllowCameraRotation());
        this.addOptionAndPosition(this.makeAllowMiniMapRotation());
        this.addOptionAndPosition(new KeyMapper("rotateLeft", TextKey.OPTIONS_ROTATE_LEFT, TextKey.OPTIONS_ROTATE_LEFT_DESC, !(Parameters.data_.allowRotation)));
        this.addOptionAndPosition(new KeyMapper("rotateRight", TextKey.OPTIONS_ROTATE_RIGHT, TextKey.OPTIONS_ROTATE_RIGHT_DESC, !(Parameters.data_.allowRotation)));
        this.addOptionAndPosition(new KeyMapper("useSpecial", TextKey.OPTIONS_USE_SPECIAL_ABILITY, TextKey.OPTIONS_USE_SPECIAL_ABILITY_DESC));
        this.addOptionAndPosition(new KeyMapper("autofireToggle", TextKey.OPTIONS_AUTOFIRE_TOGGLE, TextKey.OPTIONS_AUTOFIRE_TOGGLE_DESC));
        this.addOptionAndPosition(new KeyMapper("toggleHPBar", TextKey.OPTIONS_TOGGLE_HPBAR, TextKey.OPTIONS_TOGGLE_HPBAR_DESC));
        this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle", TextKey.OPTIONS_RESET_CAMERA, TextKey.OPTIONS_RESET_CAMERA_DESC));
        this.addOptionAndPosition(new KeyMapper("togglePerformanceStats", TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS, TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS_DESC));
        this.addOptionAndPosition(new KeyMapper("toggleCentering", TextKey.OPTIONS_TOGGLE_CENTERING, TextKey.OPTIONS_TOGGLE_CENTERING_DESC));
        this.addOptionAndPosition(new KeyMapper("interact", TextKey.OPTIONS_INTERACT_OR_BUY, TextKey.OPTIONS_INTERACT_OR_BUY_DESC));
        this.addOptionAndPosition(makeClickForGold());
        this.addOptionAndPosition(makePotionBuy());
    }

    private function makeAllowCameraRotation():ChoiceOption {
        return (new ChoiceOption("allowRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_ROTATION, TextKey.OPTIONS_ALLOW_ROTATION_DESC, this.onAllowRotationChange));
    }

    private function makeAllowMiniMapRotation():ChoiceOption {
        return (new ChoiceOption("allowMiniMapRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION, TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION_DESC, null));
    }

    private function onAllowRotationChange():void {
        var _local2:KeyMapper;
        var _local1:int;
        while (_local1 < this.options_.length) {
            _local2 = (this.options_[_local1] as KeyMapper);
            if (_local2 != null) {
                if ((((_local2.paramName_ == "rotateLeft")) || ((_local2.paramName_ == "rotateRight")))) {
                    _local2.setDisabled(!(Parameters.data_.allowRotation));
                }
            }
            _local1++;
        }
    }

    private function addHotKeysOptions():void {
        this.addOptionAndPosition(new KeyMapper("useHealthPotion", TextKey.OPTIONS_USE_BUY_HEALTH, TextKey.OPTIONS_USE_BUY_HEALTH_DESC));
        this.addOptionAndPosition(new KeyMapper("useMagicPotion", TextKey.OPTIONS_USE_BUY_MAGIC, TextKey.OPTIONS_USE_BUY_MAGIC_DESC));
        this.addInventoryOptions();
        this.addOptionAndPosition(new KeyMapper("miniMapZoomIn", TextKey.OPTIONS_MINI_MAP_ZOOM_IN, TextKey.OPTIONS_MINI_MAP_ZOOM_IN_DESC));
        this.addOptionAndPosition(new KeyMapper("miniMapZoomOut", TextKey.OPTIONS_MINI_MAP_ZOOM_OUT, TextKey.OPTIONS_MINI_MAP_ZOOM_OUT_DESC));
        this.addOptionAndPosition(new KeyMapper("escapeToNexus", TextKey.OPTIONS_ESCAPE_TO_NEXUS, TextKey.OPTIONS_ESCAPE_TO_NEXUS_DESC));
        this.addOptionAndPosition(new KeyMapper("options", TextKey.OPTIONS_SHOW_OPTIONS, TextKey.OPTIONS_SHOW_OPTIONS_DESC));
        this.addOptionAndPosition(new KeyMapper("switchTabs", TextKey.OPTIONS_SWITCH_TABS, TextKey.OPTIONS_SWITCH_TABS_DESC));
        this.addOptionAndPosition(new KeyMapper("GPURenderToggle", TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_TITLE, TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_DESC));
        this.addOptionsChoiceOption();
        if (this.isAirApplication()) {
            this.addOptionAndPosition(new KeyMapper("toggleFullscreen", TextKey.OPTIONS_TOGGLE_FULLSCREEN, TextKey.OPTIONS_TOGGLE_FULLSCREEN_DESC));
        }
    }

    public function isAirApplication():Boolean {
        return ((Capabilities.playerType == "Desktop"));
    }

    public function addOptionsChoiceOption():void {
        var _local1:String = (((Capabilities.os.split(" ")[0] == "Mac")) ? "Command" : "Ctrl");
        var _local2:ChoiceOption = new ChoiceOption("inventorySwap", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK, "", null);
        _local2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK_DESC, {"key": _local1}));
        this.addOptionAndPosition(_local2);
    }

    public function addInventoryOptions():void {
        var _local2:KeyMapper;
        var _local1:int = 1;
        while (_local1 <= 8) {
            _local2 = new KeyMapper(("useInvSlot" + _local1), "", "");
            _local2.setDescription(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N, {"n": _local1}));
            _local2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N_DESC, {"n": _local1}));
            this.addOptionAndPosition(_local2);
            _local1++;
        }
    }

    private function addChatOptions():void {
        this.addOptionAndPosition(new KeyMapper(CHAT, TextKey.OPTIONS_ACTIVATE_CHAT, TextKey.OPTIONS_ACTIVATE_CHAT_DESC));
        this.addOptionAndPosition(new KeyMapper(CHAT_COMMAND, TextKey.OPTIONS_START_CHAT, TextKey.OPTIONS_START_CHAT_DESC));
        this.addOptionAndPosition(new KeyMapper(TELL, TextKey.OPTIONS_BEGIN_TELL, TextKey.OPTIONS_BEGIN_TELL_DESC));
        this.addOptionAndPosition(new KeyMapper(GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT_DESC));
        this.addOptionAndPosition(new ChoiceOption("filterLanguage", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE, TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE_DESC, null));
        this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP_DESC));
        this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN_DESC));
        this.addOptionAndPosition(new ChoiceOption("forceChatQuality", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FORCE_CHAT_QUALITY, TextKey.OPTIONS_FORCE_CHAT_QUALITY_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("hidePlayerChat", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HIDE_PLAYER_CHAT, TextKey.OPTIONS_HIDE_PLAYER_CHAT_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("chatStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_CHAT_STAR_REQ_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("chatAll", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_ALL, TextKey.OPTIONS_CHAT_ALL_DESC, this.onAllChatEnabled));
        this.addOptionAndPosition(new ChoiceOption("chatWhisper", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_WHISPER, TextKey.OPTIONS_CHAT_WHISPER_DESC, this.onAllChatDisabled));
        this.addOptionAndPosition(new ChoiceOption("chatGuild", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_GUILD, TextKey.OPTIONS_CHAT_GUILD_DESC, this.onAllChatDisabled));
        this.addOptionAndPosition(new ChoiceOption("chatTrade", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_TRADE, TextKey.OPTIONS_CHAT_TRADE_DESC, null));
    }

    private function onAllChatDisabled():void {
        var _local2:ChoiceOption;
        Parameters.data_.chatAll = false;
        var _local1:int;
        while (_local1 < this.options_.length) {
            _local2 = (this.options_[_local1] as ChoiceOption);
            if (_local2 != null) {
                switch (_local2.paramName_) {
                    case "chatAll":
                        _local2.refreshNoCallback();
                        break;
                }
            }
            _local1++;
        }
    }

    private function onAllChatEnabled():void {
        var _local2:ChoiceOption;
        Parameters.data_.hidePlayerChat = false;
        Parameters.data_.chatWhisper = true;
        Parameters.data_.chatGuild = true;
        Parameters.data_.chatFriend = false;
        var _local1:int;
        while (_local1 < this.options_.length) {
            _local2 = (this.options_[_local1] as ChoiceOption);
            if (_local2 != null) {
                switch (_local2.paramName_) {
                    case "hidePlayerChat":
                    case "chatWhisper":
                    case "chatGuild":
                    case "chatFriend":
                        _local2.refreshNoCallback();
                        break;
                }
            }
            _local1++;
        }
    }

    private function addExperimentalOptions():void {
        this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable enemy particles", "Disable particles when hit enemy and when enemy is dying.", null));
        this.addOptionAndPosition(new ChoiceOption("disableAllyParticles", makeOnOffLabels(), [true, false], "Disable ally particles", "Disable particles produces by shooting ally.", null));
        this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable players hit particles", "Disable particles when player or ally is hit.", null));
    }

    private function addGraphicsOptions():void {
        var _local1:String;
        var _local2:Number;
        this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle", makeDegreeOptions(), [((7 * Math.PI) / 4), 0], TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE, TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE_DESC, onDefaultCameraAngleChange));
        this.addOptionAndPosition(new ChoiceOption("centerOnPlayer", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CENTER_ON_PLAYER, TextKey.OPTIONS_CENTER_ON_PLAYER_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showQuestPortraits", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_QUEST_PORTRAITS, TextKey.OPTIONS_SHOW_QUEST_PORTRAITS_DESC, this.onShowQuestPortraitsChange));
        this.addOptionAndPosition(new ChoiceOption("showProtips", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TIPS, TextKey.OPTIONS_SHOW_TIPS_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("drawShadows", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_SHADOWS, TextKey.OPTIONS_DRAW_SHADOWS_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("textBubbles", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_TEXT_BUBBLES, TextKey.OPTIONS_DRAW_TEXT_BUBBLES_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showTradePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL, TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL, TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("cursorSelect", makeCursorSelectLabels(), [MouseCursor.AUTO, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], "Custom Cursor", "Click here to change the mouse cursor. May help with aiming.", refreshCursor));
        if (!Parameters.GPURenderError) {
            _local1 = TextKey.OPTIONS_HARDWARE_ACC_DESC;
            _local2 = 0xFFFFFF;
        }
        else {
            _local1 = TextKey.OPTIONS_HARDWARE_ACC_DESC_ERROR;
            _local2 = 16724787;
        }
        this.addOptionAndPosition(new ChoiceOption("GPURender", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HARDWARE_ACC_TITLE, _local1, null, _local2));
        if (Capabilities.playerType == "Desktop") {
            this.addOptionAndPosition(new ChoiceOption("fullscreenMode", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FULLSCREEN_MODE, TextKey.OPTIONS_FULLSCREEN_MODE_DESC, this.onFullscreenChange));
        }
        this.addOptionAndPosition(new ChoiceOption("toggleBarText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_BARTEXT, TextKey.OPTIONS_TOGGLE_BARTEXT_DESC, onBarTextToggle));
        this.addOptionAndPosition(new ChoiceOption("particleEffect", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT, TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("uiQuality", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_UI_QUALITY, TextKey.OPTIONS_TOGGLE_UI_QUALITY_DESC, onUIQualityToggle));
        this.addOptionAndPosition(new ChoiceOption("HPBar", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HPBAR, TextKey.OPTIONS_HPBAR_DESC, null));
    }

    private function onShowQuestPortraitsChange():void {
        if (((((((!((this.gs_ == null))) && (!((this.gs_.map == null))))) && (!((this.gs_.map.partyOverlay_ == null))))) && (!((this.gs_.map.partyOverlay_.questArrow_ == null))))) {
            this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
        }
    }

    private function onFullscreenChange():void {
        stage.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
    }

    private function addSoundOptions():void {
        this.addOptionAndPosition(new ChoiceOption("playMusic", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_MUSIC, TextKey.OPTIONS_PLAY_MUSIC_DESC, this.onPlayMusicChange));
        this.addOptionAndPosition(new SliderOption("musicVolume", this.onMusicVolumeChange), -120, 15);
        this.addOptionAndPosition(new ChoiceOption("playSFX", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_SOUND_EFFECTS, TextKey.OPTIONS_PLAY_SOUND_EFFECTS_DESC, this.onPlaySoundEffectsChange));
        this.addOptionAndPosition(new SliderOption("SFXVolume", this.onSoundEffectsVolumeChange), -120, 34);
        this.addOptionAndPosition(new ChoiceOption("playPewPew", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_WEAPON_SOUNDS, TextKey.OPTIONS_PLAY_WEAPON_SOUNDS_DESC, null));
    }

    private function addMiscOptions():void {
        this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_PRIVACY, TextKey.OPTIONS_LEGAL_PRIVACY_DESC, this.onLegalPrivacyClick));
        this.addOptionAndPosition(new NullOption());
        this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_TOS, TextKey.OPTIONS_LEGAL_TOS_DESC, this.onLegalTOSClick));
        this.addOptionAndPosition(new NullOption());
    }

    private function addFriendOptions():void {
        this.addOptionAndPosition(new ChoiceOption("tradeWithFriends", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TRADE_FRIEND, TextKey.OPTIONS_TRADE_FRIEND_DESC, this.onPlaySoundEffectsChange));
        this.addOptionAndPosition(new KeyMapper("friendList", TextKey.OPTIONS_SHOW_FRIEND_LIST, TextKey.OPTIONS_SHOW_FRIEND_LIST_DESC));
        this.addOptionAndPosition(new ChoiceOption("chatFriend", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_FRIEND, TextKey.OPTIONS_CHAT_FRIEND_DESC, null));
        this.addOptionAndPosition(new ChoiceOption("friendStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_FRIEND_STAR_REQ_DESC, null));
    }

    private function onPlayMusicChange():void {
        Music.setPlayMusic(Parameters.data_.playMusic);
        this.refresh();
    }

    private function onPlaySoundEffectsChange():void {
        SFX.setPlaySFX(Parameters.data_.playSFX);
        if (((Parameters.data_.playSFX) || (Parameters.data_.playPewPew))) {
            SFX.setSFXVolume(1);
        }
        else {
            SFX.setSFXVolume(0);
        }
        this.refresh();
    }

    private function onMusicVolumeChange(_arg1:Number):void {
        Music.setMusicVolume(_arg1);
    }

    private function onSoundEffectsVolumeChange(_arg1:Number):void {
        SFX.setSFXVolume(_arg1);
    }

    private function onLegalPrivacyClick():void {
        var _local1:URLRequest = new URLRequest();
        _local1.url = Parameters.PRIVACY_POLICY_URL;
        _local1.method = URLRequestMethod.GET;
        navigateToURL(_local1, "_blank");
    }

    private function onLegalTOSClick():void {
        var _local1:URLRequest = new URLRequest();
        _local1.url = Parameters.TERMS_OF_USE_URL;
        _local1.method = URLRequestMethod.GET;
        navigateToURL(_local1, "_blank");
    }

    private function addOptionAndPosition(option:Option, offsetX:Number = 0, offsetY:Number = 0):void {
        var positionOption:Function;
        positionOption = function ():void {
            option.x = (((((options_.length % 2) == 0)) ? 20 : 415) + offsetX);
            option.y = (((int((options_.length / 2)) * 44) + 122) + offsetY);
        };
        option.textChanged.addOnce(positionOption);
        this.addOption(option);
    }

    private function addOption(_arg1:Option):void {
        addChild(_arg1);
        _arg1.addEventListener(Event.CHANGE, this.onChange);
        this.options_.push(_arg1);
    }

    private function onChange(_arg1:Event):void {
        this.refresh();
    }

    private function refresh():void {
        var _local2:BaseOption;
        var _local1:int;
        while (_local1 < this.options_.length) {
            _local2 = (this.options_[_local1] as BaseOption);
            if (_local2 != null) {
                _local2.refresh();
            }
            _local1++;
        }
    }


}
}
