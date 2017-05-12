package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class ParticleGenerator extends ParticleEffect {

    private var particlePool:Vector.<BaseParticle>;
    private var liveParticles:Vector.<BaseParticle>;
    private var targetGO:GameObject;
    private var generatedParticles:Number = 0;
    private var totalTime:Number = 0;
    private var effectProps:EffectProperties;
    private var bitmapData:BitmapData;
    private var friction:Number;

    public function ParticleGenerator(_arg1:EffectProperties, _arg2:GameObject) {
        this.targetGO = _arg2;
        this.particlePool = new Vector.<BaseParticle>();
        this.liveParticles = new Vector.<BaseParticle>();
        this.effectProps = _arg1;
        if (this.effectProps.bitmapFile) {
            this.bitmapData = AssetLibrary.getImageFromSet(this.effectProps.bitmapFile, this.effectProps.bitmapIndex);
            this.bitmapData = TextureRedrawer.redraw(this.bitmapData, this.effectProps.size, true, 0);
        }
        else {
            this.bitmapData = TextureRedrawer.redrawSolidSquare(this.effectProps.color, this.effectProps.size);
        }
    }

    public static function attachParticleGenerator(_arg1:EffectProperties, _arg2:GameObject):ParticleGenerator {
        return (new (ParticleGenerator)(_arg1, _arg2));
    }


    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local4:Number;
        var _local9:BaseParticle;
        var _local10:BaseParticle;
        var _local3:Number = (_arg1 / 1000);
        _local4 = (_arg2 / 1000);
        if (this.targetGO.map_ == null) {
            return (false);
        }
        x_ = this.targetGO.x_;
        y_ = this.targetGO.y_;
        z_ = (this.targetGO.z_ + this.effectProps.zOffset);
        this.totalTime = (this.totalTime + _local4);
        var _local5:Number = (this.effectProps.rate * this.totalTime);
        var _local6:int = (_local5 - this.generatedParticles);
        var _local7:int;
        while (_local7 < _local6) {
            if (this.particlePool.length) {
                _local9 = this.particlePool.pop();
            }
            else {
                _local9 = new BaseParticle(this.bitmapData);
            }
            _local9.initialize((this.effectProps.life + (this.effectProps.lifeVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.speed + (this.effectProps.speedVariance * ((2 * Math.random()) - 1))), (this.effectProps.rise + (this.effectProps.riseVariance * ((2 * Math.random()) - 1))), z_);
            map_.addObj(_local9, (x_ + (this.effectProps.rangeX * ((2 * Math.random()) - 1))), (y_ + (this.effectProps.rangeY * ((2 * Math.random()) - 1))));
            this.liveParticles.push(_local9);
            _local7++;
        }
        this.generatedParticles = (this.generatedParticles + _local6);
        var _local8:int;
        while (_local8 < this.liveParticles.length) {
            _local10 = this.liveParticles[_local8];
            _local10.timeLeft = (_local10.timeLeft - _local4);
            if (_local10.timeLeft <= 0) {
                this.liveParticles.splice(_local8, 1);
                map_.removeObj(_local10.objectId_);
                _local8--;
                this.particlePool.push(_local10);
            }
            else {
                _local10.spdZ = (_local10.spdZ + (this.effectProps.riseAcc * _local4));
                _local10.x_ = (_local10.x_ + (_local10.spdX * _local4));
                _local10.y_ = (_local10.y_ + (_local10.spdY * _local4));
                _local10.z_ = (_local10.z_ + (_local10.spdZ * _local4));
            }
            _local8++;
        }
        return (true);
    }

    override public function removeFromMap():void {
        var _local1:BaseParticle;
        for each (_local1 in this.liveParticles) {
            map_.removeObj(_local1.objectId_);
        }
        this.liveParticles = null;
        this.particlePool = null;
        super.removeFromMap();
    }


}
}
