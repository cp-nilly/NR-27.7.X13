package {
import flash.display.*;

[Embed(source="MapLoadingScreen.swf", symbol="MapLoadingScreen")]
public dynamic class MapLoadingScreen extends MovieClip {
    public function MapLoadingScreen() {
        super();
        return;
    }

    public var difficulty_indicators:MovieClip;

    public var mapNameContainer:MovieClip;

    public var bgGroup:MovieClip;
}
}
