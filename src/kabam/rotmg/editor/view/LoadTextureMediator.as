package kabam.rotmg.editor.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.editor.model.SearchData;
import kabam.rotmg.editor.model.SearchModel;
import kabam.rotmg.editor.model.TextureData;
import kabam.rotmg.editor.signals.SetTextureSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class LoadTextureMediator extends Mediator {

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var view:LoadTextureDialog;
    [Inject]
    public var setTexture:SetTextureSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    [Inject]
    public var searchModel:SearchModel;


    override public function initialize():void {
        this.view.cancel.add(this.onCancel);
        this.view.textureSelected.add(this.onTextureSelected);
        this.view.search.add(this.onSearch);
        this.view.showSearchResults(true, this.searchModel.data);
    }

    override public function destroy():void {
        this.view.cancel.remove(this.onCancel);
        this.view.textureSelected.remove(this.onTextureSelected);
        this.view.search.remove(this.onSearch);
    }

    private function onCancel():void {
        this.closeDialogs.dispatch();
    }

    private function onTextureSelected(_arg_1:TextureData):void {
        this.setTexture.dispatch(_arg_1);
        this.closeDialogs.dispatch();
    }

    private function onSearch(_arg_1:SearchData):void {
        this.searchModel.searchData = _arg_1;
        this.client.complete.addOnce(this.onSearchComplete);
        this.client.sendRequest("/picture/list", this.makeRequest(_arg_1));
    }

    private function makeRequest(_arg_1:SearchData):Object {
        var _local_2:Object = {};
        _local_2["myGUID"] = this.account.getUserId();
        if (_arg_1.scope == "Mine") {
            _local_2["guid"] = this.account.getUserId();
        }
        else {
            if (_arg_1.scope == "Wild Shadow") {
                _local_2["guid"] = "administrator@wildshadow.com";
            }
        }
        if (_arg_1.type != 0) {
            _local_2["dataType"] = _arg_1.type.toString();
        }
        if (_arg_1.tags != "") {
            _local_2["tags"] = _arg_1.tags;
        }
        if (_arg_1.offset != 0) {
            _local_2["offset"] = _arg_1.offset;
        }
        _local_2["num"] = (LoadTextureDialog.NUM_ROWS * LoadTextureDialog.NUM_COLS);
        return (_local_2);
    }

    private function onSearchComplete(_arg_1:Boolean, _arg_2:*):void {
        this.searchModel.data = _arg_2;
        this.view.showSearchResults(_arg_1, _arg_2);
    }


}
}
