package kabam.rotmg.editor.view.components {
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.util.IntPoint;

public class SizeDropDown extends DropDown {

    protected var sizes_:Vector.<IntPoint>;

    public function SizeDropDown(_arg_1:Vector.<IntPoint>) {
        var _local_3:IntPoint;
        this.sizes_ = _arg_1;
        var _local_2:Vector.<String> = new Vector.<String>();
        for each (_local_3 in this.sizes_) {
            _local_2.push(((("" + _local_3.x_) + " x ") + _local_3.y_));
        }
        super(_local_2, 120, 26, "Size");
    }

    public function setSize(_arg_1:int, _arg_2:int):void {
        var _local_3:int;
        while (_local_3 < this.sizes_.length) {
            if ((((this.sizes_[_local_3].x_ == _arg_1)) && ((this.sizes_[_local_3].y_ == _arg_2)))) {
                setIndex(_local_3);
                return;
            }
            _local_3++;
        }
    }

    public function getSize():IntPoint {
        return (this.sizes_[getIndex()]);
    }


}
}
