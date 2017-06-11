﻿package com.company.assembleegameclient.sound {
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

    public static var fadeOut_:Number = 0;
    public static var fadeIn_:Number = 0.3;
    private static var currentMusic:Sound = null;
    private static var musicChannel:SoundChannel = null;
    private static var musicTransform:SoundTransform = null;
    private static var newMusic:Sound = null;
    private static var newMusicChannel:SoundChannel = null;
    private static var newMusicTransform:SoundTransform = null;
    private static var musicDict:Dictionary = new Dictionary();
    private static var musicSelection:String = "";
    public static var musicTrack:String = "";

        musicSelection = song;
        if (musicTrack == musicSelection || !Parameters.data_.playMusic) {
            return;
        }
        musicTrack = musicSelection;
        var songLink:* = "core.nillysrealm.com/music/" + song + ".mp3";
        newMusic = musicDict[song];
        if (newMusic == null || newMusic.bytesLoaded <= 0) {
            newMusic = new Sound();
            newMusic.load(new URLRequest(songLink));
            musicDict[songLink] = newMusic;
        }
        if (currentMusic != null) {
            newMusicTransform = new SoundTransform(0);
            if (fadeOut_ > 0) {
                newMusicChannel.stop();
            }
            newMusicChannel = newMusic.play(0, int.MAX_VALUE, newMusicTransform);
            if (fadeOut_ <= 0)
            {
                fadeOut_ = 0.3;
                fadeIn_ = 0;
            }
            return;
        }
        currentMusic = newMusic;
        musicTransform = new SoundTransform(!!Parameters.data_.playMusic?Number(0.3):Number(0));
        musicChannel = currentMusic.play(0, int.MAX_VALUE, musicTransform);
    }

    public static function setPlayMusic(_arg1:Boolean):void {
        Parameters.data_.playMusic = _arg1;
        Parameters.save();
        load(musicSelection);
        if (!Parameters.data_.playMusic && newMusicChannel != null) {
            newMusicChannel.soundTransform.volume = 0;
        }
        if (musicChannel != null) {
            musicChannel.soundTransform = new SoundTransform(!!Parameters.data_.playMusic?Number(0.3):Number(0));
        }
    }

    public static function setMusicVolume(_arg1:Number):void {
        Parameters.data_.musicVolume = _arg1;
        Parameters.save();
        if (!Parameters.data_.playMusic) {
            return;
        }
        if (musicTransform != null) {
            musicTransform.volume = _arg1;
        }
        else {
            musicTransform = new SoundTransform(_arg1);
        }
        musicChannel.soundTransform = musicTransform;
    }

    public static function UpdateFade() : void {
        if (musicChannel == null) {
            return;
        }
        if (fadeIn_ < 0.3) {
            if (!Parameters.data_.playMusic) {
                fadeIn_ = 0.3;
                fadeOut_ = 0;
                musicTransform.volume = 0;
                newMusicTransform.volume = 0;
            }
            else {
                fadeIn_ = fadeIn_ + 0.0025;
                fadeOut_ = fadeOut_ + 0.0025;
                musicTransform.volume = fadeOut_;
                newMusicTransform.volume = fadeIn_;
                musicChannel.soundTransform = musicTransform;
                newMusicChannel.soundTransform = newMusicTransform;
                if (fadeIn_ < 0.3) {
                    return
                }
                musicTransform.volume = 0;
                newMusicTransform.volume = 0.3;
            }
            musicChannel.stop();
            musicTransform = newMusicTransform;
            currentMusic = newMusic;
            musicChannel = newMusicChannel;
            musicChannel.soundTransform = musicTransform;
        }
    }
}
}
