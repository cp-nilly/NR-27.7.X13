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
    private static var musicVolumeTransform:SoundTransform;
    private static var musicChannel_:SoundChannel = null;
    private static var fadeTime:Number = 2;
    private static var musicName:String;
    private static var gt:GTween;
    private static var url:String;


    public static function init():void {
        musicVolumeTransform = new SoundTransform(0);
        gt = new GTween(musicVolumeTransform, fadeTime);
        gt.onChange = setTransform;
        var app:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        url = app.getAppEngineUrl(true) + "/music/{SONG}.mp3";
        load();
    }

    public static function load(name:String = "sorc"):void {
        if (musicName == name) {
            return;
        }
        musicName = name;

        if (musicChannel_ != null) {
            gt.setValue("volume", 0);
            gt.onComplete = startMusic;
            return;
        }

        startMusic();
    }

    private static function startMusic(tween:GTween = null):void {
        if (musicChannel_ != null) {
            musicChannel_.stop();
        }

        if (musicName == null || musicName == "") {
            return;
        }

        music_ = new Sound();
        music_.load(new URLRequest(url.replace("{SONG}", musicName)));
        musicChannel_ = music_.play(0, int.MAX_VALUE, musicVolumeTransform);
        gt.setValue("volume", Parameters.data_.playMusic ? Parameters.data_.musicVolume : 0);
        gt.onComplete = null;
    }

    private static function setTransform(tween:GTween):void {
        if (musicChannel_ != null) {
            musicChannel_.soundTransform = musicVolumeTransform;
        }
    }

    public static function setPlayMusic(playMusic:Boolean):void {
        Parameters.data_.playMusic = playMusic;
        Parameters.save();
        var vol:Number = playMusic ? Parameters.data_.musicVolume : 0;
        gt.setValue("volume", vol);
        musicVolumeTransform.volume = vol;
    }

    public static function setMusicVolume(newVol:Number):void {
        Parameters.data_.musicVolume = newVol;
        Parameters.save();
        if (!Parameters.data_.playMusic) {
            return;
        }
        gt.setValue("volume", newVol);
        musicVolumeTransform.volume = newVol;
    }


}
}
