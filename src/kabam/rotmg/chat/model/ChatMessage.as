package kabam.rotmg.chat.model {
public class ChatMessage {

    public var name:String;
    public var text:String;
    public var objectId:int = -1;
    public var numStars:int = -1;
    public var admin:Boolean = false;
    public var recipient:String = "";
    public var isToMe:Boolean;
    public var isWhisper:Boolean;
    public var tokens:Object;
    public var nameColor:int = 1193046;
    public var textColor:int = 1193046;

    public static function make(
            name:String,
            text:String,
            objId:int = -1,
            numStars:int = -1,
            recipient:String = "",
            isToMe:Boolean = false,
            tokens:Object = null,
            isWhisper:Boolean = false,
            nameColor:int = 1193046,
            textColor:int = 1193046,
            isAdmin:Boolean = false):ChatMessage {
        var msg:ChatMessage = new ChatMessage();
        msg.name = name;
        msg.text = text;
        msg.objectId = objId;
        msg.numStars = numStars;
        msg.admin = isAdmin;
        msg.recipient = recipient;
        msg.isToMe = isToMe;
        msg.isWhisper = isWhisper;
        msg.tokens = tokens == null ? {} : tokens;
        msg.nameColor = nameColor;
        msg.textColor = textColor;
        return (msg);
    }


}
}
