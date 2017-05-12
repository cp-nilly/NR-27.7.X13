package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.util.ConditionEffect;

import flash.utils.Dictionary;

public class ProjectileProperties {

    public var bulletType_:int;
    public var objectId_:String;
    public var lifetime_:int;
    public var speed_:int;
    public var size_:int;
    public var minDamage_:int;
    public var maxDamage_:int;
    public var effects_:Vector.<uint> = null;
    public var multiHit_:Boolean;
    public var passesCover_:Boolean;
    public var armorPiercing_:Boolean;
    public var particleTrail_:Boolean;
    public var particleTrailIntensity_:int = -1;
    public var particleTrailLifetimeMS:int = -1;
    public var particleTrailColor_:int = 0xFF00FF;
    public var wavy_:Boolean;
    public var parametric_:Boolean;
    public var boomerang_:Boolean;
    public var amplitude_:Number;
    public var frequency_:Number;
    public var magnitude_:Number;
    public var isPetEffect_:Dictionary;

    public function ProjectileProperties(_arg1:XML) {
        var _local2:XML;
        super();
        this.bulletType_ = int(_arg1.@id);
        this.objectId_ = _arg1.ObjectId;
        this.lifetime_ = int(_arg1.LifetimeMS);
        this.speed_ = int(_arg1.Speed);
        this.size_ = ((_arg1.hasOwnProperty("Size")) ? Number(_arg1.Size) : -1);
        if (_arg1.hasOwnProperty("Damage")) {
            this.minDamage_ = (this.maxDamage_ = int(_arg1.Damage));
        }
        else {
            this.minDamage_ = int(_arg1.MinDamage);
            this.maxDamage_ = int(_arg1.MaxDamage);
        }
        for each (_local2 in _arg1.ConditionEffect) {
            if (this.effects_ == null) {
                this.effects_ = new Vector.<uint>();
            }
            this.effects_.push(ConditionEffect.getConditionEffectFromName(String(_local2)));
            if (_local2.attribute("target") == "1") {
                if (this.isPetEffect_ == null) {
                    this.isPetEffect_ = new Dictionary();
                }
                this.isPetEffect_[ConditionEffect.getConditionEffectFromName(String(_local2))] = true;
            }
        }
        this.multiHit_ = _arg1.hasOwnProperty("MultiHit");
        this.passesCover_ = _arg1.hasOwnProperty("PassesCover");
        this.armorPiercing_ = _arg1.hasOwnProperty("ArmorPiercing");
        this.particleTrail_ = _arg1.hasOwnProperty("ParticleTrail");
        if (_arg1.ParticleTrail.hasOwnProperty("@intensity")) {
            this.particleTrailIntensity_ = (Number(_arg1.ParticleTrail.@intensity) * 100);
        }
        if (_arg1.ParticleTrail.hasOwnProperty("@lifetimeMS")) {
            this.particleTrailLifetimeMS = Number(_arg1.ParticleTrail.@lifetimeMS);
        }
        this.particleTrailColor_ = ((this.particleTrail_) ? Number(_arg1.ParticleTrail) : Number(0xFF00FF));
        if (this.particleTrailColor_ == 0) {
            this.particleTrailColor_ = 0xFF00FF;
        }
        this.wavy_ = _arg1.hasOwnProperty("Wavy");
        this.parametric_ = _arg1.hasOwnProperty("Parametric");
        this.boomerang_ = _arg1.hasOwnProperty("Boomerang");
        this.amplitude_ = ((_arg1.hasOwnProperty("Amplitude")) ? Number(_arg1.Amplitude) : 0);
        this.frequency_ = ((_arg1.hasOwnProperty("Frequency")) ? Number(_arg1.Frequency) : 1);
        this.magnitude_ = ((_arg1.hasOwnProperty("Magnitude")) ? Number(_arg1.Magnitude) : 3);
    }

}
}
