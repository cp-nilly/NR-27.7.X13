package kabam.rotmg.editor.signals {
import kabam.rotmg.editor.model.TextureData;

import org.osflash.signals.Signal;

public class SaveTextureSignal extends Signal {

    public function SaveTextureSignal() {
        super(TextureData);
    }

}
}
