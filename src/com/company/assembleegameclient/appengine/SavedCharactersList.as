package com.company.assembleegameclient.appengine {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.dialogs.TOSPopup;

import flash.events.Event;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.servers.api.LatLong;

import org.swiftsuspenders.Injector;

public class SavedCharactersList extends Event {

    public static const SAVED_CHARS_LIST:String = "SAVED_CHARS_LIST";
    public static const AVAILABLE:String = "available";
    public static const UNAVAILABLE:String = "unavailable";
    public static const UNRESTRICTED:String = "unrestricted";
    private static const DEFAULT_LATLONG:LatLong = new LatLong(37.4436, -122.412);
    private static const DEFAULT_SALESFORCE:String = "unavailable";

    private var origData_:String;
    private var charsXML_:XML;
    public var accountId_:String;
    public var nextCharId_:int;
    public var maxNumChars_:int;
    public var numChars_:int = 0;
    public var savedChars_:Vector.<SavedCharacter>;
    public var charStats_:Object;
    public var totalFame_:int = 0;
    public var fame_:int = 0;
    public var credits_:int = 0;
    public var tokens_:int = 0;
    public var numStars_:int = 0;
    public var nextCharSlotPrice_:int;
    public var charSlotCurrency_:int;
    public var guildName_:String;
    public var guildRank_:int;
    public var name_:String = null;
    public var nameChosen_:Boolean;
    public var converted_:Boolean;
    public var isAdmin_:Boolean;
    public var canMapEdit_:Boolean;
    public var news_:Vector.<SavedNewsItem>;
    public var myPos_:LatLong;
    public var salesForceData_:String = "unavailable";
    public var hasPlayerDied:Boolean = false;
    public var classAvailability:Object;
    public var isAgeVerified:Boolean;
    public var rank_:int;
    public var menuMusic_:String;
    public var deadMusic_:String;
    private var account:Account;

    public function SavedCharactersList(_arg1:String) {
        var _local4:*;
        var _local5:Account;
        this.savedChars_ = new Vector.<SavedCharacter>();
        this.charStats_ = {};
        this.news_ = new Vector.<SavedNewsItem>();
        super(SAVED_CHARS_LIST);
        this.origData_ = _arg1;
        this.charsXML_ = new XML(this.origData_);
        var _local2:XML = XML(this.charsXML_.Account);
        this.parseUserData(_local2);
        this.parseBeginnersPackageData(_local2);
        this.parseGuildData(_local2);
        this.parseCharacterData();
        this.parseCharacterStatsData();
        this.parseNewsData();
        this.parseGeoPositioningData();
        this.parseSalesForceData();
        this.parseTOSPopup();
        this.reportUnlocked();
        var _local3:Injector = StaticInjectorContext.getInjector();
        if (_local3) {
            _local5 = _local3.getInstance(Account);
            _local5.reportIntStat("BestLevel", this.bestOverallLevel());
            _local5.reportIntStat("BestFame", this.bestOverallFame());
            _local5.reportIntStat("NumStars", this.numStars_);
            _local5.verify(_local2.hasOwnProperty("VerifiedEmail"));
        }
        this.classAvailability = new Object();
        for each (_local4 in this.charsXML_.ClassAvailabilityList.ClassAvailability) {
            this.classAvailability[_local4.@id.toString()] = _local4.toString();
        }
    }

    public function getCharById(_arg1:int):SavedCharacter {
        var _local2:SavedCharacter;
        for each (_local2 in this.savedChars_) {
            if (_local2.charId() == _arg1) {
                return (_local2);
            }
        }
        return (null);
    }

    private function parseUserData(_arg1:XML):void {
        this.accountId_ = _arg1.AccountId;
        this.name_ = _arg1.Name;
        this.nameChosen_ = _arg1.hasOwnProperty("NameChosen");
        this.converted_ = _arg1.hasOwnProperty("Converted");
        this.isAdmin_ = _arg1.hasOwnProperty("Admin");
        this.rank_ = int(_arg1.Rank);
        Player.isAdmin = this.isAdmin_;
        Player.rank = this.rank_;
        Player.isMod = _arg1.hasOwnProperty("Mod");
        this.canMapEdit_ = _arg1.hasOwnProperty("MapEditor");
        this.totalFame_ = int(_arg1.Stats.TotalFame);
        this.fame_ = int(_arg1.Stats.Fame);
        this.credits_ = int(_arg1.Credits);
        this.tokens_ = int(_arg1.FortuneToken);
        this.nextCharSlotPrice_ = int(_arg1.NextCharSlotPrice);
        this.charSlotCurrency_ = int(_arg1.CharSlotCurrency);
        this.isAgeVerified = ((!((this.accountId_ == ""))) && ((_arg1.IsAgeVerified == 1)));
        this.hasPlayerDied = true;
        this.menuMusic_ = _arg1.MenuMusic;
        this.deadMusic_ = _arg1.DeadMusic;
    }

    private function parseBeginnersPackageData(_arg1:XML):void {
        var _local2:Number;
        var _local3:BeginnersPackageModel;
        if (_arg1.hasOwnProperty("BeginnerPackageTimeLeft")) {
            _local2 = _arg1.BeginnerPackageTimeLeft;
            _local3 = this.getBeginnerModel();
            _local3.setBeginnersOfferSecondsLeft(_local2);
        }
    }

    private function getBeginnerModel():BeginnersPackageModel {
        var _local1:Injector = StaticInjectorContext.getInjector();
        return (_local1.getInstance(BeginnersPackageModel));
    }

    private function parseGuildData(_arg1:XML):void {
        var _local2:XML;
        if (_arg1.hasOwnProperty("Guild")) {
            _local2 = XML(_arg1.Guild);
            this.guildName_ = _local2.Name;
            this.guildRank_ = int(_local2.Rank);
        }
    }

    private function parseCharacterData():void {
        var _local1:XML;
        this.nextCharId_ = int(this.charsXML_.@nextCharId);
        this.maxNumChars_ = int(this.charsXML_.@maxNumChars);
        for each (_local1 in this.charsXML_.Char) {
            this.savedChars_.push(new SavedCharacter(_local1, this.name_));
            this.numChars_++;
        }
        this.savedChars_.sort(SavedCharacter.compare);
    }

    private function parseCharacterStatsData():void {
        var _local2:XML;
        var _local3:int;
        var _local4:CharacterStats;
        var _local1:XML = XML(this.charsXML_.Account.Stats);
        for each (_local2 in _local1.ClassStats) {
            _local3 = int(_local2.@objectType);
            _local4 = new CharacterStats(_local2);
            this.numStars_ = (this.numStars_ + _local4.numStars());
            this.charStats_[_local3] = _local4;
        }
    }

    private function parseNewsData():void {
        var _local2:XML;
        var _local1:XML = XML(this.charsXML_.News);
        for each (_local2 in _local1.Item) {
            this.news_.push(new SavedNewsItem(_local2.Icon, _local2.Title, _local2.TagLine, _local2.Link, int(_local2.Date)));
        }
    }

    private function parseGeoPositioningData():void {
        if (((this.charsXML_.hasOwnProperty("Lat")) && (this.charsXML_.hasOwnProperty("Long")))) {
            this.myPos_ = new LatLong(Number(this.charsXML_.Lat), Number(this.charsXML_.Long));
        }
        else {
            this.myPos_ = DEFAULT_LATLONG;
        }
    }

    private function parseSalesForceData():void {
        if (((this.charsXML_.hasOwnProperty("SalesForce")) && (this.charsXML_.hasOwnProperty("SalesForce")))) {
            this.salesForceData_ = String(this.charsXML_.SalesForce);
        }
    }

    private function parseTOSPopup():void {
        if (this.charsXML_.hasOwnProperty("TOSPopup")) {
            StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(new TOSPopup());
        }
    }

    public function isFirstTimeLogin():Boolean {
        return (!(this.charsXML_.hasOwnProperty("TOSPopup")));
    }

    public function bestLevel(_arg1:int):int {
        var _local2:CharacterStats = this.charStats_[_arg1];
        return ((((_local2 == null)) ? 0 : _local2.bestLevel()));
    }

    public function bestOverallLevel():int {
        var _local2:CharacterStats;
        var _local1:int;
        for each (_local2 in this.charStats_) {
            if (_local2.bestLevel() > _local1) {
                _local1 = _local2.bestLevel();
            }
        }
        return (_local1);
    }

    public function bestFame(_arg1:int):int {
        var _local2:CharacterStats = this.charStats_[_arg1];
        return ((((_local2 == null)) ? 0 : _local2.bestFame()));
    }

    public function bestOverallFame():int {
        var _local2:CharacterStats;
        var _local1:int;
        for each (_local2 in this.charStats_) {
            if (_local2.bestFame() > _local1) {
                _local1 = _local2.bestFame();
            }
        }
        return (_local1);
    }

    public function levelRequirementsMet(_arg1:int):Boolean {
        var _local3:XML;
        var _local4:int;
        var _local2:XML = ObjectLibrary.xmlLibrary_[_arg1];
        for each (_local3 in _local2.UnlockLevel) {
            _local4 = ObjectLibrary.idToType_[_local3.toString()];
            if (this.bestLevel(_local4) < int(_local3.@level)) {
                return (false);
            }
        }
        return (true);
    }

    public function availableCharSlots():int {
        return ((this.maxNumChars_ - this.numChars_));
    }

    public function hasAvailableCharSlot():Boolean {
        return ((this.numChars_ < this.maxNumChars_));
    }

    public function newUnlocks(_arg1:int, _arg2:int):Array {
        var _local5:XML;
        var _local6:int;
        var _local7:Boolean;
        var _local8:Boolean;
        var _local9:XML;
        var _local10:int;
        var _local11:int;
        var _local3:Array = new Array();
        var _local4:int;
        while (_local4 < ObjectLibrary.playerChars_.length) {
            _local5 = ObjectLibrary.playerChars_[_local4];
            _local6 = int(_local5.@type);
            if (!this.levelRequirementsMet(_local6)) {
                _local7 = true;
                _local8 = false;
                for each (_local9 in _local5.UnlockLevel) {
                    _local10 = ObjectLibrary.idToType_[_local9.toString()];
                    _local11 = int(_local9.@level);
                    if (this.bestLevel(_local10) < _local11) {
                        if (((!((_local10 == _arg1))) || (!((_local11 == _arg2))))) {
                            _local7 = false;
                            break;
                        }
                        _local8 = true;
                    }
                }
                if (((_local7) && (_local8))) {
                    _local3.push(_local6);
                }
            }
            _local4++;
        }
        return (_local3);
    }

    override public function clone():Event {
        return (new SavedCharactersList(this.origData_));
    }

    override public function toString():String {
        return (((((("[" + " numChars: ") + this.numChars_) + " maxNumChars: ") + this.maxNumChars_) + " ]"));
    }

    private function reportUnlocked():void {
        var _local1:Injector = StaticInjectorContext.getInjector();
        if (_local1) {
            this.account = _local1.getInstance(Account);
            ((this.account) && (this.updateAccount()));
        }
    }

    private function updateAccount():void {
        var _local3:XML;
        var _local4:int;
        var _local1:int;
        var _local2:int;
        while (_local2 < ObjectLibrary.playerChars_.length) {
            _local3 = ObjectLibrary.playerChars_[_local2];
            _local4 = int(_local3.@type);
            if (this.levelRequirementsMet(_local4)) {
                this.account.reportIntStat((_local3.@id + "Unlocked"), 1);
                _local1++;
            }
            _local2++;
        }
        this.account.reportIntStat("ClassesUnlocked", _local1);
    }


}
}
