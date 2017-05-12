package kabam.rotmg.friends.model {
public class FriendRequestVO {

    public var request:String;
    public var target:String;
    public var callback:Function;

    public function FriendRequestVO(_arg1:String, _arg2:String, _arg3:Function = null) {
        this.request = _arg1;
        this.target = _arg2;
        this.callback = _arg3;
    }

}
}
