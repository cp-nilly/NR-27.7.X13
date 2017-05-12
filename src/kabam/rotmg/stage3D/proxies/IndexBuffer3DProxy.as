package kabam.rotmg.stage3D.proxies {
import flash.display3D.IndexBuffer3D;

public class IndexBuffer3DProxy {

    private var indexBuffer:IndexBuffer3D;

    public function IndexBuffer3DProxy(_arg1:IndexBuffer3D) {
        this.indexBuffer = _arg1;
    }

    public function uploadFromVector(_arg1:Vector.<uint>, _arg2:int, _arg3:int):void {
        this.indexBuffer.uploadFromVector(_arg1, _arg2, _arg3);
    }

    public function getIndexBuffer3D():IndexBuffer3D {
        return (this.indexBuffer);
    }


}
}
