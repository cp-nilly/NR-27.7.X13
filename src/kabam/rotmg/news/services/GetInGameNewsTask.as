package kabam.rotmg.news.services {
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.model.PopupNamesConfig;
import kabam.rotmg.news.model.InGameNews;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.news.view.NewsModal;

import robotlegs.bender.framework.api.ILogger;

public class GetInGameNewsTask extends BaseTask {

    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var model:NewsModel;
    [Inject]
    public var addToQueueSignal:AddPopupToStartupQueueSignal;
    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    private var requestData:Object;


    override protected function startTask():void {
        this.logger.info("GetInGameNewsTask start");
        this.requestData = this.makeRequestData();
        this.sendRequest();
    }

    public function makeRequestData():Object {
        return ({});
    }

    private function sendRequest():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/inGameNews/getNews", this.requestData);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        this.logger.info(("String response from GetInGameNewsTask: " + _arg2));
        if (_arg1) {
            this.parseNews(_arg2);
        }
        else {
            completeTask(true);
        }
    }

    private function parseNews(_arg1:String) {
        var _local3:Object;
        var _local4:Object;
        var _local5:InGameNews;
        this.logger.info("Parsing news");
        try {
            _local3 = JSON.parse(_arg1);
            for each (_local4 in _local3) {
                this.logger.info("Parse single news");
                _local5 = new InGameNews();
                _local5.newsKey = _local4.newsKey;
                _local5.showAtStartup = _local4.showAtStartup;
                _local5.startTime = _local4.startTime;
                _local5.text = _local4.text;
                _local5.title = _local4.title;
                _local5.platform = _local4.platform;
                _local5.weight = _local4.weight;
                this.model.addInGameNews(_local5);
            }
        }
        catch (e:Error) {
        }
        var _local2:InGameNews = this.model.getFirstNews();
        if (((((_local2) && (_local2.showAtStartup))) && (this.model.hasUpdates()))) {
            this.addToQueueSignal.dispatch(PopupNamesConfig.NEWS_POPUP, this.openDialogSignal, -1, new NewsModal(true));
        }
        completeTask(true);
    }


}
}
