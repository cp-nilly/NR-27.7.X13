package kabam.rotmg.stage3D.proxies {
import flash.display3D.Context3D;
import flash.geom.Matrix3D;

public class Context3DProxy {

    private var context3D:Context3D;

    public function Context3DProxy(_arg1:Context3D) {
        this.context3D = _arg1;
    }

    public function GetContext3D():Context3D {
        return (this.context3D);
    }

    public function configureBackBuffer(_arg1:int, _arg2:int, _arg3:int, _arg4:Boolean = true):void {
        this.context3D.configureBackBuffer(_arg1, _arg2, _arg3, _arg4);
    }

    public function createProgram():Program3DProxy {
        return (new Program3DProxy(this.context3D.createProgram()));
    }

    public function clear():void {
        this.context3D.clear(0.05, 0.05, 0.05);
    }

    public function present():void {
        this.context3D.present();
    }

    public function createIndexBuffer(_arg1:int):IndexBuffer3DProxy {
        return (new IndexBuffer3DProxy(this.context3D.createIndexBuffer(_arg1)));
    }

    public function createVertexBuffer(_arg1:int, _arg2:int):VertexBuffer3DProxy {
        return (new VertexBuffer3DProxy(this.context3D.createVertexBuffer(_arg1, _arg2)));
    }

    public function setVertexBufferAt(_arg1:int, _arg2:VertexBuffer3DProxy, _arg3:int, _arg4:String = "float4"):void {
        this.context3D.setVertexBufferAt(_arg1, _arg2.getVertexBuffer3D(), _arg3, _arg4);
    }

    public function setProgramConstantsFromMatrix(_arg1:String, _arg2:int, _arg3:Matrix3D, _arg4:Boolean = false):void {
        this.context3D.setProgramConstantsFromMatrix(_arg1, _arg2, _arg3, _arg4);
    }

    public function setProgramConstantsFromVector(_arg1:String, _arg2:int, _arg3:Vector.<Number>, _arg4:int = -1):void {
        this.context3D.setProgramConstantsFromVector(_arg1, _arg2, _arg3, _arg4);
    }

    public function createTexture(_arg1:int, _arg2:int, _arg3:String, _arg4:Boolean):TextureProxy {
        return (new TextureProxy(this.context3D.createTexture(_arg1, _arg2, _arg3, _arg4)));
    }

    public function setTextureAt(_arg1:int, _arg2:TextureProxy):void {
        this.context3D.setTextureAt(_arg1, _arg2.getTexture());
    }

    public function setProgram(_arg1:Program3DProxy):void {
        this.context3D.setProgram(_arg1.getProgram3D());
    }

    public function drawTriangles(_arg1:IndexBuffer3DProxy):void {
        this.context3D.drawTriangles(_arg1.getIndexBuffer3D());
    }

    public function setBlendFactors(_arg1:String, _arg2:String):void {
        this.context3D.setBlendFactors(_arg1, _arg2);
    }

    public function setDepthTest(_arg1:Boolean, _arg2:String):void {
        this.context3D.setDepthTest(_arg1, _arg2);
    }


}
}
