package kabam.rotmg.editor.view.components {
import com.company.util.IntPoint;

public class TextileSizeDropDown extends SizeDropDown {

    private static const SIZES:Vector.<IntPoint> = new <IntPoint>[new IntPoint(4, 4), new IntPoint(5, 5), new IntPoint(9, 9), new IntPoint(10, 10)];

    public function TextileSizeDropDown() {
        super(SIZES);
    }

}
}
