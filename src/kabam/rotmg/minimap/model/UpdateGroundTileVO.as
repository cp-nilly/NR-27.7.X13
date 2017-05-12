package kabam.rotmg.minimap.model {
public class UpdateGroundTileVO {

    public var tileX:int;
    public var tileY:int;
    public var tileType:uint;

    public function UpdateGroundTileVO(_arg1:int, _arg2:int, _arg3:uint) {
        this.tileX = _arg1;
        this.tileY = _arg2;
        this.tileType = _arg3;
    }

}
}
