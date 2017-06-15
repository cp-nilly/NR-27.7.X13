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

    private static var fadeTime:Number = 2;
    private static var musicName:String;

    private static var currentSong:Song;
    private static var currentSongTween:GTween;

    private static var fadeOutSong:Song;
    private static var fadeOutTween:GTween;


    public static function init():void {
        currentSongTween = new GTween(currentSong, fadeTime);
        fadeOutTween = new GTween(fadeOutSong, fadeTime);
        fadeOutTween.onComplete = stopMusic;
    }

    public static function load(name:String):void {
        if (musicName == name) {
            return;
        }
        musicName = name;

        if (currentSong != null) {
            stopMusic();
            fadeOutSong = currentSong;
            fadeOutTween.setValue("volume", 0);
        }

        startNewMusic();
    }

    private static function stopMusic(tween:GTween = null):void {
        if(fadeOutSong)
            fadeOutSong.stop()
    }

    private static function startNewMusic(tween:GTween = null):void {
        if (musicName == null || musicName == "") {
            return;
        }

        currentSong = new Song(musicName, 0);
        currentSong.play();
        currentSongTween.setValue("volume", Parameters.data_.playMusic ? Parameters.data_.musicVolume : 0);
    }

    public static function setPlayMusic(playMusic:Boolean):void {
        Parameters.data_.playMusic = playMusic;
        Parameters.save();

        var vol:Number = playMusic ? Parameters.data_.musicVolume : 0;
        currentSongTween.setValue("volume", vol);
        currentSong.volume = 0;
    }

    public static function setMusicVolume(newVol:Number):void {
        Parameters.data_.musicVolume = newVol;
        Parameters.save();
        if (!Parameters.data_.playMusic) {
            return;
        }
        currentSongTween.setValue("volume", newVol);
        currentSong.volume = newVol;
    }


}
}
