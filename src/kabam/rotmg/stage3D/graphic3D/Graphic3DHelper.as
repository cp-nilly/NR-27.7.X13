package kabam.rotmg.stage3D.graphic3D {
import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;
import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;

import org.swiftsuspenders.Injector;

public class Graphic3DHelper {


    public static function map(_arg1:Injector):void {
        injectSingletonIndexBuffer(_arg1);
        injectSingletonVertexBuffer(_arg1);
    }

    private static function injectSingletonIndexBuffer(_arg1:Injector):void {
        var _local2:IndexBufferFactory = _arg1.getInstance(IndexBufferFactory);
        _arg1.map(IndexBuffer3DProxy).toProvider(_local2);
    }

    private static function injectSingletonVertexBuffer(_arg1:Injector):void {
        var _local2:VertexBufferFactory = _arg1.getInstance(VertexBufferFactory);
        _arg1.map(VertexBuffer3DProxy).toProvider(_local2);
    }


}
}
