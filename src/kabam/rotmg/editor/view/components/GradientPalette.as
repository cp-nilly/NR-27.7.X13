package kabam.rotmg.editor.view.components {
import com.company.color.RGB;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class GradientPalette extends Sprite {

    public static const BOX_SIZE:int = 12;
    public static const COLORS1:Vector.<Vector.<uint>> = new <Vector.<uint>>[new <uint>[0, 0x262626, 0x4D4D4D, 0x737373, 0x999999, 0xBFBFBF, 0xE6E6E6, 0xFFFFFF], new <uint>[7483, 15480, 23733, 30699, 2397439, 6534143, 11786751, 14413311], new <uint>[15156, 21578, 30826, 38019, 47267, 777926, 6553581, 12255223], new <uint>[15121, 21528, 30754, 37930, 47156, 777799, 6553487, 12189619], new <uint>[0x283B00, 0x3A5400, 0x527800, 0x659400, 0x7EB800, 10214923, 13565795, 15269816], new <uint>[0x3B3900, 0x545100, 0x787400, 0x948F00, 0xB8B200, 14604043, 16775779, 16776632], new <uint>[0x3B2A00, 0x543C00, 0x785600, 0x946A00, 0xB88400, 14590475, 16765795, 16772024], new <uint>[0x3B1200, 0x541900, 0x782400, 0x942C00, 0xB83700, 14567947, 16749155, 16764344]];
    public static const COLORS2:Vector.<Vector.<uint>> = new <Vector.<uint>>[new <uint>[0x3B0000, 0x780000, 0xB50000, 14556445, 16730698, 16745861, 16757683, 16767963], new <uint>[0x4F001D, 0x780040, 0xB5006D, 0xE3006E, 16730764, 16745905, 16757711, 16767976], new <uint>[0x4E004F, 0x770078, 11154347, 13847252, 14642912, 14656736, 15583981, 16767999], new <uint>[0x22004F, 0x340078, 6763435, 8735444, 10448608, 12494048, 14273261, 15391743], new <uint>[65615, 131192, 3486635, 4999892, 7368416, 10855648, 13355757, 14474239], new <uint>[4413806, 5006200, 5139591, 6258588, 6918840, 7710420, 8368350, 10010595], new <uint>[4484675, 5011532, 5211982, 6331487, 6994025, 7722101, 8445567, 10085272], new <uint>[7223327, 7879971, 8863005, 10241571, 12080942, 13919027, 14581590, 14913903]];

    public function GradientPalette() {
        this.addBoxes(COLORS1, 0);
        this.addBoxes(COLORS2, (BOX_SIZE * 8));
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
    }

    public function addBoxes(_arg_1:Vector.<Vector.<uint>>, _arg_2:int):void {
        var _local_3:int;
        var _local_4:int;
        var _local_5:RGB;
        var _local_6:PaletteBox;
        _local_3 = 0;
        while (_local_3 < _arg_1.length) {
            _local_4 = 0;
            while (_local_4 < _arg_1[_local_3].length) {
                _local_5 = RGB.fromColor(_arg_1[_local_3][_local_4]);
                _local_6 = new PaletteBox(BOX_SIZE, _local_5.toHSV(), true);
                _local_6.x = (_arg_2 + (_local_4 * BOX_SIZE));
                _local_6.y = (_local_3 * BOX_SIZE);
                addChild(_local_6);
                _local_4++;
            }
            _local_3++;
        }
    }

    public function onMouseDown(_arg_1:MouseEvent):void {
        var _local_2:PaletteBox = (_arg_1.target as PaletteBox);
        if (_local_2 != null) {
            dispatchEvent(new ColorEvent(_local_2.hsv_));
        }
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    private function onMouseMove(_arg_1:MouseEvent):void {
        var _local_2:PaletteBox = (_arg_1.target as PaletteBox);
        if (_local_2 != null) {
            dispatchEvent(new ColorEvent(_local_2.hsv_));
        }
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        var _local_2:PaletteBox = (_arg_1.target as PaletteBox);
        if (_local_2 != null) {
            dispatchEvent(new ColorEvent(_local_2.hsv_));
        }
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }


}
}
