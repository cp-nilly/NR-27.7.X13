package kabam.rotmg.game.model {
import com.company.assembleegameclient.objects.GameObject;

public class AddSpeechBalloonVO {

    public var go:GameObject;
    public var text:String;
    public var name:String;
    public var isTrade:Boolean;
    public var isGuild:Boolean;
    public var background:uint;
    public var backgroundAlpha:Number;
    public var outline:uint;
    public var outlineAlpha:uint;
    public var textColor:uint;
    public var lifetime:int;
    public var bold:Boolean;
    public var hideable:Boolean;

    public function AddSpeechBalloonVO(_arg1:GameObject, _arg2:String, _arg3:String, _arg4:Boolean, _arg5:Boolean, _arg6:uint, _arg7:Number, _arg8:uint, _arg9:Number, _arg10:uint, _arg11:int, _arg12:Boolean, _arg13:Boolean) {
        this.go = _arg1;
        this.text = _arg2;
        this.name = _arg3;
        this.isTrade = _arg4;
        this.isGuild = _arg5;
        this.background = _arg6;
        this.backgroundAlpha = _arg7;
        this.outline = _arg8;
        this.outlineAlpha = _arg9;
        this.textColor = _arg10;
        this.lifetime = _arg11;
        this.bold = _arg12;
        this.hideable = _arg13;
    }

}
}
