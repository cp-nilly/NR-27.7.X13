package kabam.rotmg.legends.model {
public class LegendsModel {

    private const map:Object = {};

    private var timespan:Timespan;

    public function LegendsModel() {
        this.timespan = Timespan.WEEK;
        super();
    }

    public function getTimespan():Timespan {
        return (this.timespan);
    }

    public function setTimespan(_arg1:Timespan):void {
        this.timespan = _arg1;
    }

    public function hasLegendList():Boolean {
        return (!((this.map[this.timespan.getId()] == null)));
    }

    public function getLegendList():Vector.<Legend> {
        return (this.map[this.timespan.getId()]);
    }

    public function setLegendList(_arg1:Vector.<Legend>):void {
        this.map[this.timespan.getId()] = _arg1;
    }

    public function clear():void {
        var _local1:String;
        for (_local1 in this.map) {
            this.dispose(this.map[_local1]);
            delete this.map[_local1];
        }
    }

    private function dispose(_arg1:Vector.<Legend>):void {
        var _local2:Legend;
        for each (_local2 in _arg1) {
            ((_local2.character) && (this.removeLegendCharacter(_local2)));
        }
    }

    private function removeLegendCharacter(_arg1:Legend):void {
        _arg1.character.dispose();
        _arg1.character = null;
    }


}
}
