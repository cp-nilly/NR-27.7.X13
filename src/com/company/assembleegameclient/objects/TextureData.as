package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.objects.particles.EffectProperties;
import com.company.assembleegameclient.util.AnimatedChar;

import flash.display.BitmapData;
import flash.utils.Dictionary;

public class TextureData {

    public var texture_:BitmapData = null;
    public var mask_:BitmapData = null;
    public var animatedChar_:AnimatedChar = null;
    public var randomTextureData_:Vector.<TextureData> = null;
    public var altTextures_:Dictionary = null;
    public var remoteTextureDir_:int;
    public var effectProps_:EffectProperties = null;


    public function getTexture(_arg1:int = 0):BitmapData {
        return (null);
    }

    public function getAltTextureData(_arg1:int):TextureData {
        return (null);
    }


}
}
