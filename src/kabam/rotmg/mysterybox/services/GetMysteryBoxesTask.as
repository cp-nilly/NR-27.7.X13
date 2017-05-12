package kabam.rotmg.mysterybox.services {
import com.company.assembleegameclient.util.TimeUtil;

import flash.utils.getTimer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.model.FortuneInfo;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import robotlegs.bender.framework.api.ILogger;

public class GetMysteryBoxesTask extends BaseTask {

    private static const TEN_MINUTES:int = 600;

    private static var version:String = "0";

    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var mysteryBoxModel:MysteryBoxModel;
    [Inject]
    public var fortuneModel:FortuneModel;
    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var languageModel:LanguageModel;
    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    public var lastRan:uint = 0;


    override protected function startTask():void {
        var _local1:Number;
        var _local2:Object;
        if (DynamicSettings.settingExists("MysteryBoxRefresh")) {
            _local1 = DynamicSettings.getSettingValue("MysteryBoxRefresh");
        }
        else {
            _local1 = TEN_MINUTES;
        }
        if ((((this.lastRan == 0)) || (((this.lastRan + _local1) < (getTimer() / 1000))))) {
            this.lastRan = (getTimer() / 1000);
            completeTask(true);
            _local2 = this.account.getCredentials();
            _local2.language = this.languageModel.getLanguage();
            _local2.version = version;
            this.client.sendRequest("/mysterybox/getBoxes", _local2);
            this.client.complete.addOnce(this.onComplete);
        }
        else {
            completeTask(true);
            reset();
        }
    }

    public function clearLastRanBlock():void {
        this.lastRan = 0;
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        reset();
        if (_arg1) {
            this.handleOkay(_arg2);
        }
        else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(false);
        }
    }

    private function handleOkay(_arg1:*):void {
        var _local2:XMLList;
        var _local3:XMLList;
        if (this.hasNoBoxes(_arg1)) {
            if (this.mysteryBoxModel.isInitialized()) {
                return;
            }
            this.mysteryBoxModel.setInitialized(false);
        }
        else {
            version = XML(_arg1).attribute("version").toString();
            _local2 = XML(_arg1).child("MysteryBox");
            this.parse(_local2);
            _local3 = XML(_arg1).child("FortuneGame");
            if (_local3.length() > 0) {
                this.parseFortune(_local3);
            }
        }
        completeTask(true);
    }

    private function hasNoBoxes(_arg1:*):Boolean {
        var _local2:XMLList = XML(_arg1).children();
        return ((_local2.length() == 0));
    }

    private function parseFortune(_arg1:XMLList):void {
        var _local2:FortuneInfo = new FortuneInfo();
        _local2.id = _arg1.attribute("id").toString();
        _local2.title = _arg1.attribute("title").toString();
        _local2.weight = _arg1.attribute("weight").toString();
        _local2.description = _arg1.Description.toString();
        _local2.contents = _arg1.Contents.toString();
        _local2.priceFirstInGold = _arg1.Price.attribute("firstInGold").toString();
        _local2.priceFirstInToken = _arg1.Price.attribute("firstInToken").toString();
        _local2.priceSecondInGold = _arg1.Price.attribute("secondInGold").toString();
        _local2.iconImageUrl = _arg1.Icon.toString();
        _local2.infoImageUrl = _arg1.Image.toString();
        _local2.startTime = TimeUtil.parseUTCDate(_arg1.StartTime.toString());
        _local2.endTime = TimeUtil.parseUTCDate(_arg1.EndTime.toString());
        _local2.parseContents();
        this.fortuneModel.setFortune(_local2);
    }

    private function parse(_arg1:XMLList):void {
        var _local4:XML;
        var _local5:MysteryBoxInfo;
        var _local2:Array = [];
        var _local3:Boolean;
        for each (_local4 in _arg1) {
            _local5 = new MysteryBoxInfo();
            _local5.id = _local4.attribute("id").toString();
            _local5.title = _local4.attribute("title").toString();
            _local5.weight = _local4.attribute("weight").toString();
            _local5.description = _local4.Description.toString();
            _local5.contents = _local4.Contents.toString();
            _local5.priceAmount = _local4.Price.attribute("amount").toString();
            _local5.priceCurrency = _local4.Price.attribute("currency").toString();
            if (_local4.hasOwnProperty("Sale")) {
                _local5.saleAmount = _local4.Sale.attribute("price").toString();
                _local5.saleCurrency = _local4.Sale.attribute("currency").toString();
                _local5.saleEnd = TimeUtil.parseUTCDate(_local4.Sale.End.toString());
            }
            if (_local4.hasOwnProperty("Left")) {
                _local5.unitsLeft = _local4.Left;
            }
            if (_local4.hasOwnProperty("Total")) {
                _local5.totalUnits = _local4.Total;
            }
            _local5.iconImageUrl = _local4.Icon.toString();
            _local5.infoImageUrl = _local4.Image.toString();
            _local5.startTime = TimeUtil.parseUTCDate(_local4.StartTime.toString());
            _local5.parseContents();
            if (((!(_local3)) && (((_local5.isNew()) || (_local5.isOnSale()))))) {
                _local3 = true;
            }
            _local2.push(_local5);
        }
        this.mysteryBoxModel.setMysetryBoxes(_local2);
        this.mysteryBoxModel.isNew = _local3;
    }


}
}
