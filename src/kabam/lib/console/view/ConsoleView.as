package kabam.lib.console.view {
import flash.display.Sprite;

public final class ConsoleView extends Sprite {

    public var output:ConsoleOutputView;
    public var input:ConsoleInputView;

    public function ConsoleView() {
        addChild((this.output = new ConsoleOutputView()));
        addChild((this.input = new ConsoleInputView()));
    }

    override public function set visible(_arg1:Boolean):void {
        super.visible = _arg1;
        if (((_arg1) && (stage))) {
            stage.focus = this.input;
        }
    }


}
}
