package kabam.rotmg.editor.view.components.loaddialog {
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.editor.model.TextureData;

import org.osflash.signals.Signal;

public class ResultsBoxes extends Sprite {

    public const selected:Signal = new Signal();

    protected var resultBoxes_:Vector.<ResultsBox>;
    public var offset_:int;
    public var num_:int;
    protected var cols_:int;
    protected var rows_:int;

    public function ResultsBoxes(_arg_1:XML, _arg_2:int, _arg_3:int) {
        var _local_7:XML;
        var _local_8:ResultsBox;
        this.resultBoxes_ = new Vector.<ResultsBox>();
        super();
        this.offset_ = int(_arg_1.@offset);
        this.num_ = 0;
        this.cols_ = _arg_2;
        this.rows_ = _arg_3;
        var _local_4:int;
        var _local_5:int;
        var _local_6:Boolean = _arg_1.hasOwnProperty("Admin");
        for each (_local_7 in _arg_1.Pic) {
            _local_8 = new ResultsBox(_local_7, _local_6);
            _local_8.x = (_local_4 * ResultsBox.WIDTH);
            _local_8.y = (_local_5 * ResultsBox.HEIGHT);
            _local_8.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            addChild(_local_8);
            this.num_++;
            _local_4 = ((_local_4 + 1) % _arg_2);
            if (_local_4 == 0) {
                if (++_local_5 >= _arg_3) break;
            }
        }
    }

    private function onMouseClick(_arg_1:MouseEvent):void {
        var _local_3:TextureData;
        var _local_2:ResultsBox = (_arg_1.target as ResultsBox);
        if (_local_2.bitmapData_ != null) {
            _local_3 = new TextureData();
            _local_3.name = _local_2.name_;
            _local_3.type = _local_2.pictureType_;
            _local_3.tags = _local_2.tags_;
            _local_3.bitmapData = _local_2.bitmapData_;
            this.selected.dispatch(_local_3);
        }
    }


}
}
