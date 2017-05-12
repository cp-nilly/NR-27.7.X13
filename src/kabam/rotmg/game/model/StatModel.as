package kabam.rotmg.game.model {
public class StatModel {

    public var name:String;
    public var abbreviation:String;
    public var description:String;
    public var redOnZero:Boolean;

    public function StatModel(_arg1:String, _arg2:String, _arg3:String, _arg4:Boolean) {
        this.name = _arg1;
        this.abbreviation = _arg2;
        this.description = _arg3;
        this.redOnZero = _arg4;
    }

}
}
