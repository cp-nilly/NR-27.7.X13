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


    public function Song(name:String) {
        var setup:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        sound = new Sound();
        sound.load(new URLRequest(setup.getAppEngineUrl() + "/music/" + name + ".mp3"));
        transform = new SoundTransform(0);
        tween = new GTween(transform);
        tween.onChange = updateTransform;
    }

    public function play(volume:Number = 1.0, fadeTime:Number = 2, loops:int = int.MAX_VALUE):void {
        if (channel) {
            channel.stop();
        }
        tween.duration = fadeTime;
        tween.setValue("volume", volume);
        channel = sound.play(0, loops, transform);
    }

    public function stop(noFade:Boolean = false):void {
        if (channel) {
            tween.onComplete = stopChannel;
            tween.setValue("volume", 0);
            if (noFade) {
                transform.volume = 0;
            }
        }
    }

    public function get volume():Number {
        return transform.volume;
    }

    public function set volume(volume:Number):void {
        transform.volume = volume;
        tween.setValue("volume", volume);
    }

    private function updateTransform(tween:GTween = null):void {
        if (channel) {
            channel.soundTransform = transform;
        }
    }

    private function stopChannel(tween:GTween):void {
        channel.stop();
        channel = null;
    }


}
}
