package kabam.rotmg.stage3D.proxies {
import flash.display3D.VertexBuffer3D;

public class VertexBuffer3DProxy {

    private var vertexBuffer3D:VertexBuffer3D;
    protected var data:Vector.<Number>;

    public function VertexBuffer3DProxy(_arg1:VertexBuffer3D) {
        this.vertexBuffer3D = _arg1;
    }

    public function uploadFromVector(_arg1:Vector.<Number>, _arg2:int, _arg3:int):void {
        this.data = _arg1;
        this.vertexBuffer3D.uploadFromVector(_arg1, _arg2, _arg3);
    }

    public function getVertexBuffer3D():VertexBuffer3D {
        return (this.vertexBuffer3D);
    }

    public function getData():Vector.<Number> {
        return (this.data);
    }


}
}
