package kabam.rotmg.chat.control {
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
        var text = data.toLowerCase();
        var volumeMatch:Array = text.match("/volume (\\d*\\.*\\d+)$");
        if (text == "/volume") {
            var currentVolume:Number = Parameters.data_["musicVolume"];
            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Music Volume: " + currentVolume * 100 + "% - Usage: /volume <number number in the range [0; 100]>"));
            return;
        }
        if (volumeMatch != null) {
            var Output = Number(volumeMatch[1])
            Output = Output > 0 ? Output : 0;
            Output = Output < 100 ? Output : 100;
            var Volume = Output / 100;
            Parameters.data_["musicVolume"] = Volume;
            Parameters.save();
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Music volume set to " + Output + "%."));
            return;
        }
        if (text == "/help") {
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
        }
        else {
            this.hudModel.gameSprite.gsc_.playerText(this.data);
        }
    }
}
}
