package kabam.rotmg.editor.view.components.preview {
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.BitmapData;

public class ObjectPreview extends Preview {

    public function ObjectPreview(_arg_1:int, _arg_2:int) {
        super(_arg_1, _arg_2);
    }

    override public function redraw():void {
        super.redraw();
        if (origBitmapData_ == null) {
            return;
        }
        var _local_1:BitmapData = TextureRedrawer.redraw(origBitmapData_, size_, true, 0, false);
        bitmap_.bitmapData = _local_1;
    }


}
}
