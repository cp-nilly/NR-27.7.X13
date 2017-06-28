package kabam.rotmg.editor.commands {
import kabam.lib.tasks.Task;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.web.view.WebAccountInfoView;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.editor.view.TermsView;

public class SetupEditorCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var loadAccount:LoadAccountTask;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var layers:Layers;


    public function execute():void {
        this.loadAccount.finished.addOnce(this.onAccountLoaded);
        this.loadAccount.start();
        this.setScreen.dispatch(new TermsView());
    }

    private function onAccountLoaded(_arg_1:Task, _arg_2:Boolean, _arg_3:String):void {
        var _local_4:WebAccountInfoView = new WebAccountInfoView();
        _local_4.setInfo(this.account.getUserId(), this.account.isRegistered());
        this.layers.overlay.addChild(_local_4);
    }


}
}
