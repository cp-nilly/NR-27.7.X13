package com.company.assembleegameclient.sound {
import com.gskinner.motion.GTween;

import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class Song {

    private var sound:Sound;
    private var transform:SoundTransform;
    private var channel:SoundChannel;
    private var tween:GTween;

    public var isSmoothFade:Boolean;
    public var fadeTime:Number;


    public function Song(name:String, volume:Number = 1.0, isSmoothFade:Boolean = true, fadeTime:Number = 4) {
        this.isSmoothFade = isSmoothFade;
        this.fadeTime = fadeTime;
        var setup:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        sound = new Sound();
        sound.load(new URLRequest(setup.getAppEngineUrl() + "/music/" + name + ".mp3"));
        transform = new SoundTransform(volume);
        tween = new GTween(transform, fadeTime);
        tween.onChange = updateVolume;
    }

    public function play(loops:int = int.MAX_VALUE):void {
        channel = sound.play(0, loops, transform);
    }

    public function stop():void {
        channel.stop()
    }

    public function get volume():Number {
        return transform.volume;
    }

    public function set volume(volume:Number):void {
        if(channel) {
            if(isSmoothFade) {
                tween.setValue("volume", volume);
            }
            else {
                transform.volume = volume;
                channel.soundTransform = transform;
            }
        }
    }

    private function updateVolume(tween:GTween = null):void {
        channel.soundTransform = transform;
    }


}
}
