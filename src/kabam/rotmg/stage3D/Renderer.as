package kabam.rotmg.stage3D {
import com.adobe.utils.AGALMiniAssembler;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsGradientFill;
import flash.display.IGraphicsData;
import flash.display.StageScaleMode;
import flash.display3D.Context3D;
import flash.display3D.Context3DProgramType;
import flash.display3D.Context3DTextureFormat;
import flash.display3D.Context3DTriangleFace;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.IndexBuffer3D;
import flash.display3D.Program3D;
import flash.display3D.VertexBuffer3D;
import flash.display3D.textures.Texture;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;

import kabam.rotmg.stage3D.Object3D.Object3DStage3D;
import kabam.rotmg.stage3D.Object3D.Util;
import kabam.rotmg.stage3D.graphic3D.Graphic3D;
import kabam.rotmg.stage3D.graphic3D.TextureFactory;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

import org.swiftsuspenders.Injector;

public class Renderer {

    public static const STAGE3D_FILTER_PAUSE:uint = 1;
    public static const STAGE3D_FILTER_BLIND:uint = 2;
    public static const STAGE3D_FILTER_DRUNK:uint = 3;

    private static const POST_FILTER_VERTEX_CONSTANTS:Vector.<Number> =
            new <Number>[1, 2, 0, 0];
    private static const GRAYSCALE_FRAGMENT_CONSTANTS:Vector.<Number> =
            new <Number>[0.3, 0.59, 0.11, 0];
    private static const BLIND_FRAGMENT_CONSTANTS:Vector.<Number> =
            new <Number>[0.05, 0.05, 0.05, 0];
    private static const POST_FILTER_POSITIONS:Vector.<Number> =
            new <Number>[-1, 1, 0, 0, 1, 1, 1, 0, 1, -1, 1, 1, -1, -1, 0, 1];
    private static const POST_FILTER_TRIS:Vector.<uint> =
            new <uint>[0, 2, 3, 0, 1, 2];

    public static var inGame:Boolean;

    [Inject]
    public var context3D:Context3DProxy;
    [Inject]
    public var textureFactory:TextureFactory;
    [Inject]
    public var injector:Injector;

    private var tX:Number;
    private var tY:Number;
    public var program2:Program3D;
    private var postProcessingProgram_:Program3D;
    private var blurPostProcessing_:Program3D;
    private var shadowProgram_:Program3D;
    private var graphic3D_:Graphic3D;
    protected var _projection:Matrix3D;
    protected var cameraMatrix_:Matrix3D = new Matrix3D();
    private var p_:Vector3D = new Vector3D();
    private var f_:Vector3D = new Vector3D(0, 0, -1);
    private var u_:Vector3D = new Vector3D();
    private var r_:Vector3D = new Vector3D();
    private var rd_:Vector.<Number> = new Vector.<Number>(16, true);
    protected var widthOffset_:Number;
    protected var heightOffset_:Number;
    private var stageWidth:Number = 600;
    private var stageHeight:Number = 600;
    private var sceneTexture_:Texture;
    private var blurFactor:Number = 0.01;
    private var postFilterVertexBuffer_:VertexBuffer3D;
    private var postFilterIndexBuffer_:IndexBuffer3D;
    private var blurFragmentConstants_:Vector.<Number> = Vector.<Number>([0.4, 0.6, 0.4, 1.5]);
    private var finalTransform:Matrix3D = new Matrix3D();

    public function Renderer(r3d:Render3D) {
        Renderer.inGame = false;
        this.setTranslationToTitle();
        r3d.add(this.onRender);
    }

    public function init(c3d:Context3D):void {
        this._projection = Util.perspectiveProjection(56, 1, 0.1, 0x0800);

        var asm1:AGALMiniAssembler = new AGALMiniAssembler();
        var asm2:AGALMiniAssembler = new AGALMiniAssembler();

        // program 2 ???
        asm1.assemble(Context3DProgramType.VERTEX,
                "m44 op, va0, vc0\n" +
                "m44 v0, va0, vc8\n" +
                "m44 v1, va1, vc8\n" +
                "mov v2, va2\n");
        asm2.assemble(Context3DProgramType.FRAGMENT,
                "tex oc, v2, fs0 <2d,clamp>\n");
        this.program2 = c3d.createProgram();
        this.program2.upload(asm1.agalcode, asm2.agalcode);

        // post processing program
        asm1.assemble(Context3DProgramType.VERTEX,
                "mov op, va0\n" +
                "add vt0, vc0.xxxx, va0\n" +
                "div vt0, vt0, vc0.yyyy\n" +
                "sub vt0.y, vc0.x, vt0.y\n"
                + "mov v0, vt0\n");
        asm2.assemble(Context3DProgramType.FRAGMENT,
                "tex ft0, v0, fs0 <2d,clamp,linear>\n" +
                "dp3 ft0.x, ft0, fc0\n" +
                "mov ft0.y, ft0.x\n" +
                "mov ft0.z, ft0.x\n" +
                "mov oc, ft0\n");
        this.postProcessingProgram_ = c3d.createProgram();
        this.postProcessingProgram_.upload(asm1.agalcode, asm2.agalcode);

        // blur post processing program
        asm1.assemble(Context3DProgramType.VERTEX,
                "m44 op, va0, vc0\n" +
                "mov v0, va1\n");
        asm2.assemble(Context3DProgramType.FRAGMENT,
                "sub ft0, v0, fc0\n" +
                "sub ft0.zw, ft0.zw, ft0.zw\n" +
                "dp3 ft1, ft0, ft0\n" +
                "sqt ft1, ft1\n" +
                "div ft1.xy, ft1.xy, fc0.zz\n" +
                "pow ft1.x, ft1.x, fc0.w\n" +
                "mul ft0.xy, ft0.xy, ft1.xx\n" +
                "div ft0.xy, ft0.xy, ft1.yy\n" +
                "add ft0.xy, ft0.xy, fc0.xy\n" +
                "tex oc, ft0, fs0<2d,clamp>\n");
        this.blurPostProcessing_ = c3d.createProgram();
        this.blurPostProcessing_.upload(asm1.agalcode, asm2.agalcode);

        // shadow program
        asm1.assemble(Context3DProgramType.VERTEX,
                "m44 op, va0, vc0\n" +
                "mov v0, va1\n" +
                "mov v1, va2\n");
        asm2.assemble(Context3DProgramType.FRAGMENT,
                "sub ft0.xy, v1.xy, fc4.xx\n" +
                "mul ft0.xy, ft0.xy, ft0.xy\n" +
                "add ft0.x, ft0.x, ft0.y\n" +
                "slt ft0.y, ft0.x, fc4.y\n" +
                "mul oc, v0, ft0.yyyy\n");
        this.shadowProgram_ = c3d.createProgram();
        this.shadowProgram_.upload(asm1.agalcode, asm2.agalcode);

        this.sceneTexture_ = c3d.createTexture(0x0400, 0x0400, Context3DTextureFormat.BGRA, true);
        this.postFilterVertexBuffer_ = c3d.createVertexBuffer(4, 4);
        this.postFilterVertexBuffer_.uploadFromVector(POST_FILTER_POSITIONS, 0, 4);
        this.postFilterIndexBuffer_ = c3d.createIndexBuffer(6);
        this.postFilterIndexBuffer_.uploadFromVector(POST_FILTER_TRIS, 0, 6);
        this.graphic3D_ = this.injector.getInstance(Graphic3D);
    }

    private function UpdateCameraMatrix(camera:Camera):void {
        var angle:Number = -camera.angleRad_;
        this.p_.x = -(camera.x_ + this.widthOffset_);
        this.p_.y = camera.y_ - this.heightOffset_;
        this.p_.z = -camera.z_;
        this.r_.x = Math.cos(angle);
        this.r_.y = Math.sin(angle);
        this.r_.z = 0;
        this.u_.x = -this.r_.y;
        this.u_.y = this.r_.x;
        this.u_.z = 0;
        this.rd_[0] = this.r_.x;
        this.rd_[1] = this.u_.x;
        this.rd_[2] = this.f_.x;
        this.rd_[3] = 0;
        this.rd_[4] = this.r_.y;
        this.rd_[5] = this.u_.y;
        this.rd_[6] = this.f_.y;
        this.rd_[7] = 0;
        this.rd_[8] = this.r_.z;
        this.rd_[9] = 1;
        this.rd_[10] = -this.f_.z;
        this.rd_[11] = 0;
        this.rd_[12] = this.p_.dotProduct(this.r_);
        this.rd_[13] = this.p_.dotProduct(this.u_);
        this.rd_[14] = -this.p_.dotProduct(this.f_);
        this.rd_[15] = 1;
        cameraMatrix_.copyRawDataFrom(this.rd_);
    }

    private function onRender(
            gfxData:Vector.<IGraphicsData>, obj3dStage:Vector.<Object3DStage3D>,
            mapWidth:Number, mapHeight:Number, camera:Camera, postEffect:uint):void {

        WebMain.STAGE.scaleMode = StageScaleMode.NO_SCALE;

        if (WebMain.STAGE.stageWidth != this.stageWidth || WebMain.STAGE.stageHeight != this.stageHeight) {
            this.resizeStage3DBackBuffer(camera);
        }

        Renderer.inGame == true ?
            this.setTranslationToGame(camera) :
            this.setTranslationToTitle();

        postEffect > 0 ?
            this.renderWithPostEffect(gfxData, obj3dStage, mapWidth, mapHeight, camera, postEffect) :
            this.renderScene(gfxData, obj3dStage, mapWidth, mapHeight, camera);

        this.context3D.present();
        WebMain.STAGE.scaleMode = StageScaleMode.EXACT_FIT;
    }

    private function resizeStage3DBackBuffer(camera:Camera):void {
        // the - 200 on the width is incorrect
        var w:int = WebMain.STAGE.stageWidth;
        var h:int = WebMain.STAGE.stageHeight;
        var widthPlayable:Number = w * camera.clipRect_.width / (camera.clipRect_.width + 200);
        if (widthPlayable - 100 < 1 || h - 100 < 1) {
            return;
        }
        WebMain.STAGE.stage3Ds[0]
                .context3D
                .configureBackBuffer(widthPlayable, h, 2, false);
        this.stageWidth = w;
        this.stageHeight = h;
    }

    private function renderWithPostEffect(
            gfxData:Vector.<IGraphicsData>, obj3dStage:Vector.<Object3DStage3D>,
            mapWidth:Number, mapHeight:Number, camera:Camera, postEffect:uint):void {

        var ctx:Context3D = this.context3D.GetContext3D();

        ctx.setRenderToTexture(this.sceneTexture_, true);
        this.renderScene(gfxData, obj3dStage, mapWidth, mapHeight, camera);
        ctx.setRenderToBackBuffer();
        switch (postEffect) {
            case STAGE3D_FILTER_PAUSE:
            case STAGE3D_FILTER_BLIND:
                ctx.setProgram(this.postProcessingProgram_);
                ctx.setTextureAt(0, this.sceneTexture_);
                ctx.clear(0.5, 0.5, 0.5);
                ctx.setVertexBufferAt(0, this.postFilterVertexBuffer_, 0, Context3DVertexBufferFormat.FLOAT_2);
                ctx.setVertexBufferAt(1, null);
                break;
            case STAGE3D_FILTER_DRUNK:
                ctx.setProgram(this.blurPostProcessing_);
                ctx.setTextureAt(0, this.sceneTexture_);
                ctx.clear(0.5, 0.5, 0.5);
                ctx.setVertexBufferAt(0, this.postFilterVertexBuffer_, 0, Context3DVertexBufferFormat.FLOAT_2);
                ctx.setVertexBufferAt(1, this.postFilterVertexBuffer_, 2, Context3DVertexBufferFormat.FLOAT_2);
                break;
        }
        ctx.setVertexBufferAt(2, null);
        switch (postEffect) {
            case STAGE3D_FILTER_PAUSE:
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.FRAGMENT, 0, GRAYSCALE_FRAGMENT_CONSTANTS);
                break;

            case STAGE3D_FILTER_BLIND:
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.VERTEX, 0, POST_FILTER_VERTEX_CONSTANTS);
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.FRAGMENT, 0, BLIND_FRAGMENT_CONSTANTS);
                break;

            case STAGE3D_FILTER_DRUNK:
                if (this.blurFragmentConstants_[3] <= 0.2 || this.blurFragmentConstants_[3] >= 1.8) {
                    this.blurFactor = this.blurFactor * -1;
                }
                this.blurFragmentConstants_[3] = this.blurFragmentConstants_[3] + this.blurFactor;
                this.context3D.setProgramConstantsFromMatrix(
                        Context3DProgramType.VERTEX, 0, new Matrix3D());
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.FRAGMENT, 0,
                        this.blurFragmentConstants_,
                        this.blurFragmentConstants_.length / 4);
                break;
        }
        ctx.clear(0, 0, 0, 1);
        ctx.drawTriangles(this.postFilterIndexBuffer_);
    }

    private function renderScene(
            gfxData:Vector.<IGraphicsData>, gfxData3d:Vector.<Object3DStage3D>,
            mapWidth:Number, mapHeight:Number, camera:Camera):void {

        this.context3D.clear();
        this.widthOffset_ = -mapWidth / 2;
        this.heightOffset_ = mapHeight / 2;
        this.UpdateCameraMatrix(camera);
        var ctx:Context3D = this.context3D.GetContext3D();

        var test:int;
        var i:uint = 0;
        for each (var data:IGraphicsData in gfxData) {
            ctx.setCulling(Context3DTriangleFace.NONE);

            if (data is GraphicsBitmapFill && !GraphicsFillExtra.isSoftwareDraw(GraphicsBitmapFill(data))) {
                try {
                    test = GraphicsBitmapFill(data).bitmapData.width;
                }
                catch (e:Error) {
                    continue;
                }
                this.graphic3D_.setGraphic(GraphicsBitmapFill(data), this.context3D);
                finalTransform.copyFrom(this.graphic3D_.getMatrix3D());
                finalTransform.appendScale(1 / Stage3DConfig.HALF_WIDTH, 1 / Stage3DConfig.HALF_HEIGHT, 1);
                finalTransform.appendTranslation(
                        this.tX / Stage3DConfig.WIDTH,
                        this.tY / Stage3DConfig.HEIGHT, 0);
                this.context3D.setProgramConstantsFromMatrix(
                        Context3DProgramType.VERTEX, 0, finalTransform, true);
                this.graphic3D_.render(this.context3D);
            }

            if (data is GraphicsGradientFill) {
                ctx.setProgram(this.shadowProgram_);
                this.graphic3D_.setGradientFill(
                        GraphicsGradientFill(data),
                        this.context3D,
                        Stage3DConfig.HALF_WIDTH, Stage3DConfig.HALF_HEIGHT);
                finalTransform.copyFrom(this.graphic3D_.getMatrix3D());
                finalTransform.appendTranslation(
                        this.tX / Stage3DConfig.WIDTH,
                        this.tY / Stage3DConfig.HEIGHT, 0);
                this.context3D.setProgramConstantsFromMatrix(
                        Context3DProgramType.VERTEX, 0, finalTransform, true);
                this.context3D.setProgramConstantsFromVector(
                        Context3DProgramType.FRAGMENT, 4, Vector.<Number>([0.5, 0.25, 0, 0]));
                this.graphic3D_.renderShadow(this.context3D);
            }

            if (data == null && gfxData3d.length != 0) {
                try {
                    ctx.setProgram(this.program2);
                    ctx.setCulling(Context3DTriangleFace.BACK);
                    gfxData3d[i].UpdateModelMatrix(this.widthOffset_, this.heightOffset_);
                    finalTransform.copyFrom(gfxData3d[i].GetModelMatrix());
                    finalTransform.append(this.cameraMatrix_);
                    finalTransform.append(this._projection);
                    finalTransform.appendTranslation(
                            this.tX / Stage3DConfig.WIDTH,
                            this.tY / Stage3DConfig.HEIGHT * 11.5, 0);
                    this.context3D.setProgramConstantsFromMatrix(
                            Context3DProgramType.VERTEX, 0, finalTransform, true);
                    this.context3D.setProgramConstantsFromMatrix(
                            Context3DProgramType.VERTEX, 8, gfxData3d[i].GetModelMatrix(), true);
                    gfxData3d[i].draw(ctx);
                    i++;
                }
                catch (e:Error) {
                }
            }
        }
    }

    private function setTranslationToGame(camera:Camera):void {
        this.tX = 0;
        this.tY = (camera.clipRect_.y + camera.clipRect_.height / 2) * 2;
    }

    private function setTranslationToTitle():void {
        this.tX = (this.tY = 0);
    }


}
}
