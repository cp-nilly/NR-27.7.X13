package com.company.assembleegameclient.parameters {
import com.company.assembleegameclient.map.Map;
import com.company.util.KeyCodes;
import com.company.util.MoreDateUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.net.SharedObject;
import flash.system.Capabilities;
import flash.utils.Dictionary;

public class Parameters {

    public static const BUILD_VERSION:String = "27.7";
    public static const MINOR_VERSION:String = "X13";
    public static const FULL_BUILD:String = BUILD_VERSION + "." + MINOR_VERSION;
    public static const ENABLE_ENCRYPTION:Boolean = true;
    public static const PORT:int = 2050;
    public static const ALLOW_SCREENSHOT_MODE:Boolean = false;
    public static const FELLOW_GUILD_COLOR:uint = 10944349;
    public static const NAME_CHOSEN_COLOR:uint = 0xFCDF00;
    public static const PLAYER_ROTATE_SPEED:Number = 0.003;
    public static const BREATH_THRESH:int = 20;
    public static const SERVER_CHAT_NAME:String = "";
    public static const CLIENT_CHAT_NAME:String = "*Client*";
    public static const ERROR_CHAT_NAME:String = "*Error*";
    public static const HELP_CHAT_NAME:String = "*Help*";
    public static const GUILD_CHAT_NAME:String = "*Guild*";
    public static const NEWS_TIMESTAMP_DEFAULT:Number = 1.1;
    public static const NAME_CHANGE_PRICE:int = 5000;
    public static const GUILD_CREATION_PRICE:int = 1000;
    public static const TUTORIAL_GAMEID:int = -1;
    public static const NEXUS_GAMEID:int = -2;
    public static const RANDOM_REALM_GAMEID:int = -3;
    public static const MAPTEST_GAMEID:int = -6;
    public static const MAX_SINK_LEVEL:Number = 18;
    public static const TERMS_OF_USE_URL:String = "http://legal.decagames.io/tos";
    public static const PRIVACY_POLICY_URL:String = "http://legal.decagames.io/privacy";
    public static const USER_GENERATED_CONTENT_TERMS:String = "/UGDTermsofUse.html";
    public static const RANDOM1:String = "B1A5ED";
    public static const RANDOM2:String = "612a806cac78114ba5013cb531";
    public static const RSA_PUBLIC_KEY:String = 
        "-----BEGIN PUBLIC KEY-----\n" + 
        "MFswDQYJKoZIhvcNAQEBBQADSgAwRwJAeyjMOLhcK4o2AnFRhn8vPteUy5Fux/cX" +
        "N/J+wT/zYIEUINo02frn+Kyxx0RIXJ3CvaHkwmueVL8ytfqo8Ol/OwIDAQAB\n" +
        "-----END PUBLIC KEY-----";
    public static const skinTypes16:Vector.<int> = new <int>[1027, 0x0404, 1029, 1030, 10973];
    public static const itemTypes16:Vector.<int> = new <int>[5473, 5474, 5475, 5476, 10939];

    public static var root:DisplayObject;
    public static var data_:Object = null;
    public static var GPURenderError:Boolean = false;
    public static var blendType_:int = 1;
    public static var projColorType_:int = 0;
    public static var drawProj_:Boolean = true;
    public static var screenShotMode_:Boolean = false;
    public static var screenShotSlimMode_:Boolean = false;
    public static var sendLogin_:Boolean = true;
    private static var savedOptions_:SharedObject = null;
    public static var toggleHPBar_:Boolean = false;
    private static var keyNames_:Dictionary = new Dictionary();


    public static function load():void {
        try {
            savedOptions_ = SharedObject.getLocal("AssembleeGameClientOptions", "/");
            data_ = savedOptions_.data;
        }
        catch (error:Error) {
            data_ = new Object();
        }
        setDefaults();
        save();
    }

    public static function save():void {
        try {
            if (savedOptions_ != null) {
                savedOptions_.flush();
            }
        }
        catch (error:Error) {
        }
    }

    private static function setDefaultKey(_arg1:String, _arg2:uint):void {
        if (!data_.hasOwnProperty(_arg1)) {
            data_[_arg1] = _arg2;
        }
        keyNames_[_arg1] = true;
    }

    public static function setKey(_arg1:String, _arg2:uint):void {
        var _local3:String;
        for (_local3 in keyNames_) {
            if (data_[_local3] == _arg2) {
                data_[_local3] = KeyCodes.UNSET;
            }
        }
        data_[_arg1] = _arg2;
    }

    private static function setDefault(_arg1:String, _arg2:*):void {
        if (!data_.hasOwnProperty(_arg1)) {
            data_[_arg1] = _arg2;
        }
    }

    public static function isGpuRender():Boolean {
        return !GPURenderError && data_.GPURender && !Map.forceSoftwareRender;
    }

    public static function clearGpuRenderEvent(_arg1:Event):void {
        clearGpuRender();
    }

    public static function clearGpuRender():void {
        GPURenderError = true;
    }

    public static function setDefaults():void {
        setDefaultKey("moveLeft", KeyCodes.A);
        setDefaultKey("moveRight", KeyCodes.D);
        setDefaultKey("moveUp", KeyCodes.W);
        setDefaultKey("moveDown", KeyCodes.S);
        setDefaultKey("rotateLeft", KeyCodes.Q);
        setDefaultKey("rotateRight", KeyCodes.E);
        setDefaultKey("useSpecial", KeyCodes.SPACE);
        setDefaultKey("interact", KeyCodes.NUMBER_0);
        setDefaultKey("useInvSlot1", KeyCodes.NUMBER_1);
        setDefaultKey("useInvSlot2", KeyCodes.NUMBER_2);
        setDefaultKey("useInvSlot3", KeyCodes.NUMBER_3);
        setDefaultKey("useInvSlot4", KeyCodes.NUMBER_4);
        setDefaultKey("useInvSlot5", KeyCodes.NUMBER_5);
        setDefaultKey("useInvSlot6", KeyCodes.NUMBER_6);
        setDefaultKey("useInvSlot7", KeyCodes.NUMBER_7);
        setDefaultKey("useInvSlot8", KeyCodes.NUMBER_8);
        setDefaultKey("escapeToNexus2", KeyCodes.F5);
        setDefaultKey("escapeToNexus", KeyCodes.R);
        setDefaultKey("autofireToggle", KeyCodes.I);
        setDefaultKey("scrollChatUp", KeyCodes.PAGE_UP);
        setDefaultKey("scrollChatDown", KeyCodes.PAGE_DOWN);
        setDefaultKey("miniMapZoomOut", KeyCodes.MINUS);
        setDefaultKey("miniMapZoomIn", KeyCodes.EQUAL);
        setDefaultKey("resetToDefaultCameraAngle", KeyCodes.Z);
        setDefaultKey("togglePerformanceStats", KeyCodes.UNSET);
        setDefaultKey("options", KeyCodes.O);
        setDefaultKey("toggleCentering", KeyCodes.X);
        setDefaultKey("chat", KeyCodes.ENTER);
        setDefaultKey("chatCommand", KeyCodes.SLASH);
        setDefaultKey("tell", KeyCodes.TAB);
        setDefaultKey("guildChat", KeyCodes.G);
        setDefaultKey("testOne", KeyCodes.PERIOD);
        setDefaultKey("toggleFullscreen", KeyCodes.UNSET);
        setDefaultKey("useHealthPotion", KeyCodes.F);
        setDefaultKey("GPURenderToggle", KeyCodes.UNSET);
        setDefaultKey("friendList", KeyCodes.UNSET);
        setDefaultKey("useMagicPotion", KeyCodes.V);
        setDefaultKey("switchTabs", KeyCodes.B);
        setDefaultKey("particleEffect", KeyCodes.P);
        setDefaultKey("toggleHPBar", KeyCodes.H);
        setDefault("playerObjectType", 782);
        setDefault("playMusic", true);
        setDefault("playSFX", true);
        setDefault("playPewPew", true);
        setDefault("centerOnPlayer", true);
        setDefault("preferredServer", null);
        setDefault("needsTutorial", true);
        setDefault("needsRandomRealm", true);
        setDefault("cameraAngle", ((7 * Math.PI) / 4));
        setDefault("defaultCameraAngle", ((7 * Math.PI) / 4));
        setDefault("showQuestPortraits", true);
        setDefault("fullscreenMode", false);
        setDefault("showProtips", true);
        setDefault("protipIndex", 0);
        setDefault("joinDate", MoreDateUtil.getDayStringInPT());
        setDefault("lastDailyAnalytics", null);
        setDefault("allowRotation", true);
        setDefault("allowMiniMapRotation", false);
        setDefault("charIdUseMap", {});
        setDefault("drawShadows", true);
        setDefault("textBubbles", true);
        setDefault("showTradePopup", true);
        setDefault("paymentMethod", null);
        setDefault("filterLanguage", true);
        setDefault("showGuildInvitePopup", true);
        setDefault("showBeginnersOffer", false);
        setDefault("beginnersOfferTimeLeft", 0);
        setDefault("beginnersOfferShowNow", false);
        setDefault("beginnersOfferShowNowTime", 0);
        setDefault("watchForTutorialExit", false);
        setDefault("clickForGold", false);
        setDefault("contextualPotionBuy", true);
        setDefault("inventorySwap", true);
        setDefault("particleEffect", false);
        setDefault("uiQuality", true);
        setDefault("disableEnemyParticles", false);
        setDefault("disableAllyParticles", false);
        setDefault("disablePlayersHitParticles", false);
        setDefault("cursorSelect", "4");
        setDefault("friendListDisplayFlag", false);
        if (Capabilities.playerType == "Desktop") {
            setDefault("GPURender", false);
        }
        else {
            setDefault("GPURender", false);
        }
        setDefault("forceChatQuality", false);
        setDefault("hidePlayerChat", false);
        setDefault("chatStarRequirement", 1);
        setDefault("chatAll", true);
        setDefault("chatWhisper", true);
        setDefault("chatGuild", true);
        setDefault("chatTrade", true);
        setDefault("toggleBarText", false);
        setDefault("particleEffect", true);
        if (((data_.hasOwnProperty("playMusic")) && ((data_.playMusic == true)))) {
            setDefault("musicVolume", 1);
        }
        else {
            setDefault("musicVolume", 0);
        }
        if (((data_.hasOwnProperty("playSFX")) && ((data_.playMusic == true)))) {
            setDefault("SFXVolume", 1);
        }
        else {
            setDefault("SFXVolume", 0);
        }
        setDefault("friendList", KeyCodes.UNSET);
        setDefault("tradeWithFriends", false);
        setDefault("chatFriend", false);
        setDefault("friendStarRequirement", 0);
        setDefault("HPBar", false);
        if (!data_.hasOwnProperty("needsSurvey")) {
            data_.needsSurvey = data_.needsTutorial;
            switch (int((Math.random() * 5))) {
                case 0:
                    data_.surveyDate = 0;
                    data_.playTimeLeftTillSurvey = (5 * 60);
                    data_.surveyGroup = "5MinPlaytime";
                    return;
                case 1:
                    data_.surveyDate = 0;
                    data_.playTimeLeftTillSurvey = (10 * 60);
                    data_.surveyGroup = "10MinPlaytime";
                    return;
                case 2:
                    data_.surveyDate = 0;
                    data_.playTimeLeftTillSurvey = (30 * 60);
                    data_.surveyGroup = "30MinPlaytime";
                    return;
                case 3:
                    data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 7));
                    data_.playTimeLeftTillSurvey = (2 * 60);
                    data_.surveyGroup = "1WeekRealtime";
                    return;
                case 4:
                    data_.surveyDate = (new Date().time + ((((1000 * 60) * 60) * 24) * 14));
                    data_.playTimeLeftTillSurvey = (2 * 60);
                    data_.surveyGroup = "2WeekRealtime";
                    return;
            }
        }
    }


}
}
