package kabam.rotmg.editor.view.components {
import com.company.util.IntPoint;

public class ObjectSizeDropDown extends SizeDropDown {

    private static const SIZES:Vector.<IntPoint> = new <IntPoint>[new IntPoint(8, 8), new IntPoint(16, 8), new IntPoint(16, 16)];

    public function ObjectSizeDropDown() {
        super(SIZES);
    }

}
}
