package kabam.rotmg.game.model {
import com.company.assembleegameclient.parameters.Parameters;

public class ChatFilter {


    public function guestChatFilter(_arg1:String):Boolean {
        var _local2:Boolean;
        if (_arg1 == null) {
            return (true);
        }
        if ((((((((_arg1 == Parameters.SERVER_CHAT_NAME)) || ((_arg1 == Parameters.HELP_CHAT_NAME)))) || ((_arg1 == Parameters.ERROR_CHAT_NAME)))) || ((_arg1 == Parameters.CLIENT_CHAT_NAME)))) {
            _local2 = true;
        }
        if (_arg1.charAt(0) == "#") {
            _local2 = true;
        }
        if (_arg1.charAt(0) == "@") {
            _local2 = true;
        }
        return (_local2);
    }


}
}
