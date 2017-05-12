package kabam.rotmg.news.view {
import flash.net.URLRequest;
import flash.net.navigateToURL;

import kabam.rotmg.news.controller.OpenSkinSignal;
import kabam.rotmg.news.model.NewsCellLinkType;
import kabam.rotmg.news.model.NewsCellVO;
import kabam.rotmg.packages.control.OpenPackageSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class NewsCellMediator extends Mediator {

    [Inject]
    public var view:NewsCell;
    [Inject]
    public var openPackageSignal:OpenPackageSignal;
    [Inject]
    public var openSkinSignal:OpenSkinSignal;


    override public function initialize():void {
        this.view.clickSignal.add(this.onNewsClicked);
    }

    override public function destroy():void {
        this.view.clickSignal.remove(this.onNewsClicked);
    }

    private function onNewsClicked(_arg1:NewsCellVO):void {
        var _local2:URLRequest;
        switch (_arg1.linkType) {
            case NewsCellLinkType.OPENS_LINK:
                _local2 = new URLRequest(_arg1.linkDetail);
                navigateToURL(_local2, "_blank");
                return;
            case NewsCellLinkType.OPENS_PACKAGE:
                this.openPackageSignal.dispatch(int(_arg1.linkDetail));
                return;
            case NewsCellLinkType.OPENS_SKIN:
                this.openSkinSignal.dispatch(_arg1.linkDetail);
                return;
        }
    }


}
}
