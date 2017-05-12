package kabam.lib.console.model {
public class Watch {

    public var name:String;
    public var data:String;

    public function Watch(_arg1:String, _arg2:String = "") {
        this.name = _arg1;
        this.data = _arg2;
    }

    public function toString():String {
        return (this.data);
    }


}
}
