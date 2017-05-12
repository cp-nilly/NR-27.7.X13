package kabam.rotmg.util.graphics {
public class BevelRect {

    public var topLeftBevel:Boolean = true;
    public var topRightBevel:Boolean = true;
    public var bottomLeftBevel:Boolean = true;
    public var bottomRightBevel:Boolean = true;
    public var width:int;
    public var height:int;
    public var bevel:int;

    public function BevelRect(_arg1:int, _arg2:int, _arg3:int) {
        this.width = _arg1;
        this.height = _arg2;
        this.bevel = _arg3;
    }

}
}
