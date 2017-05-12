package kabam.rotmg.assets.services {
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;

import kabam.rotmg.assets.model.Animation;
import kabam.rotmg.assets.model.CharacterTemplate;

public class CharacterFactory {

    private var texture1:int;
    private var texture2:int;
    private var size:int;


    public function makeCharacter(_arg1:CharacterTemplate):AnimatedChar {
        return (AnimatedChars.getAnimatedChar(_arg1.file, _arg1.index));
    }

    public function makeIcon(_arg1:CharacterTemplate, _arg2:int = 100, _arg3:int = 0, _arg4:int = 0):BitmapData {
        this.texture1 = _arg3;
        this.texture2 = _arg4;
        this.size = _arg2;
        var _local5:AnimatedChar = this.makeCharacter(_arg1);
        var _local6:BitmapData = this.makeFrame(_local5, AnimatedChar.STAND, 0);
        _local6 = GlowRedrawer.outlineGlow(_local6, 0);
        _local6 = BitmapUtil.cropToBitmapData(_local6, 6, 6, (_local6.width - 12), (_local6.height - 6));
        return (_local6);
    }

    public function makeWalkingIcon(_arg1:CharacterTemplate, _arg2:int = 100, _arg3:int = 0, _arg4:int = 0):Animation {
        this.texture1 = _arg3;
        this.texture2 = _arg4;
        this.size = _arg2;
        var _local5:AnimatedChar = this.makeCharacter(_arg1);
        var _local6:BitmapData = this.makeFrame(_local5, AnimatedChar.WALK, 0.5);
        _local6 = GlowRedrawer.outlineGlow(_local6, 0);
        var _local7:BitmapData = this.makeFrame(_local5, AnimatedChar.WALK, 0);
        _local7 = GlowRedrawer.outlineGlow(_local7, 0);
        var _local8:Animation = new Animation();
        _local8.setFrames(_local6, _local7);
        return (_local8);
    }

    private function makeFrame(_arg1:AnimatedChar, _arg2:int, _arg3:Number):BitmapData {
        var _local4:MaskedImage = _arg1.imageFromDir(AnimatedChar.RIGHT, _arg2, _arg3);
        return (TextureRedrawer.resize(_local4.image_, _local4.mask_, this.size, false, this.texture1, this.texture2));
    }


}
}
