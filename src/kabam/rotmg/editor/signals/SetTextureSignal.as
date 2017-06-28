package kabam.rotmg.editor.signals {
import kabam.rotmg.editor.model.TextureData;

import org.osflash.signals.Signal;

public class SetTextureSignal extends Signal {

    public function SetTextureSignal() {
        super(TextureData);
    }

}
}
