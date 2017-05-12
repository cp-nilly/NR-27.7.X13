package kabam.rotmg.util {
public class GeometricSeries {

    private var a:Number;
    private var r:Number;

    public function GeometricSeries(_arg1:Number, _arg2:Number) {
        this.a = _arg1;
        this.r = _arg2;
    }

    public function getSummation(_arg1:int):Number {
        return (((this.a * (1 - Math.pow(this.r, _arg1))) / (1 - this.r)));
    }

    public function getTerm(_arg1:int):Number {
        return ((this.a * Math.pow(this.r, _arg1)));
    }


}
}
