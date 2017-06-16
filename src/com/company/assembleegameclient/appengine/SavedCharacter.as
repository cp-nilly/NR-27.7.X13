package com.company.assembleegameclient.appengine {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.CachingColorTransformer;

import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;

public class SavedCharacter {

    private static const notAvailableCT:ColorTransform = new ColorTransform(0, 0, 0, 0.5, 0, 0, 0, 0);
    private static const dimCT:ColorTransform = new ColorTransform(0.75, 0.75, 0.75, 1, 0, 0, 0, 0);

    public var charXML_:XML;
    public var name_:String = null;
    private var pet:PetVO;

    public function SavedCharacter(_arg1:XML, _arg2:String) {
        var _local3:XML;
        var _local4:int;
        var _local5:PetVO;
        super();
        this.charXML_ = _arg1;
        this.name_ = _arg2;
        if (this.charXML_.hasOwnProperty("Pet")) {
            _local3 = new XML(this.charXML_.Pet);
            _local4 = _local3.@instanceId;
            _local5 = StaticInjectorContext.getInjector().getInstance(PetsModel).getPetVO(_local4);
            _local5.apply(_local3);
            this.setPetVO(_local5);
        }
    }

    public static function getImage(_arg1:SavedCharacter, _arg2:XML, _arg3:int, _arg4:int, _arg5:Number, available:Boolean, active:Boolean):BitmapData {
        var _local8:AnimatedChar = AnimatedChars.getAnimatedChar(String(_arg2.AnimatedTexture.File), int(_arg2.AnimatedTexture.Index));
        var _local9:MaskedImage = _local8.imageFromDir(_arg3, _arg4, _arg5);
        var _local10:int = (((_arg1) != null) ? _arg1.tex1() : null);
        var _local11:int = (((_arg1) != null) ? _arg1.tex2() : null);
        var _local12:BitmapData = TextureRedrawer.resize(_local9.image_, _local9.mask_, 100, false, _local10, _local11);
        _local12 = GlowRedrawer.outlineGlow(_local12, 0);
        if (!available) {
            _local12 = CachingColorTransformer.transformBitmapData(_local12, notAvailableCT);
        }
        else {
            if (!active) {
                _local12 = CachingColorTransformer.transformBitmapData(_local12, dimCT);
            }
        }
        return (_local12);
    }

    public static function compare(_arg1:SavedCharacter, _arg2:SavedCharacter):Number {
        var _local3:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg1.charId())) ? Parameters.data_.charIdUseMap[_arg1.charId()] : 0);
        var _local4:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg2.charId())) ? Parameters.data_.charIdUseMap[_arg2.charId()] : 0);
        if (_local3 != _local4) {
            return ((_local4 - _local3));
        }
        return ((_arg2.xp() - _arg1.xp()));
    }


    public function charId():int {
        return (int(this.charXML_.@id));
    }

    public function name():String {
        return (this.name_);
    }

    public function objectType():int {
        return (int(this.charXML_.ObjectType));
    }

    public function skinType():int {
        return (int(this.charXML_.Texture));
    }

    public function level():int {
        return (int(this.charXML_.Level));
    }

    public function tex1():int {
        return (int(this.charXML_.Tex1));
    }

    public function tex2():int {
        return (int(this.charXML_.Tex2));
    }

    public function xp():int {
        return (int(this.charXML_.Exp));
    }

    public function fame():int {
        return (int(this.charXML_.CurrentFame));
    }

    public function displayId():String {
        return (ObjectLibrary.typeToDisplayId_[this.objectType()]);
    }

    public function getPetVO():PetVO {
        return (this.pet);
    }

    public function setPetVO(_arg1:PetVO):void {
        this.pet = _arg1;
    }


}
}
