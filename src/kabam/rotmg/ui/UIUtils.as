package kabam.rotmg.ui {
import flash.display.Sprite;
import flash.display.StageQuality;

public class UIUtils {

    private static const NOTIFICATION_BACKGROUND_WIDTH:Number = 95;
    public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
    private static const NOTIFICATION_BACKGROUND_ALPHA:Number = 0.4;
    private static const NOTIFICATION_BACKGROUND_COLOR:Number = 0;
    public static const EXPERIMENTAL_MENU_PASSWORD:String = "decamenu";
    public static const NOTIFICATION_SPACE:uint = 28;

    public static var SHOW_EXPERIMENTAL_MENU:Boolean = false;


    public static function makeStaticHUDBackground():Sprite {
        var _local1:Number = NOTIFICATION_BACKGROUND_WIDTH;
        var _local2:Number = NOTIFICATION_BACKGROUND_HEIGHT;
        return (makeHUDBackground(_local1, _local2));
    }

    public static function makeHUDBackground(_arg1:Number, _arg2:Number):Sprite {
        var _local3:Sprite = new Sprite();
        return (drawHUDBackground(_local3, _arg1, _arg2));
    }

    private static function drawHUDBackground(_arg1:Sprite, _arg2:Number, _arg3:Number):Sprite {
        _arg1.graphics.beginFill(NOTIFICATION_BACKGROUND_COLOR, NOTIFICATION_BACKGROUND_ALPHA);
        _arg1.graphics.drawRoundRect(0, 0, _arg2, _arg3, 12, 12);
        _arg1.graphics.endFill();
        return (_arg1);
    }

    public static function toggleQuality(_arg1:Boolean):void {
        if (WebMain.STAGE != null) {
            WebMain.STAGE.quality = ((_arg1) ? StageQuality.HIGH : StageQuality.LOW);
        }
    }


}
}
