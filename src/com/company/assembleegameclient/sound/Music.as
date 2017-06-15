package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.googleanalytics.GA;

import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class Music {

    public static var currentSongName:String;
    private static var currentSong:Song;
    private static var fadeOutSong:Song;


    public static function load(songName:String):void {
        if(currentSongName == songName)
            return;
        currentSongName = songName;
        if(fadeOutSong)
            fadeOutSong.stop();
        fadeOutSong = currentSong;
        currentSong = new Song(songName, 0.0);
        currentSong.play();
    }

    public static function setPlayMusic(playMusic:Boolean):void {
        Parameters.data_.playMusic = playMusic;
        Parameters.save();
        currentSong.volume = Parameters.data_.playMusic ? Parameters.data_.musicVolume : 0.0;
        if(fadeOutSong)
            fadeOutSong.volume = 0.0;
    }

    public static function setMusicVolume(volume:Number):void {
        Parameters.data_.musicVolume = volume;
        Parameters.save();
        if(!Parameters.data_.playMusic) {
            return;
        }
        currentSong.volume = volume;
    }

    public static function updateFade(elapsedTime:int):void {
        if(!Parameters.data_.playMusic) {
            return;
        }
        var secondsToFade:Number = 4; //might be too long idk
        //climb to max volume over 'secondsToFade' seconds
        currentSong.volume = Math.min(Parameters.data_.musicVolume, currentSong.volume + ((elapsedTime / (secondsToFade * 1000)) * Parameters.data_.musicVolume));
        //descend to silence over 'secondsToFade' seconds
        if(fadeOutSong)
            fadeOutSong.volume = Math.max(0.0, fadeOutSong.volume - ((elapsedTime / (secondsToFade * 1000)) * Parameters.data_.musicVolume))
    }
}
}
