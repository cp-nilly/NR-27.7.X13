package kabam.rotmg.arena.util {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class ArenaViewAssetFactory {


    public static function returnTextfield(_arg1:int, _arg2:int, _arg3:Boolean, _arg4:Boolean = false):TextFieldDisplayConcrete {
        var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local5.setSize(_arg2).setColor(_arg1).setBold(_arg3);
        _local5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        _local5.filters = ((_arg4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local5);
    }

    public static function returnHostBitmap(_arg1:uint):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg1, 80, true)));
    }


}
}
