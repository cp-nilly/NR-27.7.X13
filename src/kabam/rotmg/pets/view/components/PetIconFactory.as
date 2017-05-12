package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.pets.data.PetVO;

public class PetIconFactory {

    public var outlineSize:Number = 1.4;


    public function create(_arg1:PetVO, _arg2:int):PetIcon {
        var _local3:BitmapData = this.getPetSkinTexture(_arg1, _arg2);
        var _local4:Bitmap = new Bitmap(_local3);
        var _local5:PetIcon = new PetIcon(_arg1);
        _local5.setBitmap(_local4);
        return (_local5);
    }

    public function getPetSkinTexture(_arg1:PetVO, _arg2:int):BitmapData {
        var _local4:Number;
        var _local5:BitmapData;
        var _local3:BitmapData = ((_arg1.getSkinMaskedImage()) ? _arg1.getSkinMaskedImage().image_ : null);
        if (_local3) {
            _local4 = ((_arg2 - TextureRedrawer.minSize) / _local3.width);
            _local5 = TextureRedrawer.resize(_local3, _arg1.getSkinMaskedImage().mask_, 100, true, 0, 0, _local4);
            _local5 = GlowRedrawer.outlineGlow(_local5, 0, this.outlineSize);
            return (_local5);
        }
        return (new BitmapDataSpy(_arg2, _arg2));
    }


}
}
