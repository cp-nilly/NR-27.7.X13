package kabam.rotmg.stage3D.proxies {
import flash.display3D.Program3D;
import flash.utils.ByteArray;

public class Program3DProxy {

    private var program3D:Program3D;

    public function Program3DProxy(_arg1:Program3D) {
        this.program3D = _arg1;
    }

    public function upload(_arg1:ByteArray, _arg2:ByteArray):void {
        this.program3D.upload(_arg1, _arg2);
    }

    public function getProgram3D():Program3D {
        return (this.program3D);
    }


}
}
