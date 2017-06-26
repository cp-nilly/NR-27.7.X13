package kabam.rotmg.assets {
import mx.core.*;

[Embed(source="EmbeddedAssets_DarknessBackground.png")]
public class EmbeddedAssets_DarknessBackground extends BitmapAsset {
    public function EmbeddedAssets_DarknessBackground() {
        this.width = WebMain.STAGE.stageWidth - 200;
        this.height = this.width * 5 / 3;
        this.x = -this.width / 2;
        this.y = -this.height / 2;
        this.alpha = 0.95;
    }
}
}
