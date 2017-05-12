package kabam.rotmg.friends.controller {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendRequestVO;
import kabam.rotmg.game.signals.AddTextLineSignal;

public class FriendActionCommand {

    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var vo:FriendRequestVO;
    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        var _local3:AddTextLineSignal;
        if (this.vo.request == FriendConstant.INVITE) {
            _local3 = StaticInjectorContext.getInjector().getInstance(AddTextLineSignal);
            _local3.dispatch(ChatMessage.make("", "Friend request sent"));
        }
        var _local1:String = FriendConstant.getURL(this.vo.request);
        var _local2:Object = this.account.getCredentials();
        _local2["targetName"] = this.vo.target;
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest(_local1, _local2);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        if (this.vo.callback) {
            this.vo.callback(_arg1, _arg2, this.vo.target);
        }
        else {
            if (!_arg1) {
                this.openDialog.dispatch(new ErrorDialog(_arg2));
            }
        }
    }


}
}
