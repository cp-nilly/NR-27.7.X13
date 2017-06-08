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

    public static function make(_arg1:String, _arg2:String, _arg3:int = -1, _arg4:int = -1, _arg5:String = "", _arg6:Boolean = false, _arg7:Object = null, _arg8:Boolean = false, _arg9:int = 1193046, _arg10:int = 1193046, _arg11:Boolean = false):ChatMessage {
        var _local9:ChatMessage = new (ChatMessage)();
        _local9.name = _arg1;
        _local9.text = _arg2;
        _local9.objectId = _arg3;
        _local9.numStars = _arg4;
        _local9.admin = _arg11;
        _local9.recipient = _arg5;
        _local9.isToMe = _arg6;
        _local9.isWhisper = _arg8;
        _local9.tokens = (((_arg7 == null)) ? {} : _arg7);
        _local9.nameColor = _arg9;
        _local9.textColor = _arg10;
        return (_local9);
    }


}
}
