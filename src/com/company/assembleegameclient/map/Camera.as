package com.company.assembleegameclient.map {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.RandomUtil;

import flash.geom.Matrix3D;
import flash.geom.Rectangle;
import flash.geom.Vector3D;

public class Camera {

    public static const CENTER_SCREEN_RECT:Rectangle = new Rectangle(-300, -325, 600, 600);
    public static const OFFSET_SCREEN_RECT:Rectangle = new Rectangle(-300, -450, 600, 600);
    private static const SCREENSHOT_SCREEN_RECT:Rectangle = new Rectangle(-400, -325, 800, 600);
    private static const SLIM_SCREENSHOT_SCREEN_RECT:Rectangle = new Rectangle(-400, -275, 800, 500);

    private const MAX_JITTER:Number = 0.5;
    private const JITTER_BUILDUP_MS:int = 10000;

    public var x_:Number;
    public var y_:Number;
    public var z_:Number;
    public var angleRad_:Number;
    public var clipRect_:Rectangle;
    public var maxDist_:Number;
    public var maxDistSq_:Number;
    public var isHallucinating_:Boolean = false;
    public var wToS_:Matrix3D = new Matrix3D();
    public var wToV_:Matrix3D = new Matrix3D();
    public var vToS_:Matrix3D = new Matrix3D();
    private var p_:Vector3D = new Vector3D();
    private var f_:Vector3D = new Vector3D(0, 0, -1);
    private var u_:Vector3D = new Vector3D();
    private var r_:Vector3D = new Vector3D();
    private var isJittering_:Boolean = false;
    private var jitter_:Number = 0;
    private var rd_:Vector.<Number> = new Vector.<Number>(16, true);

    public function Camera() {
        this.vToS_.appendScale(50, 50, 50);
    }

    public function configureCamera(go:GameObject, isHallucinating:Boolean):void {
        var clipRect:Rectangle = Parameters.data_.centerOnPlayer ? CENTER_SCREEN_RECT : OFFSET_SCREEN_RECT;
        if (Parameters.screenShotMode_) {
            if (!Parameters.screenShotSlimMode_) {
                clipRect = SCREENSHOT_SCREEN_RECT;
            }
            else {
                clipRect = SLIM_SCREENSHOT_SCREEN_RECT;
            }
        }
        var _local4:Number = Parameters.data_.cameraAngle;
        this.configure(go.x_, go.y_, 12, _local4, clipRect);
        this.isHallucinating_ = isHallucinating;
    }

    public function startJitter():void {
        this.isJittering_ = true;
        this.jitter_ = 0;
    }

    public function update(elapsedMS:Number):void {
        if (this.isJittering_ && this.jitter_ < this.MAX_JITTER) {
            this.jitter_ = this.jitter_ + elapsedMS * this.MAX_JITTER / this.JITTER_BUILDUP_MS;
            if (this.jitter_ > this.MAX_JITTER) {
                this.jitter_ = this.MAX_JITTER;
            }
        }
    }

    public function configure(x:Number, y:Number, z:Number, angleRad:Number, rect:Rectangle):void {
        if (this.isJittering_) {
            x = x + RandomUtil.plusMinus(this.jitter_);
            y = y + RandomUtil.plusMinus(this.jitter_);
        }
        this.x_ = x;
        this.y_ = y;
        this.z_ = z;
        this.angleRad_ = angleRad;
        this.clipRect_ = rect;
        this.p_.x = x;
        this.p_.y = y;
        this.p_.z = z;
        this.r_.x = Math.cos(this.angleRad_);
        this.r_.y = Math.sin(this.angleRad_);
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
        this.rd_[9] = -1;
        this.rd_[10] = this.f_.z;
        this.rd_[11] = 0;
        this.rd_[12] = -this.p_.dotProduct(this.r_);
        this.rd_[13] = -this.p_.dotProduct(this.u_);
        this.rd_[14] = -this.p_.dotProduct(this.f_);
        this.rd_[15] = 1;
        this.wToV_.rawData = this.rd_;
        this.wToS_.identity();
        this.wToS_.append(this.wToV_);
        this.wToS_.append(this.vToS_);
        var wTileDist:Number = this.clipRect_.width / (2 * 50);
        var hTileDist:Number = this.clipRect_.height / (2 * 50);
        this.maxDist_ = Math.sqrt(wTileDist * wTileDist + hTileDist * hTileDist) + 1;
        this.maxDistSq_ = this.maxDist_ * this.maxDist_;
    }


}
}
