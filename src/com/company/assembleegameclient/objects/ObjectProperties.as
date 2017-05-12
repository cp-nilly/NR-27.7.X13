package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.utils.Dictionary;

public class ObjectProperties {

    public var type_:int;
    public var id_:String;
    public var displayId_:String;
    public var shadowSize_:int;
    public var isPlayer_:Boolean = false;
    public var isEnemy_:Boolean = false;
    public var drawOnGround_:Boolean = false;
    public var drawUnder_:Boolean = false;
    public var occupySquare_:Boolean = false;
    public var fullOccupy_:Boolean = false;
    public var enemyOccupySquare_:Boolean = false;
    public var static_:Boolean = false;
    public var noMiniMap_:Boolean = false;
    public var protectFromGroundDamage_:Boolean = false;
    public var protectFromSink_:Boolean = false;
    public var z_:Number = 0;
    public var flying_:Boolean = false;
    public var color_:uint = 0xFFFFFF;
    public var showName_:Boolean = false;
    public var dontFaceAttacks_:Boolean = false;
    public var bloodProb_:Number = 0;
    public var bloodColor_:uint = 0xFF0000;
    public var shadowColor_:uint = 0;
    public var sounds_:Object = null;
    public var portrait_:TextureData = null;
    public var minSize_:int = 100;
    public var maxSize_:int = 100;
    public var sizeStep_:int = 5;
    public var whileMoving_:WhileMovingProperties = null;
    public var belonedDungeon:String = "";
    public var oldSound_:String = null;
    public var projectiles_:Dictionary;
    public var angleCorrection_:Number = 0;
    public var rotation_:Number = 0;

    public function ObjectProperties(_arg1:XML) {
        var _local2:XML;
        var _local3:XML;
        var _local4:int;
        this.projectiles_ = new Dictionary();
        super();
        if (_arg1 == null) {
            return;
        }
        this.type_ = int(_arg1.@type);
        this.id_ = String(_arg1.@id);
        this.displayId_ = this.id_;
        if (_arg1.hasOwnProperty("DisplayId")) {
            this.displayId_ = _arg1.DisplayId;
        }
        this.shadowSize_ = ((_arg1.hasOwnProperty("ShadowSize")) ? _arg1.ShadowSize : 100);
        this.isPlayer_ = _arg1.hasOwnProperty("Player");
        this.isEnemy_ = _arg1.hasOwnProperty("Enemy");
        this.drawOnGround_ = _arg1.hasOwnProperty("DrawOnGround");
        if (((this.drawOnGround_) || (_arg1.hasOwnProperty("DrawUnder")))) {
            this.drawUnder_ = true;
        }
        this.occupySquare_ = _arg1.hasOwnProperty("OccupySquare");
        this.fullOccupy_ = _arg1.hasOwnProperty("FullOccupy");
        this.enemyOccupySquare_ = _arg1.hasOwnProperty("EnemyOccupySquare");
        this.static_ = _arg1.hasOwnProperty("Static");
        this.noMiniMap_ = _arg1.hasOwnProperty("NoMiniMap");
        this.protectFromGroundDamage_ = _arg1.hasOwnProperty("ProtectFromGroundDamage");
        this.protectFromSink_ = _arg1.hasOwnProperty("ProtectFromSink");
        this.flying_ = _arg1.hasOwnProperty("Flying");
        this.showName_ = _arg1.hasOwnProperty("ShowName");
        this.dontFaceAttacks_ = _arg1.hasOwnProperty("DontFaceAttacks");
        if (_arg1.hasOwnProperty("Z")) {
            this.z_ = Number(_arg1.Z);
        }
        if (_arg1.hasOwnProperty("Color")) {
            this.color_ = uint(_arg1.Color);
        }
        if (_arg1.hasOwnProperty("Size")) {
            this.minSize_ = (this.maxSize_ = _arg1.Size);
        }
        else {
            if (_arg1.hasOwnProperty("MinSize")) {
                this.minSize_ = _arg1.MinSize;
            }
            if (_arg1.hasOwnProperty("MaxSize")) {
                this.maxSize_ = _arg1.MaxSize;
            }
            if (_arg1.hasOwnProperty("SizeStep")) {
                this.sizeStep_ = _arg1.SizeStep;
            }
        }
        this.oldSound_ = ((_arg1.hasOwnProperty("OldSound")) ? String(_arg1.OldSound) : null);
        for each (_local2 in _arg1.Projectile) {
            _local4 = int(_local2.@id);
            this.projectiles_[_local4] = new ProjectileProperties(_local2);
        }
        this.angleCorrection_ = ((_arg1.hasOwnProperty("AngleCorrection")) ? ((Number(_arg1.AngleCorrection) * Math.PI) / 4) : 0);
        this.rotation_ = ((_arg1.hasOwnProperty("Rotation")) ? _arg1.Rotation : 0);
        if (_arg1.hasOwnProperty("BloodProb")) {
            this.bloodProb_ = Number(_arg1.BloodProb);
        }
        if (_arg1.hasOwnProperty("BloodColor")) {
            this.bloodColor_ = uint(_arg1.BloodColor);
        }
        if (_arg1.hasOwnProperty("ShadowColor")) {
            this.shadowColor_ = uint(_arg1.ShadowColor);
        }
        for each (_local3 in _arg1.Sound) {
            if (this.sounds_ == null) {
                this.sounds_ = {};
            }
            this.sounds_[int(_local3.@id)] = _local3.toString();
        }
        if (_arg1.hasOwnProperty("Portrait")) {
            this.portrait_ = new TextureDataConcrete(XML(_arg1.Portrait));
        }
        if (_arg1.hasOwnProperty("WhileMoving")) {
            this.whileMoving_ = new WhileMovingProperties(XML(_arg1.WhileMoving));
        }
    }

    public function loadSounds():void {
        var _local1:String;
        if (this.sounds_ == null) {
            return;
        }
        for each (_local1 in this.sounds_) {
            SoundEffectLibrary.load(_local1);
        }
    }

    public function getSize():int {
        if (this.minSize_ == this.maxSize_) {
            return (this.minSize_);
        }
        var _local1:int = ((this.maxSize_ - this.minSize_) / this.sizeStep_);
        return ((this.minSize_ + (int((Math.random() * _local1)) * this.sizeStep_)));
    }


}
}
class WhileMovingProperties {

    public var z_:Number = 0;
    public var flying_:Boolean = false;

    public function WhileMovingProperties(_arg1:XML) {
        if (_arg1.hasOwnProperty("Z")) {
            this.z_ = Number(_arg1.Z);
        }
        this.flying_ = _arg1.hasOwnProperty("Flying");
    }

}

