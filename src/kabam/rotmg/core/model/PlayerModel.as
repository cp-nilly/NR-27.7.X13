package kabam.rotmg.core.model {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.appengine.SavedCharactersList;
import com.company.assembleegameclient.appengine.SavedNewsItem;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.kongregate.KongregateAccount;
import kabam.rotmg.servers.api.LatLong;

import org.osflash.signals.Signal;

public class PlayerModel {

    public const creditsChanged:Signal = new Signal(int);
    public const fameChanged:Signal = new Signal(int);
    public const tokensChanged:Signal = new Signal(int);

    public var charList:SavedCharactersList;
    public var isInvalidated:Boolean;
    private var _currentCharId:int;
    private var isAgeVerified:Boolean;
    [Inject]
    public var account:Account;

    public function PlayerModel() {
        this.isInvalidated = true;
    }

    public function set currentCharId(_arg1:int):void {
        this._currentCharId = _arg1;
    }

    public function get currentCharId():int {
        return (this._currentCharId);
    }

    public function getHasPlayerDied():Boolean {
        return (this.charList.hasPlayerDied);
    }

    public function setHasPlayerDied(_arg1:Boolean):void {
        this.charList.hasPlayerDied = _arg1;
    }

    public function getIsAgeVerified():Boolean {
        return (((((this.isAgeVerified) || ((this.account is KongregateAccount)))) || (this.charList.isAgeVerified)));
    }

    public function setIsAgeVerified(_arg1:Boolean):void {
        this.isAgeVerified = true;
    }

    public function isNewPlayer():Boolean {
        return (((Parameters.data_.needsTutorial) && ((this.charList.nextCharId_ == 1))));
    }

    public function getMaxCharacters():int {
        return (this.charList.maxNumChars_);
    }

    public function setMaxCharacters(_arg1:int):void {
        this.charList.maxNumChars_ = _arg1;
    }

    public function getCredits():int {
        return (this.charList.credits_);
    }

    public function getSalesForceData():String {
        return (this.charList.salesForceData_);
    }

    public function changeCredits(_arg1:int):void {
        this.charList.credits_ = (this.charList.credits_ + _arg1);
        this.creditsChanged.dispatch(this.charList.credits_);
    }

    public function setCredits(_arg1:int):void {
        if (this.charList.credits_ != _arg1) {
            this.charList.credits_ = _arg1;
            this.creditsChanged.dispatch(_arg1);
        }
    }

    public function getFame():int {
        return (this.charList.fame_);
    }

    public function changeFame(amount:int):void {
        this.charList.fame_ = this.charList.fame_ + amount;
        this.fameChanged.dispatch(this.charList.fame_);
    }

    public function setFame(_arg1:int):void {
        if (this.charList.fame_ != _arg1) {
            this.charList.fame_ = _arg1;
            this.fameChanged.dispatch(_arg1);
        }
    }

    public function getTokens():int {
        return (this.charList.tokens_);
    }

    public function setTokens(_arg1:int):void {
        if (this.charList.tokens_ != _arg1) {
            this.charList.tokens_ = _arg1;
            this.tokensChanged.dispatch(_arg1);
        }
    }

    public function getCharacterCount():int {
        return (this.charList.numChars_);
    }

    public function getCharById(_arg1:int):SavedCharacter {
        return (this.charList.getCharById(_arg1));
    }

    public function deleteCharacter(_arg1:int):void {
        var _local2:SavedCharacter = this.charList.getCharById(_arg1);
        var _local3:int = this.charList.savedChars_.indexOf(_local2);
        if (_local3 != -1) {
            this.charList.savedChars_.splice(_local3, 1);
            this.charList.numChars_--;
        }
    }

    public function getAccountId():String {
        return (this.charList.accountId_);
    }

    public function hasAccount():Boolean {
        return (!((this.charList.accountId_ == "")));
    }

    public function getNumStars():int {
        return (this.charList.numStars_);
    }

    public function getGuildName():String {
        return (this.charList.guildName_);
    }

    public function getGuildRank():int {
        return (this.charList.guildRank_);
    }

    public function getCharSlotPrice():int {
        return this.charList.nextCharSlotPrice_;
    }

    public function getCharSlotCurrency():int { // 0 = gold, 1 = fame
        return this.charList.charSlotCurrency_;
    }

    public function getTotalFame():int {
        return (this.charList.totalFame_);
    }

    public function getNextCharId():int {
        return (this.charList.nextCharId_);
    }

    public function getCharacterById(_arg1:int):SavedCharacter {
        var _local2:SavedCharacter;
        for each (_local2 in this.charList.savedChars_) {
            if (_local2.charId() == _arg1) {
                return (_local2);
            }
        }
        return (null);
    }

    public function getCharacterByIndex(_arg1:int):SavedCharacter {
        return (this.charList.savedChars_[_arg1]);
    }

    public function getRank():int {
        return (this.charList.rank_);
    }

    public function isAdmin():Boolean {
        return (this.charList.isAdmin_);
    }

    public function mapEditor():Boolean {
        return (this.charList.canMapEdit_);
    }

    public function getNews():Vector.<SavedNewsItem> {
        return (this.charList.news_);
    }

    public function getMyPos():LatLong {
        return (this.charList.myPos_);
    }

    public function setClassAvailability(_arg1:int, _arg2:String):void {
        this.charList.classAvailability[_arg1] = _arg2;
    }

    public function getName():String {
        return (this.charList.name_);
    }

    public function getConverted():Boolean {
        return (this.charList.converted_);
    }

    public function setName(_arg1:String):void {
        this.charList.name_ = _arg1;
    }

    public function isNameChosen():Boolean {
        return (this.charList.nameChosen_);
    }

    public function getNewUnlocks(_arg1:int, _arg2:int):Array {
        return (this.charList.newUnlocks(_arg1, _arg2));
    }

    public function hasAvailableCharSlot():Boolean {
        return (this.charList.hasAvailableCharSlot());
    }

    public function getAvailableCharSlots():int {
        return (this.charList.availableCharSlots());
    }

    public function getSavedCharacters():Vector.<SavedCharacter> {
        return (this.charList.savedChars_);
    }

    public function getCharStats():Object {
        return (this.charList.charStats_);
    }

    public function isClassAvailability(_arg1:String, _arg2:String):Boolean {
        var _local3:String = this.charList.classAvailability[_arg1];
        return ((_local3 == _arg2));
    }

    public function isLevelRequirementsMet(_arg1:int):Boolean {
        return (this.charList.levelRequirementsMet(_arg1));
    }

    public function getBestFame(_arg1:int):int {
        return (this.charList.bestFame(_arg1));
    }

    public function getBestLevel(_arg1:int):int {
        return (this.charList.bestLevel(_arg1));
    }

    public function setCharacterList(_arg1:SavedCharactersList):void {
        this.charList = _arg1;
    }

    public function isNewToEditing():Boolean {
        if (((this.charList) && (!(this.charList.isFirstTimeLogin())))) {
            return (false);
        }
        return (true);
    }

    public function getMenuMusic():String {
        return this.charList.menuMusic_;
    }

    public function getDeadMusic():String {
        return this.charList.deadMusic_;
    }
}
}
