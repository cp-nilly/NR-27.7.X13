package kabam.rotmg.stage3D {
import com.company.assembleegameclient.engine3d.Model3D;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.Stage3DProxy;
import com.company.assembleegameclient.util.StageProxy;

import flash.display3D.Context3DBlendFactor;
import flash.display3D.Context3DCompareMode;
import flash.events.ErrorEvent;
import flash.events.Event;

import kabam.rotmg.stage3D.graphic3D.Graphic3DHelper;
import kabam.rotmg.stage3D.graphic3D.IndexBufferFactory;
import kabam.rotmg.stage3D.graphic3D.TextureFactory;
import kabam.rotmg.stage3D.graphic3D.VertexBufferFactory;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class Stage3DConfig implements IConfig {

    public static var WIDTH:int = 600;
    public static var HALF_WIDTH:int = (WIDTH / 2);
    public static var HEIGHT:int = 600;
    public static var HALF_HEIGHT:int = (HEIGHT / 2);

    [Inject]
    public var stageProxy:StageProxy;
    [Inject]
    public var injector:Injector;
    public var renderer:Renderer;
    private var stage3D:Stage3DProxy;


    public function configure():void {
        this.mapSingletons();
        this.stage3D = this.stageProxy.getStage3Ds(0);
        this.stage3D.addEventListener(ErrorEvent.ERROR, Parameters.clearGpuRenderEvent);
        this.stage3D.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
        this.stage3D.requestContext3D();
    }

    private function mapSingletons():void {
        this.injector.map(Render3D).asSingleton();
        this.injector.map(TextureFactory).asSingleton();
        this.injector.map(IndexBufferFactory).asSingleton();
        this.injector.map(VertexBufferFactory).asSingleton();
    }

    private function onContextCreate(_arg1:Event):void {
        WIDTH = WebMain.STAGE.stageWidth - 200;
        HEIGHT = WebMain.STAGE.stageHeight;
        HALF_WIDTH = WIDTH / 2;
        HALF_HEIGHT = HEIGHT / 2;

        this.stage3D.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreate);
        var _local2:Context3DProxy = this.stage3D.getContext3D();
        if (_local2.GetContext3D().driverInfo.toLowerCase().indexOf("software") != -1) {
            Parameters.clearGpuRender();
        }
        _local2.configureBackBuffer(WIDTH, HEIGHT, 2, true);
        _local2.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
        _local2.setDepthTest(false, Context3DCompareMode.LESS_EQUAL);
        this.injector.map(Context3DProxy).toValue(_local2);
        Graphic3DHelper.map(this.injector);
        this.renderer = this.injector.getInstance(Renderer);
        this.renderer.init(_local2.GetContext3D());
        Model3D.Create3dBuffer(_local2.GetContext3D());
    }


}
}
