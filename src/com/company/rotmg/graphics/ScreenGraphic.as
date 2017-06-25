package com.company.rotmg.graphics {
import flash.display.*;

[Embed(source="ScreenGraphic.swf", symbol="com.company.rotmg.graphics.ScreenGraphic")]
public dynamic class ScreenGraphic extends MovieClip {
    public function ScreenGraphic() {
        this.width = WebMain.STAGE.stageWidth;
        this.y += WebMain.STAGE.stageHeight - 600;
    }
}
}
