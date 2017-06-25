package kabam.rotmg.chat.control {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.dailyLogin.model.DailyLoginModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

public class ParseChatMessageCommand {

    [Inject]
    public var data:String;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var addTextLine:AddTextLineSignal;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var buildData:BuildData;
    [Inject]
    public var dailyLoginModel:DailyLoginModel;


    public function execute():void {
        if(this.data.charAt(0) == "/") {
            var command:Array = this.data.substr(1, this.data.length).split(" ");
            switch (command[0]) {
                case "help":
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
                    return;
                case "mscale":
                    if(command.length > 1) {
                        var mscale:Number = Number(command[1]);
                        if (mscale) {
                            Parameters.data_.mscale = mscale;
                            Parameters.save();
                            Camera.vToS_scale = mscale;
                        }
                    }
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Map Scale: " + Parameters.data_.mscale));
                    return;
            }
        }
        this.hudModel.gameSprite.gsc_.playerText(this.data);
    }


}
}
