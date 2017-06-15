package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.parameters.Parameters;
import com.gskinner.motion.GTween;

import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class Music {

    private static var music_:Sound = null;
    private static var fadeTime:Number = 2;
    private static var musicName:String;
    private static var url:String;

    private static var musicVolumeTransform:SoundTransform;
    private static var musicChannel_:SoundChannel;
    private static var musicTween:GTween;

    private static var fadeOutVolumeTransform:SoundTransform;
    private static var fadeOutChannel_:SoundChannel;
    private static var fadeOutTween:GTween;


    public static function init():void {
        musicVolumeTransform = new SoundTransform(0);
        musicTween = new GTween(musicVolumeTransform, fadeTime);
        musicTween.onChange = setMusicVolTransform;
        fadeOutVolumeTransform = new SoundTransform(0);
        fadeOutTween = new GTween(fadeOutVolumeTransform, fadeTime);
        fadeOutTween.onChange = setFadeOutVolTransform;
        fadeOutTween.onComplete = stopMusic;
        var app:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        url = app.getAppEngineUrl(true) + "/music/{SONG}.mp3";
    }

    public static function load(name:String):void {
        if (musicName == name) {
            return;
        }
        musicName = name;

        if (musicChannel_ != null) {
            stopMusic();
            fadeOutVolumeTransform.volume = musicChannel_.soundTransform.volume;
            fadeOutChannel_ = musicChannel_;
            fadeOutChannel_.soundTransform = fadeOutVolumeTransform;
            fadeOutTween.setValue("volume", 0);
        }

        startNewMusic();
    }

    private static function stopMusic(tween:GTween = null):void {
        if (fadeOutChannel_ != null) {
            fadeOutChannel_.stop();
            fadeOutChannel_ = null;
        }
    }

    private static function startNewMusic(tween:GTween = null):void {
        musicChannel_ = null;

        if (musicName == null || musicName == "") {
            return;
        }

        music_ = new Sound();
        music_.load(new URLRequest(url.replace("{SONG}", musicName)));
        musicChannel_ = music_.play(0, int.MAX_VALUE, musicVolumeTransform);
        musicTween.setValue("volume", Parameters.data_.playMusic ? Parameters.data_.musicVolume : 0);
    }

    private static function setMusicVolTransform(tween:GTween):void {
        if (musicChannel_ != null) {
            musicChannel_.soundTransform = musicVolumeTransform;
        }
    }

    private static function setFadeOutVolTransform(tween:GTween):void {
        if (fadeOutChannel_ != null) {
            fadeOutChannel_.soundTransform = fadeOutVolumeTransform;
        }
    }

    public static function setPlayMusic(playMusic:Boolean):void {
        Parameters.data_.playMusic = playMusic;
        Parameters.save();

        var vol:Number = playMusic ? Parameters.data_.musicVolume : 0;
        musicTween.setValue("volume", vol);
        musicVolumeTransform.volume = vol;
    }

    public static function setMusicVolume(newVol:Number):void {
        Parameters.data_.musicVolume = newVol;
        Parameters.save();
        if (!Parameters.data_.playMusic) {
            return;
        }
        musicTween.setValue("volume", newVol);
        musicVolumeTransform.volume = newVol;
    }


}
}
