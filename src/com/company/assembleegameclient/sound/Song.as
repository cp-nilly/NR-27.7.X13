package com.company.assembleegameclient.sound {
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class Song {

    public var sound:Sound;
    private var transform:SoundTransform;
    public var channel:SoundChannel;

    public function Song(name:String, volume:Number = 1.0) {
        var setup:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        sound = new Sound();
        sound.load(new URLRequest(setup.getAppEngineUrl() + "/music/" + name + ".mp3"));
        transform = new SoundTransform(volume);
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
            transform.volume = volume;
            channel.soundTransform = transform;
        }
    }


}
}
