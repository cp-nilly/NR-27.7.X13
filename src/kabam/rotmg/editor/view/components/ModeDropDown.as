package kabam.rotmg.editor.view.components {
import com.company.assembleegameclient.ui.dropdown.DropDown;

public class ModeDropDown extends DropDown {

    public static const OBJECTS:String = "Objects";
    public static const CHARACTERS:String = "Characters";
    public static const TEXTILES:String = "Textiles";

    public function ModeDropDown() {
        super(new <String>[OBJECTS, CHARACTERS, TEXTILES], 120, 26, "Mode");
    }

}
}
