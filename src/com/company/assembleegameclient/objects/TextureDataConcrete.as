package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.appengine.RemoteTexture;
import com.company.assembleegameclient.objects.particles.EffectProperties;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.utils.Dictionary;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class TextureDataConcrete extends TextureData {

    public static var remoteTexturesUsed:Boolean = false;

    private var isUsingLocalTextures:Boolean;
    private var remoteTexture:Boolean;
    private var texId:String;
    
    public function TextureDataConcrete(_arg1:XML) {
        var _local2:XML;
        super();
        this.isUsingLocalTextures = this.getWhetherToUseLocalTextures();
        if (_arg1.hasOwnProperty("Texture")) {
            this.parse(XML(_arg1.Texture));
        }
        else {
            if (_arg1.hasOwnProperty("AnimatedTexture")) {
                this.parse(XML(_arg1.AnimatedTexture));
            }
            else {
                if (_arg1.hasOwnProperty("RemoteTexture")) {
                    this.parse(XML(_arg1.RemoteTexture));
                }
                else {
                    if (_arg1.hasOwnProperty("RandomTexture")) {
                        this.parse(XML(_arg1.RandomTexture));
                    }
                    else {
                        this.parse(_arg1);
                    }
                }
            }
        }
        for each (_local2 in _arg1.AltTexture) {
            this.parse(_local2);
        }
        if (_arg1.hasOwnProperty("Mask")) {
            this.parse(XML(_arg1.Mask));
        }
        if (_arg1.hasOwnProperty("Effect")) {
            this.parse(XML(_arg1.Effect));
        }
    }

    override public function getTexture(_arg1:int = 0):BitmapData {
        if (randomTextureData_ == null) {
            return (texture_);
        }
        var _local2:TextureData = randomTextureData_[(_arg1 % randomTextureData_.length)];
        return (_local2.getTexture(_arg1));
    }

    override public function getAltTextureData(_arg1:int):TextureData {
        if (altTextures_ == null) {
            return (null);
        }
        return (altTextures_[_arg1]);
    }

    private function getWhetherToUseLocalTextures():Boolean {
        var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        return (_local1.useLocalTextures());
    }

    private function parse(xml:XML):void {
        var image:MaskedImage;
        var remoteTexture:RemoteTexture;
        var childXML:XML;
        switch (xml.name().toString()) {
            case "Texture":
                try {
                    texture_ = AssetLibrary.getImageFromSet(String(xml.File), int(xml.Index));
                }
                catch (error:Error) {
                    throw (new Error(((("Error loading Texture - name: " + String(xml.File)) + " - idx: ") + int(xml.Index))));
                }
                return;
            case "Mask":
                mask_ = AssetLibrary.getImageFromSet(String(xml.File), int(xml.Index));
                return;
            case "Effect":
                effectProps_ = new EffectProperties(xml);
                return;
            case "AnimatedTexture":
                animatedChar_ = AnimatedChars.getAnimatedChar(String(xml.File), int(xml.Index));
                try {
                    image = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0);
                    texture_ = image.image_;
                    mask_ = image.mask_;
                }
                catch (error:Error) {
                    throw (new Error(((("Error loading AnimatedTexture - name: " + String(xml.File)) + " - idx: ") + int(xml.Index))));
                }
                return;
            case "RemoteTexture":
                texture_ = AssetLibrary.getImageFromSet("lofiObj3", 0xFF);
                
                this.remoteTexture = true;
                var id:Array = xml.Id.split(":");
                this.texId = id[0];
                if (id.length > 1)
                    this.texId = id[1];
                
                /*if (this.isUsingLocalTextures) {
                    remoteTexture = new RemoteTexture(xml.Id, xml.Instance, this.onRemoteTexture);
                    remoteTexture.run();
                    if (!AssetLoader.currentXmlIsTesting) {
                        remoteTexturesUsed = true;
                    }
                }*/
                
                remoteTextureDir_ = ((xml.hasOwnProperty("Right")) ? AnimatedChar.RIGHT : AnimatedChar.DOWN);
                return;
            case "RandomTexture":
                randomTextureData_ = new Vector.<TextureData>();
                for each (childXML in xml.children()) {
                    randomTextureData_.push(new TextureDataConcrete(childXML));
                }
                return;
            case "AltTexture":
                if (altTextures_ == null) {
                    altTextures_ = new Dictionary();
                }
                altTextures_[int(xml.@id)] = new TextureDataConcrete(xml);
                return;
        }
    }

    public function onRemoteTexture(_arg1:BitmapData, _arg2:BitmapData = null):void {
        if (_arg1.width > 16) {
            var height:int;
            if (_arg1.height > 16)
                height = _arg1.height / 3;
            else
                height = _arg1.height;
            
            AnimatedChars.add("remoteTexture", _arg1, _arg2, (_arg1.width / 7), height, _arg1.width, _arg1.height, remoteTextureDir_);
            animatedChar_ = AnimatedChars.getAnimatedChar("remoteTexture", 0);
            texture_ = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0).image_;
        }
        else {
            texture_ = _arg1;
        }
    }
    
    public function isRemoteTexture():Boolean {
        return this.remoteTexture;
    }
    
    public function id():String {
        return this.texId;
    }
    
    
}
}
