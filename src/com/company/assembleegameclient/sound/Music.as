package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.googleanalytics.GA;

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
    private static var volume:Number = 0.3;


    public static function load():void {
        var _local1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        var _local2 = (_local1.getAppEngineUrl(true) + "/music/sorc.mp3");
        volume = Parameters.data_.musicVolume;
        musicVolumeTransform = new SoundTransform(((Parameters.data_.playMusic) ? volume : 0));
        music_ = new Sound();
        music_.load(new URLRequest(_local2));
        musicChannel_ = music_.play(0, int.MAX_VALUE, musicVolumeTransform);
    }

    public static function setPlayMusic(_arg1:Boolean):void {
        GA.global().trackEvent("sound", ((_arg1) ? "musicOn" : "musicOff"));
        Parameters.data_.playMusic = _arg1;
        Parameters.save();
        musicVolumeTransform.volume = ((Parameters.data_.playMusic) ? volume : 0);
        musicChannel_.soundTransform = musicVolumeTransform;
    }

    public static function setMusicVolume(_arg1:Number):void {
        Parameters.data_.musicVolume = _arg1;
        Parameters.save();
        if (!Parameters.data_.playMusic) {
            return;
        }
        if (musicVolumeTransform != null) {
            musicVolumeTransform.volume = _arg1;
        }
        else {
            musicVolumeTransform = new SoundTransform(_arg1);
        }
        musicChannel_.soundTransform = musicVolumeTransform;
    }


}
}
