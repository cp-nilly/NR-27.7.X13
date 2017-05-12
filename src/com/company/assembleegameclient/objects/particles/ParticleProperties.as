package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.TextureData;
import com.company.assembleegameclient.objects.TextureDataConcrete;
import com.company.assembleegameclient.objects.animation.AnimationsData;

public class ParticleProperties {

    public var id_:String;
    public var textureData_:TextureData;
    public var size_:int = 100;
    public var z_:Number = 0;
    public var duration_:Number = 0;
    public var animationsData_:AnimationsData = null;

    public function ParticleProperties(_arg1:XML) {
        this.id_ = _arg1.@id;
        this.textureData_ = new TextureDataConcrete(_arg1);
        if (_arg1.hasOwnProperty("Size")) {
            this.size_ = Number(_arg1.Size);
        }
        if (_arg1.hasOwnProperty("Z")) {
            this.z_ = Number(_arg1.Z);
        }
        if (_arg1.hasOwnProperty("Duration")) {
            this.duration_ = Number(_arg1.Duration);
        }
        if (_arg1.hasOwnProperty("Animation")) {
            this.animationsData_ = new AnimationsData(_arg1);
        }
    }

}
}
