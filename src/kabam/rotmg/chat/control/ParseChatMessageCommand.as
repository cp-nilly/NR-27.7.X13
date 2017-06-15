package kabam.rotmg.chat.control {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.Music;

import flash.display.DisplayObject;
import flash.events.Event;

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
        var text:String = this.data.toLowerCase();
        if (text == "/help") {
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, TextKey.HELP_COMMAND));
        }
        if (text == "/volume") {
            this.addTextLine.dispatch(ChatMessage.make("*Help*", "Music Volume: " + Parameters.data_["musicVolume"] * 100 + "% - Usage: /volume <number number in the range [0; 100]>"));
            return;
        }
        var volumeMatch:Array = text.match("/volume (\\d*\\.*\\d+)$");
        if (volumeMatch != null) {
            var getVolume:* = Number(volumeMatch[1]);
            getVolume = getVolume > 0 ? getVolume : 0;
            getVolume = getVolume < 100 ? getVolume : 100;
            var newVolume:Number = getVolume / 100;
            Music.setMusicVolume(newVolume);
            this.addTextLine.dispatch(ChatMessage.make(Parameters.HELP_CHAT_NAME, "Music volume set to " + getVolume + "%."));
            return;
        }
        else {
            this.hudModel.gameSprite.gsc_.playerText(this.data);
        }
    }


}
}
