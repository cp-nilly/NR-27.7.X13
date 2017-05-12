package kabam.rotmg.ui.model {
import com.company.assembleegameclient.objects.GameObject;

public class UpdateGameObjectTileVO {

    public var tileX:int;
    public var tileY:int;
    public var gameObject:GameObject;

    public function UpdateGameObjectTileVO(_arg1:int, _arg2:int, _arg3:GameObject) {
        this.tileX = _arg1;
        this.tileY = _arg2;
        this.gameObject = _arg3;
    }

}
}
