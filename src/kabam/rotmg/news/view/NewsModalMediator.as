package kabam.rotmg.news.view {
import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
import kabam.rotmg.news.controller.NewsDataUpdatedSignal;
import kabam.rotmg.news.model.NewsCellVO;
import kabam.rotmg.news.model.NewsModel;
import kabam.rotmg.news.services.GetAppEngineNewsTask;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewsModalMediator extends Mediator {

    public static var firstRun:Boolean = true;

    [Inject]
    public var update:NewsDataUpdatedSignal;
    [Inject]
    public var model:NewsModel;
    [Inject]
    public var getNews:GetAppEngineNewsTask;
    [Inject]
    public var flushStartupQueue:FlushPopupStartupQueueSignal;


    override public function initialize():void {
        this.update.add(this.onUpdate);
        this.getNews.start();
        if (firstRun) {
            firstRun = false;
        }
    }

    override public function destroy():void {
        this.update.remove(this.onUpdate);
    }

    private function onUpdate(_arg1:Vector.<NewsCellVO>):void {
    }


}
}
